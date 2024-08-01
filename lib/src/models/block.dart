import 'package:chordspro_dart/src/models/chord.dart';

class Block {
  final List<Chord> chords;
  final String text;
  final bool lineEnd;

  Block(this.chords, this.text, {this.lineEnd = false});

  @override
  String toString() => 'Block(chords: $chords, text: $text, lineEnd: $lineEnd)';
}
