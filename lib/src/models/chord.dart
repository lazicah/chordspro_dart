// ignore_for_file: constant_identifier_names

import 'package:chordspro_dart/src/models/key_tonal.dart';
import 'package:chordspro_dart/src/notation/chord_notation_interface.dart';

class Chord {
  static const List<String> ROOT_CHORDS = [
    'F#m',
    'C#m',
    'G#m',
    'D#m',
    'A#m',
    'E#m',
    'Dbm',
    'Abm',
    'Ebm',
    'Bbm',
    'Fb',
    'Cb',
    'Gb',
    'Db',
    'Ab',
    'Eb',
    'Bb',
    'A#',
    'F#',
    'C#',
    'G#',
    'D#',
    'Fm',
    'Cm',
    'Gm',
    'Dm',
    'Am',
    'Em',
    'Bm',
    'F',
    'C',
    'G',
    'D',
    'A',
    'E',
    'B'
  ];

  String rootChord = '';
  String ext = '';
  bool isKnown = false;
  static final Map<Type, Map<String, String>> notationRootChords = {};

  final String originalName;

  Chord(this.originalName,
      {KeyTonal keyTonal = KeyTonal.original,
      List<ChordNotationInterface> sourceNotations = const []}) {
    String name = originalName;

    for (var sourceNotation in sourceNotations) {
      final notationRootChords = getNotationRootChords(sourceNotation);
      for (var entry in notationRootChords.entries) {
        if (name.startsWith(entry.key)) {
          name = entry.value + name.substring(entry.key.length);
          break;
        }
      }
    }

    for (var rootChord in ROOT_CHORDS) {
      if (name.startsWith(rootChord)) {
        if (keyTonal != KeyTonal.original) {
          var suffix = rootChord.contains('m') ? 'm' : '';
          final transposedChord =
              _getSharpOrFlatChord(rootChord, keyTonal == KeyTonal.sharp);
          this.rootChord = transposedChord + suffix;
        } else {
          this.rootChord = rootChord;
        }
        ext = name.substring(rootChord.length);
        isKnown = true;
        break;
      }
    }

    if (rootChord.isEmpty) {
      isKnown = false;
    }
  }

  static List<Chord> fromSlice(String text,
      {KeyTonal keyTonal = KeyTonal.original,
      List<ChordNotationInterface> notations = const []}) {
    if (text.isEmpty) {
      return [];
    }
    var chords = text.split('/');
    return chords.map((chord) {
      // if (keyTonal != KeyTonal.original) {
      //   final transposedChord =
      //       _getSharpOrFlatChord(chord, keyTonal == KeyTonal.sharp);
      //   return Chord(transposedChord, sourceNotations: notations);
      // }
      return Chord(chord, sourceNotations: notations);
    }).toList();
  }

  Map<String, String> getNotationRootChords(ChordNotationInterface notation) {
    if (!notationRootChords.containsKey(notation.runtimeType)) {
      final rootChordsMap = <String, String>{};
      for (var rootChord in ROOT_CHORDS) {
        var convertedChord = notation.convertChordRootToNotation(rootChord);
        if (convertedChord != rootChord) {
          rootChordsMap[convertedChord] = rootChord;
        }
      }
      var sortedKeys = rootChordsMap.keys.toList()
        ..sort((a, b) => b.length.compareTo(a.length));
      var sortedMap = {for (var key in sortedKeys) key: rootChordsMap[key]!};
      notationRootChords[notation.runtimeType] = sortedMap;
    }
    return notationRootChords[notation.runtimeType]!;
  }

  bool get isMinor => rootChord.endsWith('m');

  String getRootChord([ChordNotationInterface? targetNotation]) {
    if (targetNotation != null) {
      return targetNotation.convertChordRootToNotation(rootChord);
    }
    return rootChord;
  }

  String getExt([ChordNotationInterface? targetNotation]) {
    if (targetNotation != null) {
      return targetNotation.convertExtToNotation(ext);
    }
    return ext;
  }

  String getOriginalName() => originalName;

  void transposeTo(String rootChord) {
    this.rootChord = rootChord;
  }

  @override
  String toString() {
    return 'Chord(rootChord: $rootChord, ext: $ext, isKnown: $isKnown, originalName: $originalName)';
  }

  static String _getSharpOrFlatChord(String chord, bool toSharp) {
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

    var root = chord.replaceAll('m', ''); // Remove 'm' for minor chords
    print(root);
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
