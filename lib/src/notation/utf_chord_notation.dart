// ignore_for_file: constant_identifier_names

import 'package:chordspro_dart/src/notation/chord_notation.dart';

class UtfChordNotation extends ChordNotation {
  static const Map<String, String> ASCII_TO_UTF = {
    'Abm': 'A♭m',
    'Bbm': 'B♭m',
    'Dbm': 'D♭m',
    'Ebm': 'E♭m',
    'A#m': 'A♯m',
    'C#m': 'C♯m',
    'D#m': 'D♯m',
    'E#m': 'E♯m',
    'F#m': 'F♯m',
    'G#m': 'G♯m',
    'Ab': 'A♭',
    'Bb': 'B♭',
    'Cb': 'C♭',
    'Db': 'D♭',
    'Eb': 'E♭',
    'Fb': 'F♭',
    'Gb': 'G♭',
    'A#': 'A♯',
    'C#': 'C♯',
    'D#': 'D♯',
    'F#': 'F♯',
    'G#': 'G♯',
  };

  static const Map<String, String> UTF_TO_ASCII = {
    'A♭m': 'Abm',
    'B♭m': 'Bbm',
    'D♭m': 'Dbm',
    'E♭m': 'Ebm',
    'A♯m': 'A#m',
    'C♯m': 'C#m',
    'D♯m': 'D#m',
    'E♯m': 'E#m',
    'F♯m': 'F#m',
    'G♯m': 'G#m',
    'A♭': 'Ab',
    'B♭': 'Bb',
    'C♭': 'Cb',
    'D♭': 'Db',
    'E♭': 'Eb',
    'F♭': 'Fb',
    'G♭': 'Gb',
    'A♯': 'A#',
    'C♯': 'C#',
    'D♯': 'D#',
    'F♯': 'F#',
    'G♯': 'G#',
  };

  @override
  Map<String, String> getToEnglishTable() {
    return UTF_TO_ASCII;
  }

  @override
  Map<String, String> getFromEnglishTable() {
    return ASCII_TO_UTF;
  }
}
