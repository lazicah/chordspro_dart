// ignore_for_file: constant_identifier_names

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
      [List<ChordNotationInterface> sourceNotations = const []]) {
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
        this.rootChord = rootChord;
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
      [List<ChordNotationInterface> notations = const []]) {
    if (text.isEmpty) {
      return [];
    }
    var chords = text.split('/');
    return chords.map((chord) => Chord(chord, notations)).toList();
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
}
