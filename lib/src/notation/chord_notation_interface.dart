abstract class ChordNotationInterface {
  /// Convert a chord ext to this notation.
  String convertExtToNotation(String chordExt);

  /// Convert a key (chord root) to this notation.
  String convertChordRootToNotation(String chordRoot);

  /// Convert a key (chord root) from this notation.
  String convertChordRootFromNotation(String chordRoot);
}
