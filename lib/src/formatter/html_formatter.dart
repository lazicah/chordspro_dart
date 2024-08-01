import 'package:chordspro_dart/src/formatter/formating_options.dart';
import 'package:chordspro_dart/src/formatter/formatter.dart';
import 'package:chordspro_dart/src/formatter/formatter_interface.dart';
import 'package:chordspro_dart/src/models/line/empty_line.dart';
import 'package:chordspro_dart/src/models/line/line.dart';
import 'package:chordspro_dart/src/models/line/lyrics.dart';
import 'package:chordspro_dart/src/models/line/metadata.dart';
import 'package:chordspro_dart/src/models/song.dart';

class HtmlFormatter extends Formatter implements FormatterInterface {
  @override
  String format(Song song, {FormatingOptions? options}) {
    setOptions(options ?? FormatingOptions.empty());

    String html = '';
    for (var line in song.getLines()) {
      html += getLineHtml(line);
    }
    return html;
  }

  String getLineHtml(Line line) {
    if (line is Metadata) {
      return getMetadataHtml(line);
    } else if (line is EmptyLine) {
      return "<br />\n";
    } else if (line is Lyrics) {
      return noChords ? getLyricsOnlyHtml(line) : getLyricsHtml(line);
    } else {
      return '';
    }
  }

  String blankChars(String? text) {
    // @todo Is this if needed?
    if (text == null || text.isEmpty) {
      text = '&nbsp;';
    }
    return text.replaceAll(' ', '&nbsp;');
  }

  String getMetadataHtml(Metadata metadata) {
    // Ignore some metadata.
    if (ignoreMetadata.contains(metadata.name)) {
      return '';
    }

    if (metadata.isSectionStart()) {
      String type = metadata.getSectionType();
      String content = '';
      if (metadata.value != null) {
        content =
            '<div class="chordpro-section-label chordpro-$type-label">${metadata.value}</div>\n';
      }
      return '$content<div class="chordpro-section chordpro-$type">\n';
    } else if (metadata.isSectionEnd()) {
      return "</div>\n";
    } else {
      String? value;
      if (metadata.name == 'key' && notation != null) {
        value = notation!.convertChordRootToNotation(metadata.value ?? '');
      } else {
        value = metadata.value;
      }
      String type = metadata.getNameSlug();
      String output = '<div class="chordpro-metadata chordpro-$type">';
      if (metadata.isNameNecessary()) {
        output +=
            '<span class="chordpro-metadata-name">${metadata.getHumanName()}: </span>';
        output += '<span class="chordpro-metadata-value">$value</span>';
      } else {
        output += value ?? '';
      }
      output += "</div>\n";
      return output;
    }
  }

  String getLyricsHtml(Lyrics lyrics) {
    List<String> classes = ['chordpro-line'];
    if (lyrics.hasInlineChords) {
      classes.add('chordpro-line-inline-chords');
    }
    if (!lyrics.hasChords) {
      classes.add('chordpro-line-text-only');
    }
    if (!lyrics.hasText) {
      classes.add('chordpro-line-chords-only');
    }
    String line = '<div class="${classes.join(' ')}">\n';
    line += '<table class="chordpro-table">';
    String row1 = '<tr>';
    String row2 = '<tr>';
    String lineChords = '';
    String lineText = '';
    for (var block in lyrics.blocks.asMap().entries) {
      List<String> originalChords = [];
      List<String> chords = [];

      var slicedChords = block.value.chords;

      for (var slicedChord in slicedChords) {
        if (slicedChord.isKnown) {
          String ext = slicedChord.getExt(notation);
          // if (ext.isNotEmpty) {
          //   ext = '<sup>$ext</sup>';
          // }

          chords.add(slicedChord.getRootChord(notation) + ext);
          originalChords.add(slicedChord.getRootChord() + slicedChord.getExt());
        } else {
          chords.add(slicedChord.getOriginalName());
          originalChords.add(slicedChord.getOriginalName());
        }
      }

      String chord = chords.join('/');
      String originalChord = originalChords.join('/');
      String text = blankChars(block.value.text);

      if (lyrics.hasInlineChords) {
        if (block.key == 0) {
          lineText = '<div class="chordpro-inline-text">$text</div>';
        } else {
          lineChords +=
              '<span class="chordpro-chord" data-chord="$originalChord">$chord</span>';
        }
      } else if (lyrics.hasChords && lyrics.hasText) {
        row1 +=
            '<td class="chordpro-chord" data-chord="$originalChord">$chord</td>';
        row2 += '<td class="chordpro-text">$text</td>';
      } else if (lyrics.hasChords) {
        line +=
            '<span class="chordpro-block"><span class="chordpro-chord" data-chord="$originalChord">$chord</span></span>';
      } else if (lyrics.hasText) {
        line +=
            '<span class="chordpro-block"><span class="chordpro-text">$text</span></span>';
      }
    }

    if (lyrics.hasInlineChords) {
      line += '<div class="chordpro-inline-block">';
      line += '<div class="chordpro-inline-chords">$lineChords</div>';
      line += lineText;
      line += '</div>';
    }
    row1 += '</tr>';
    row2 += '</tr>';
    line += row1;
    line += row2;
    line += '</table>';
    line += "\n</div>\n";
    print(line);
    return line;
  }

  String getLyricsOnlyHtml(Lyrics lyrics) {
    String text = '';
    for (var block in lyrics.blocks) {
      text += block.text.trimLeft();
    }
    text = text.trimRight();
    if (text.isEmpty) {
      return '';
    } else {
      return '<div class="chordpro-line">\n$text\n</div>\n';
    }
  }
}
