import 'package:chordspro_dart/src/models/block.dart';
import 'package:chordspro_dart/src/models/line/line.dart';

class Lyrics extends Line {
  final List<Block> blocks;
  final bool hasChords;
  final bool hasText;
  final bool hasInlineChords;

  Lyrics({
    this.blocks = const [],
    this.hasChords = false,
    this.hasText = false,
    this.hasInlineChords = false,
  });
}
