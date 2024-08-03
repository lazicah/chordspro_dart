import 'package:chordspro_dart/src/models/chord.dart';
import 'package:chordspro_dart/src/models/key_tonal.dart';
import 'package:chordspro_dart/src/models/line/lyrics.dart';
import 'package:chordspro_dart/src/models/song.dart';

class ChordsProTransposer {
  // The table of chord key mappings to semitones.
  final Map<String, int> simpleTransposeTable = {
    'C': 0,
    'C#': 1,
    'Db': 1,
    'D': 2,
    'D#': 3,
    'Eb': 3,
    'E': 4,
    'F': 5,
    'F#': 6,
    'Gb': 6,
    'G': 7,
    'G#': 8,
    'Ab': 8,
    'A': 9,
    'A#': 10,
    'Bb': 10,
    'B': 11,
  };

  // final Map<String, int> simpleMinorTransposeTable = {
  //   'Am': 0,
  //   'A#m': 1,
  //   'Bbm': 1,
  //   'Bm': 2,
  //   'Cm': 3,
  //   'C#m': 4,
  //   'Dbm': 4,
  //   'Dm': 5,
  //   'Ebm': 6,
  //   'D#m': 6,
  //   'Em': 7,
  //   'Fm': 8,
  //   'F#m': 9,
  //   'Gbm': 9,
  //   'Gm': 10,
  //   'G#m': 11,
  //   'Abm': 11,
  // };

  // The table of chord key mappings for [transposeTable].
  final Map<String, int> transposeChords = {
    'Fb': 0,
    'Cb': 1,
    'Gb': 2,
    'Db': 3,
    'Ab': 4,
    'Eb': 5,
    'Bb': 6,
    'F': 7,
    'C': 8,
    'G': 9,
    'D': 10,
    'A': 11,
    'E': 12,
    'B': 13,
    'F#': 14,
    'C#': 15,
    'G#': 16,
    'Dbm': 0,
    'Abm': 1,
    'Ebm': 2,
    'Bbm': 3,
    'Fm': 4,
    'Cm': 5,
    'Gm': 6,
    'Dm': 7,
    'Am': 8,
    'Em': 9,
    'Bm': 10,
    'F#m': 11,
    'C#m': 12,
    'G#m': 13,
    'D#m': 14,
    'A#m': 15,
    'E#m': 16,
  };

  // The table of chord key mappings to transpose.
  final List<List<String>> transposeTable = [
    [
      'Fb',
      'F',
      'Gbb',
      'Gb',
      'G',
      'Abb',
      'Ab',
      'A',
      'Bbb',
      'Bb',
      'Cbb',
      'Cb',
      'C',
      'Dbb',
      'Db',
      'D',
      'Ebb',
      'Eb'
    ],
    [
      'Cb',
      'C',
      'Dbb',
      'Db',
      'D',
      'Ebb',
      'Eb',
      'E',
      'Fb',
      'F',
      'Gbb',
      'Gb',
      'G',
      'Abb',
      'Ab',
      'A',
      'Bbb',
      'Bb'
    ],
    [
      'Gb',
      'G',
      'Abb',
      'Ab',
      'A',
      'Bbb',
      'Bb',
      'B',
      'Cb',
      'C',
      'Dbb',
      'Db',
      'D',
      'Ebb',
      'Eb',
      'E',
      'Fb',
      'F'
    ],
    [
      'Db',
      'D',
      'Ebb',
      'Eb',
      'E',
      'Fb',
      'F',
      'F#',
      'Gb',
      'G',
      'Abb',
      'Ab',
      'A',
      'Bbb',
      'Bb',
      'B',
      'Cb',
      'C'
    ],
    [
      'Ab',
      'A',
      'Bbb',
      'Bb',
      'B',
      'Cb',
      'C',
      'C#',
      'Db',
      'D',
      'Ebb',
      'Eb',
      'E',
      'Fb',
      'F',
      'F#',
      'Gb',
      'G'
    ],
    [
      'Eb',
      'E',
      'Fb',
      'F',
      'F#',
      'Gb',
      'G',
      'G#',
      'Ab',
      'A',
      'Bbb',
      'Bb',
      'B',
      'Cb',
      'C',
      'C#',
      'Db',
      'D'
    ],
    [
      'Bb',
      'B',
      'Cb',
      'C',
      'C#',
      'Db',
      'D',
      'D#',
      'Eb',
      'E',
      'Fb',
      'F',
      'F#',
      'Gb',
      'G',
      'G#',
      'Ab',
      'A'
    ],
    [
      'F',
      'F#',
      'Gb',
      'G',
      'G#',
      'Ab',
      'A',
      'A#',
      'Bb',
      'B',
      'Cb',
      'C',
      'C#',
      'Db',
      'D',
      'D#',
      'Eb',
      'E'
    ],
    [
      'C',
      'C#',
      'Db',
      'D',
      'D#',
      'Eb',
      'E',
      'E#',
      'F',
      'F#',
      'Gb',
      'G',
      'G#',
      'Ab',
      'A',
      'A#',
      'Bb',
      'B'
    ],
    [
      'G',
      'G#',
      'Ab',
      'A',
      'A#',
      'Bb',
      'B',
      'B#',
      'C',
      'C#',
      'Db',
      'D',
      'D#',
      'Eb',
      'E',
      'E#',
      'F',
      'F#'
    ],
    [
      'D',
      'D#',
      'Eb',
      'E',
      'E#',
      'F',
      'F#',
      'FX',
      'G',
      'G#',
      'Ab',
      'A',
      'A#',
      'Bb',
      'B',
      'B#',
      'C',
      'C#'
    ],
    [
      'A',
      'A#',
      'Bb',
      'B',
      'B#',
      'C',
      'C#',
      'CX',
      'D',
      'D#',
      'Eb',
      'E',
      'E#',
      'F',
      'F#',
      'FX',
      'G',
      'G#'
    ],
    [
      'E',
      'E#',
      'F',
      'F#',
      'FX',
      'G',
      'G#',
      'GX',
      'A',
      'A#',
      'Bb',
      'B',
      'B#',
      'C',
      'C#',
      'CX',
      'D',
      'D#'
    ],
    [
      'B',
      'B#',
      'C',
      'C#',
      'CX',
      'D',
      'D#',
      'DX',
      'E',
      'E#',
      'F',
      'F#',
      'FX',
      'G',
      'G#',
      'GX',
      'A',
      'A#'
    ],
    [
      'F#',
      'FX',
      'G',
      'G#',
      'GX',
      'A',
      'A#',
      'AX',
      'B',
      'B#',
      'C',
      'C#',
      'CX',
      'D',
      'D#',
      'DX',
      'E',
      'E#'
    ],
    [
      'C#',
      'CX',
      'D',
      'D#',
      'DX',
      'E',
      'E#',
      'EX',
      'F#',
      'FX',
      'G',
      'G#',
      'GX',
      'A',
      'A#',
      'AX',
      'B',
      'B#'
    ],
    [
      'G#',
      'GX',
      'A',
      'A#',
      'AX',
      'B',
      'B#',
      'BX',
      'C#',
      'CX',
      'D',
      'D#',
      'DX',
      'E',
      'E#',
      'EX',
      'F#',
      'FX'
    ]
  ];

  Song transpose(Song song, dynamic value,
      {KeyTonal keyTonal = KeyTonal.original}) {
    for (var line in song.getLines()) {
      if (line is Lyrics) {
        for (var block in line.blocks) {
          var chords = block.chords;
          if (chords.isNotEmpty) {
            if (value is int) {
              simpleTranspose(chords, value, keyTonal: keyTonal);
            } else if (song.getKey() != null) {
              completeTranspose(
                chords,
                song.getKey()!,
                value,
                keyTonal: keyTonal,
              );
              song.setKey(value);
            }
          }
        }
      }
    }
    return song;
  }

  void simpleTranspose(List<Chord> chords, int value,
      {KeyTonal keyTonal = KeyTonal.original}) {
    for (var chord in chords) {
      if (!chord.isKnown) continue;

      if (value != 0 && value < 12 && value > -12) {
        var suffix = chord.isMinor ? 'm' : '';
        var key =
            simpleTransposeTable[chord.getRootChord().replaceAll('m', '')]!;
        var newKey =
            (key + value < 0) ? 12 + (key + value) : (key + value) % 12;

        var transposedChord = simpleTransposeTable.entries
            .firstWhere((entry) => entry.value == newKey)
            .key;

        if (keyTonal != KeyTonal.original) {
          transposedChord =
              _getSharpOrFlatChord(transposedChord, keyTonal == KeyTonal.sharp);
        }

        chord.transposeTo(transposedChord + suffix);
      } else {
        if (keyTonal != KeyTonal.original) {
          var suffix = chord.isMinor ? 'm' : '';

          final transposedChord = _getSharpOrFlatChord(
              chord.getRootChord().replaceAll('m', ''),
              keyTonal == KeyTonal.sharp);

          chord.transposeTo(transposedChord + suffix);
        }
      }
    }
  }

  void completeTranspose(List<Chord> chords, String fromKey, String toKey,
      {KeyTonal keyTonal = KeyTonal.original}) {
    for (var chord in chords) {
      var suffix = chord.isMinor ? 'm' : '';
      var rank = transposeTable[transposeChords[fromKey]!]
          .indexOf(chord.getRootChord().replaceAll('m', ''));
      var transposedChord = transposeTable[transposeChords[toKey]!][rank];

      if (keyTonal != KeyTonal.original) {
        transposedChord =
            _getSharpOrFlatChord(transposedChord, keyTonal == KeyTonal.sharp);
      }
      chord.transposeTo(transposedChord + suffix);
    }
  }

  // Method to transpose a song to its sharp or flat variants
  void transposeToSharpOrFlat(Song song, {bool toSharp = true}) {
    for (var line in song.getLines()) {
      if (line is Lyrics) {
        for (var block in line.blocks) {
          var chords = block.chords;
          if (chords.isNotEmpty) {
            for (var chord in chords) {
              if (!chord.isKnown) continue;

              var rootChord = chord.getRootChord();
              var suffix = chord.isMinor ? 'm' : '';
              var transposedChord = _getSharpOrFlatChord(rootChord, toSharp);
              chord.transposeTo(transposedChord + suffix);
            }
          }
        }
      }
    }
  }

  String _getSharpOrFlatChord(String chord, bool toSharp) {
    var root = chord.replaceAll('m', ''); // Remove 'm' for minor chords
    var semitone = simpleTransposeTable[root]!;

    var transposedChord = root;
    if (toSharp) {
      transposedChord = simpleTransposeTable.entries
          .firstWhere(
            (entry) => entry.value == semitone && entry.key.contains('#'),
            orElse: () => MapEntry(transposedChord, -1),
          )
          .key;
    } else {
      transposedChord = simpleTransposeTable.entries
          .firstWhere(
            (entry) => entry.value == semitone && entry.key.contains('b'),
            orElse: () => MapEntry(transposedChord, -1),
          )
          .key;
    }
    return transposedChord; // Return original chord if not found
  }
}
