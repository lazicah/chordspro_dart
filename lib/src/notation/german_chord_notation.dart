// ignore_for_file: constant_identifier_names

import 'package:chordspro_dart/src/notation/chord_notation.dart';

class GermanChordNotation extends ChordNotation {
  static const Map<String, String> ENGLISH_TO_GERMAN = {
    'F#m': 'fis',
    'C#m': 'cis',
    'G#m': 'gis',
    'D#m': 'dis',
    'A#m': 'b',
    'E#m': 'eis',
    'Dbm': 'des',
    'Abm': 'as',
    'Ebm': 'es',
    'Bbm': 'b',
    'Fb': 'Fes',
    'Cb': 'Ces',
    'Gb': 'Ges',
    'Db': 'Des',
    'Ab': 'As',
    'Eb': 'Es',
    'Bb': 'B',
    'F#': 'Fis',
    'C#': 'Cis',
    'G#': 'Gis',
    'Fm': 'f',
    'Cm': 'c',
    'Gm': 'g',
    'Dm': 'd',
    'Am': 'a',
    'Em': 'e',
    'Bm': 'h',
    'B': 'H',
  };

  static const Map<String, String> GERMAN_TO_ENGLISH = {
    'fis': 'F#m',
    'cis': 'C#m',
    'gis': 'G#m',
    'dis': 'D#m',
    'eis': 'E#m',
    'des': 'Dbm',
    'Fes': 'Fb',
    'Ces': 'Cb',
    'Ges': 'Gb',
    'Des': 'Db',
    'Fis': 'F#',
    'Cis': 'C#',
    'Gis': 'G#',
    'As': 'Ab',
    'Es': 'Eb',
    'as': 'Abm',
    'es': 'Ebm',
    'f': 'Fm',
    'c': 'Cm',
    'g': 'Gm',
    'd': 'Dm',
    'a': 'Am',
    'e': 'Em',
    'h': 'Bm',
    'H': 'B',
    'b': 'Bbm',
    'B': 'Bb',
  };

  @override
  Map<String, String> getToEnglishTable() {
    return GERMAN_TO_ENGLISH;
  }

  @override
  Map<String, String> getFromEnglishTable() {
    return ENGLISH_TO_GERMAN;
  }
}
