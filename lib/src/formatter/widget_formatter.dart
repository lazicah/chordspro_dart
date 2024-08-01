import 'package:chordspro_dart/src/formatter/formating_options.dart';
import 'package:chordspro_dart/src/formatter/formatter.dart';
import 'package:chordspro_dart/src/formatter/formatter_interface.dart';
import 'package:chordspro_dart/src/models/line/empty_line.dart';
import 'package:chordspro_dart/src/models/line/line.dart';
import 'package:chordspro_dart/src/models/line/lyrics.dart';
import 'package:chordspro_dart/src/models/line/metadata.dart';
import 'package:chordspro_dart/src/models/song.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WidgetFormatter extends Formatter implements FormatterInterface {
  @override
  List<Widget> format(Song song, {FormatingOptions? options}) {
    setOptions(options ?? FormatingOptions.empty());

    List<Widget> widgets = [];
    for (var line in song.getLines()) {
      widgets.add(getLineWidget(line));
    }
    return widgets;
  }

  Widget getLineWidget(Line line) {
    if (line is Metadata) {
      return getMetadataWidget(line);
    } else if (line is EmptyLine) {
      return SizedBox(
        height: lineSpacing,
      );
    } else if (line is Lyrics) {
      return noChords ? getLyricsOnlyWidget(line) : getLyricsWidget(line);
    } else {
      return const SizedBox();
    }
  }

  String blankChars(String? text) {
    // @todo Is this if needed?
    if (text == null || text.isEmpty) {
      text = ' ';
    }
    return text;
  }

  Widget getMetadataWidget(Metadata metadata) {
    // Ignore some metadata.
    if (ignoreMetadata.contains(metadata.name)) {
      return const SizedBox();
    }

    if (metadata.isSectionStart()) {
      if (metadata.value != null) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: lineSpacing),
          child: Text(
            metadata.value!,
            style: metadataStyle,
            textScaler: TextScaler.linear(textScaleFactor),
          ),
        );
      }
      return SizedBox(
        height: lineSpacing,
      );
    } else if (metadata.isSectionEnd()) {
      return SizedBox(
        height: lineSpacing,
      );
    } else {
      String? value;
      if (metadata.name == 'key' && notation != null) {
        value = notation!.convertChordRootToNotation(metadata.value ?? '');
      } else {
        value = metadata.value;
      }

      String output = '';
      if (metadata.isNameNecessary()) {
        output += '${metadata.getHumanName()}: ';
        output += '$value';
      } else {
        output += value ?? '';
      }

      return Text(
        output,
        style: metadataStyle,
        textScaler: TextScaler.linear(textScaleFactor),
      );
    }
  }

  Widget getLyricsWidget(Lyrics lyrics) {
    List<TableRow> rows = [];
    List<Widget> rows1 = [];
    List<Widget> rows2 = [];
    String line = '';
    String lineChords = '';
    String lineText = '';
    for (var block in lyrics.blocks.asMap().entries) {
      List<String> originalChords = [];
      List<String> chords = [];

      var slicedChords = block.value.chords;

      for (var slicedChord in slicedChords) {
        if (slicedChord.isKnown) {
          String ext = slicedChord.getExt(notation);
          chords.add(slicedChord.getRootChord(notation) + ext);
          originalChords.add(slicedChord.getRootChord() + slicedChord.getExt());
        } else {
          chords.add(slicedChord.getOriginalName());
          originalChords.add(slicedChord.getOriginalName());
        }
      }

      String chord = chords.join('/');
      String text = blankChars(block.value.text);

      if (lyrics.hasInlineChords) {
        if (block.key == 0) {
          lineText = text;
        } else {
          lineChords += chord;
        }
      } else if (lyrics.hasChords && lyrics.hasText) {
        if (chord.isNotEmpty) {
          rows1.add(FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              color: chordBgColor,
              child: Text(
                chord,
                style: chordStyle,
                textScaler: TextScaler.linear(textScaleFactor),
              ),
            ),
          ));
        } else {
          rows1.add(const SizedBox());
        }
        rows2.add(Text(
          text,
          style: textStyle,
          textScaler: TextScaler.linear(textScaleFactor),
        ));
      } else if (lyrics.hasChords) {
        line += chord;
      } else if (lyrics.hasText) {
        line += text;
      }
    }

    if (lyrics.hasInlineChords) {
      line += lineChords;
      line += lineText;
    }

    if (kDebugMode) {
      print(line);
    }
    if (lyrics.hasChords && lyrics.hasText) {
      rows.add(TableRow(children: rows1));
      rows.add(TableRow(children: rows2));
      return Table(
        children: rows,
        defaultColumnWidth: const IntrinsicColumnWidth(),
        border: TableBorder.all(
          width: 4,
          color: Colors.transparent,
        ),
      );
    } else {
      return Text(
        line,
        style: textStyle,
        textScaler: TextScaler.linear(textScaleFactor),
      );
    }
  }

  Widget getLyricsOnlyWidget(Lyrics lyrics) {
    String text = '';
    for (var block in lyrics.blocks) {
      text += block.text.trimLeft();
    }
    text = text.trimRight();
    if (text.isEmpty) {
      return const SizedBox();
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: lineSpacing),
        child: Text(
          text,
          style: textStyle,
          textScaler: TextScaler.linear(textScaleFactor),
        ),
      );
    }
  }
}
