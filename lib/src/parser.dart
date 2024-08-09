import 'package:chordspro_dart/src/models/block.dart';
import 'package:chordspro_dart/src/models/chord.dart';
import 'package:chordspro_dart/src/models/key_tonal.dart';
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
      {KeyTonal keyTonal = KeyTonal.original,
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
                sourceNotations: sourceNotations, keyTonal: keyTonal));
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
      {KeyTonal keyTonal = KeyTonal.original,
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
          blocks.add(Block(
            Chord.fromSlice(chord.group(1)!,
                notations: sourceNotations, keyTonal: keyTonal),
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

          blocks.add(Block(
            Chord.fromSlice(chordWithText[0],
                notations: sourceNotations, keyTonal: keyTonal),
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

          blocks.add(Block(
            Chord.fromSlice(chordWithText[0],
                notations: sourceNotations, keyTonal: keyTonal),
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

          blocks.add(Block(
            Chord.fromSlice(chordWithText[0],
                notations: sourceNotations, keyTonal: keyTonal),
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

  changeSongTone(Song song,
      {KeyTonal keyTonal = KeyTonal.original,
      List<ChordNotationInterface> sourceNotations = const []}) {
    for (var line in song.getLines()) {
      if (line is Lyrics) {
        for (var block in line.blocks) {
          var chords = block.chords;
          if (chords.isNotEmpty) {
            for (var chord in chords) {
              chord.transposeTo(chord.getRootChord(), keyTonal);
            }
          }
        }
      }
    }
  }
}
