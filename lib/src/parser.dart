import 'package:chordspro_dart/src/models/block.dart';
import 'package:chordspro_dart/src/models/chord.dart';
import 'package:chordspro_dart/src/models/line/comment.dart';
import 'package:chordspro_dart/src/models/line/empty_line.dart';
import 'package:chordspro_dart/src/models/line/line.dart';
import 'package:chordspro_dart/src/models/line/lyrics.dart';
import 'package:chordspro_dart/src/models/line/metadata.dart';
import 'package:chordspro_dart/src/models/song.dart';
import 'package:chordspro_dart/src/notation/chord_notation_interface.dart';

class ChordsProParser {
  /// Parse the song text.
  ///
  /// @param String text The song text to parse.
  /// @param List<ChordNotationInterface> sourceNotations The notations to use, ordered by precedence.
  ///
  /// @return Song
  Song parse(String text,
      {bool toSharp = true,
      List<ChordNotationInterface> sourceNotations = const []}) {
    List<Line> lines = [];
    List<String> split = text.split(RegExp(r'\r\n|\r|\n'));
    for (var line in split) {
      line = line.trim();
      if (line.isEmpty) {
        lines.add(EmptyLine());
      } else {
        switch (line[0]) {
          case '{':
            lines.add(parseMetadata(line));
            break;
          case '#':
            lines.add(Comment(line.substring(1).trim()));
            break;
          default:
            lines.add(parseLyrics(line,
                sourceNotations: sourceNotations, toSharp: toSharp));
            break;
        }
      }
    }
    return Song(lines);
  }

  /// Parse a song line, assuming it contains metadata.
  ///
  /// The metadata is defined inside curly braces.
  /// It can either contain {name: value}, or just {name}.
  ///
  /// @param String line A line of the song.
  /// @return Metadata The structured metadata.
  Metadata parseMetadata(String line) {
    line = line.trim().substring(1, line.length - 1);
    int pos = line.indexOf(':');
    String name, value;

    if (pos != -1) {
      name = line.substring(0, pos).trim();
      value = line.substring(pos + 1).trim();
    } else {
      name = line;
      value = '';
    }
    return Metadata(name, value);
  }

  /// Parse a song line, assuming it contains lyrics.
  ///
  /// @param String line A line of the song.
  /// @param List<ChordNotationInterface> sourceNotations The notations to use, ordered by precedence.
  ///
  /// @return Lyrics The structured lyrics
  Lyrics parseLyrics(String line,
      {bool toSharp = true,
      List<ChordNotationInterface> sourceNotations = const []}) {
    List<Block> blocks = [];
    List<int> possiblyEmptyBlocks = [];
    bool hasText = false;
    bool hasChords = false;

    // First, check for ~ symbol.
    RegExpMatch? match = RegExp(r'^([^\[\]]+)~(.+)').firstMatch(line);
    if (match != null) {
      List<RegExpMatch> matchChords =
          RegExp(r'\[([^\[\]]+)\]').allMatches(match.group(2)!).toList();
      if (matchChords.isNotEmpty) {
        blocks.add(Block([], match.group(1)!.trim()));
        for (var chord in matchChords) {
          var transposedChord = _getSharpOrFlatChord(
              Chord.fromSlice(chord.group(1)!, sourceNotations).join(),
              toSharp);
          blocks.add(Block(
            Chord.fromSlice(transposedChord, sourceNotations),
            '',
            lineEnd: true,
          ));
        }
        return Lyrics(
          blocks: blocks,
          hasInlineChords: true,
          hasChords: true,
          hasText: true,
        );
      }
    }

    List<String> explodedLine = line.split('[');
    for (int numb = 0; numb < explodedLine.length; numb++) {
      String lineFragment = explodedLine[numb];
      if (lineFragment.isNotEmpty) {
        List<String> chordWithText = lineFragment.split(']');
        if (chordWithText.length > 1 && chordWithText[1].isEmpty) {
          hasChords = true;
          var transposedChord = _getSharpOrFlatChord(
              Chord.fromSlice(chordWithText[0], sourceNotations).join(),
              toSharp);
          blocks.add(Block(
            Chord.fromSlice(transposedChord, sourceNotations),
            '',
          ));
        } else if (numb == 0 && chordWithText.length == 1) {
          blocks.add(Block(
            [],
            chordWithText[0],
          ));
          if (RegExp(r'\S').hasMatch(chordWithText[0])) {
            hasText = true;
          } else {
            possiblyEmptyBlocks.add(blocks.length - 1);
          }
        } else if (chordWithText.length > 1 &&
            chordWithText[1].startsWith(' ')) {
          hasChords = true;
          var transposedChord = _getSharpOrFlatChord(
              Chord.fromSlice(chordWithText[0], sourceNotations).join(),
              toSharp);
          blocks.add(Block(
            Chord.fromSlice(transposedChord, sourceNotations),
            '',
          ));
          blocks.add(Block(
            [],
            chordWithText[1],
          ));
          if (RegExp(r'\S').hasMatch(chordWithText[1])) {
            hasText = true;
          } else {
            possiblyEmptyBlocks.add(blocks.length - 1);
          }
        } else {
          hasChords = true;
          var transposedChord = _getSharpOrFlatChord(
              Chord.fromSlice(chordWithText[0], sourceNotations).join(),
              toSharp);
          blocks.add(Block(
            Chord.fromSlice(transposedChord, sourceNotations),
            chordWithText.length > 1 ? chordWithText[1] : '',
          ));
          if (RegExp(r'\S')
              .hasMatch(chordWithText.length > 1 ? chordWithText[1] : '')) {
            hasText = true;
          } else {
            possiblyEmptyBlocks.add(blocks.length - 1);
          }
        }
      }
    }

    int lastBlockKey = 0;
    if (hasChords && !hasText) {
      for (var blockKey in possiblyEmptyBlocks) {
        blocks.removeAt(blockKey - lastBlockKey);
        lastBlockKey = blockKey;
      }
    } else if (!hasChords && !hasText) {
      blocks = [];
    }

    return Lyrics(
      blocks: blocks,
      hasInlineChords: false,
      hasChords: hasChords,
      hasText: hasText,
    );
  }

  String _getSharpOrFlatChord(String chord, bool toSharp) {
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
    if (simpleTransposeTable.containsKey(root)) {
      var semitone = simpleTransposeTable[root]!;
      if (toSharp) {
        // Convert to sharp variant
        return simpleTransposeTable.entries
            .firstWhere(
                (entry) => entry.value == semitone && entry.key.contains('#'))
            .key;
      } else {
        // Convert to flat variant
        return simpleTransposeTable.entries
            .firstWhere(
                (entry) => entry.value == semitone && entry.key.contains('b'))
            .key;
      }
    }
    return chord; // Return original chord if not found
  }
}
