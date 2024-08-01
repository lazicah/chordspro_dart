import 'package:chordspro_dart/src/notation/chord_notation_interface.dart';

abstract class ChordNotation implements ChordNotationInterface {
  /// Get the table of chord key mappings to English.
  List<String> getToEnglishTable();

  /// Get the table of chord key mappings from English.
  List<String> getFromEnglishTable();

  @override
  String convertChordRootFromNotation(String chordRoot) {
    var mappings = getToEnglishTable();
    return mappings.isNotEmpty && mappings.contains(chordRoot)
        ? mappings[mappings.indexOf(chordRoot)]
        : chordRoot;
  }

  @override
  String convertChordRootToNotation(String chordRoot) {
    var mappings = getFromEnglishTable();
    return mappings.isNotEmpty && mappings.contains(chordRoot)
        ? mappings[mappings.indexOf(chordRoot)]
        : chordRoot;
  }

  @override
  String convertExtToNotation(String chordExt) {
    // This will be mostly a no-op.
    return chordExt;
  }
}
