import 'package:chordspro_dart/src/models/chord.dart';
import 'package:chordspro_dart/src/models/line/lyrics.dart';
import 'package:chordspro_dart/src/models/song.dart';

class GuessKey {
  final Map<String, List<String>> scales = {
    'A': ['A', 'Bm', 'C#m', 'D', 'E', 'F#m', 'G#'],
    'A#': ['A#', 'B#m', 'Dm', 'D#', 'E#', 'Gm', 'A'],
    'Bb': ['Bb', 'Cm', 'Dm', 'Eb', 'F', 'Gm', 'A'],
    'B': ['B', 'C#m', 'D#m', 'E', 'F#', 'G#m', 'A#'],
    'Cb': ['Cb', 'Dbm', 'Ebm', 'Fb', 'Gb', 'Abm', 'Bb'],
    'B#': ['B#', 'Dm', 'Em', 'E#', 'G', 'Am', 'B'],
    'C': ['C', 'Dm', 'Em', 'F', 'G', 'Am', 'B'],
    'C#': ['C#', 'D#m', 'E#m', 'F#', 'G#', 'A#m', 'B#'],
    'Db': ['Db', 'Ebm', 'Fm', 'Gb', 'Ab', 'Bbm', 'C'],
    'D': ['D', 'Em', 'F#m', 'G', 'A', 'Bm', 'C#'],
    'D#': ['D#', 'E#m', 'Gm', 'G#', 'A#', 'Cm', 'D'],
    'Eb': ['Eb', 'Fm', 'Gm', 'Ab', 'Bb', 'Cm', 'D'],
    'E': ['E', 'F#m', 'G#m', 'A', 'B', 'C#m', 'D#'],
    'E#': ['E#', 'Gm', 'Am', 'A#', 'B#', 'Dm', 'E'],
    'Fb': ['Fb', 'Gbm', 'Abm', 'A', 'Cb', 'Dbm', 'Eb'],
    'F': ['F', 'Gm', 'Am', 'Bb', 'C', 'Dm', 'E'],
    'F#': ['F#', 'G#m', 'A#m', 'B', 'C#', 'D#m', 'E#'],
    'Gb': ['Gb', 'Abm', 'Bbm', 'Cb', 'Db', 'Ebm', 'F'],
    'G': ['G', 'Am', 'Bm', 'C', 'D', 'Em', 'F#'],
    'G#': ['G#', 'A#m', 'B#m', 'C#', 'D#', 'E#m', 'G'],
    'Ab': ['Ab', 'Bbm', 'Cm', 'Db', 'Eb', 'Fm', 'G']
  };

  final Map<String, int> distanceChords = {
    'C': 0,
    'C#': 1,
    'Db': 1,
    'D': 2,
    'Eb': 3,
    'D#': 3,
    'E': 4,
    'F': 5,
    'F#': 6,
    'Gb': 6,
    'G': 7,
    'Ab': 8,
    'G#': 8,
    'A': 9,
    'Bb': 10,
    'A#': 10,
    'B': 11,
  };

  List<String> nearChords(String chord) {
    int distance = (distanceChords[chord]! - 3 < 0)
        ? (distanceChords[chord]! - 3) + 12
        : distanceChords[chord]! - 3;
    return distanceChords.entries
        .where((entry) => entry.value == distance)
        .map((entry) => entry.key)
        .toList();
  }

  String guessKey(Song song) {
    List<Chord> chords = [];
    for (var line in song.lines) {
      if (line is Lyrics) {
        for (var block in line.blocks) {
          List<Chord> blockChords = block.chords;
          if (blockChords.isNotEmpty) {
            chords.add(blockChords.first);
          }
        }
      }
    }

    Map<String, int> listKeys = {};
    scales.forEach((key, scale) {
      listKeys[key] = 0;
      for (var chord in chords) {
        if (scale.contains(chord.rootChord)) {
          listKeys[key] = (listKeys[key]! + 1);
        }
      }
    });

    var sortedKeys = listKeys.keys.toList()
      ..sort((a, b) => listKeys[b]!.compareTo(listKeys[a]!));

    String majorKey = sortedKeys.first;
    List<String> minorKeys = nearChords(majorKey);

    Map<String, int> result = {
      majorKey: chords.where((c) => c.rootChord == majorKey).length
    };
    for (var key in minorKeys) {
      key = '${key}m';
      int count = chords.where((c) => c.rootChord == key).length;
      if (count > 0) {
        result[key] = count;
      }
    }

    var sortedResultKeys = result.keys.toList()
      ..sort((a, b) => result[b]!.compareTo(result[a]!));

    return sortedResultKeys.first;
  }
}
