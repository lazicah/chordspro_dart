import 'package:chordspro_dart/src/formatter/formating_options.dart';
import 'package:chordspro_dart/src/formatter/formatter.dart';
import 'package:chordspro_dart/src/formatter/formatter_interface.dart';
import 'package:chordspro_dart/src/models/line/empty_line.dart';
import 'package:chordspro_dart/src/models/line/line.dart';
import 'package:chordspro_dart/src/models/line/lyrics.dart';
import 'package:chordspro_dart/src/models/line/metadata.dart';
import 'package:chordspro_dart/src/models/song.dart';

class MonospaceFormatter extends Formatter implements FormatterInterface {
  @override
  String format(Song song, {FormatingOptions? options}) {
    setOptions(options ?? FormatingOptions.empty());

    List<String> lines = [];
    for (var line in song.getLines()) {
      lines.add(getLineMonospace(line));
    }

    transformInlineChords(lines);
    return lines.join('');
  }

  String getLineMonospace(Line line) {
    if (line is Metadata) {
      return getMetadataMonospace(line);
    } else if (line is EmptyLine) {
      return '\n';
    } else if (line is Lyrics) {
      return noChords ? getLyricsOnlyMonospace(line) : getLyricsMonospace(line);
    } else {
      return '';
    }
  }

  String getMetadataMonospace(Metadata metadata) {
    if (ignoreMetadata.contains(metadata.name)) {
      return '';
    }

    if (metadata.isSectionStart()) {
      String type = metadata.getSectionType();
      String content = metadata.value != null
          ? '${metadata.value!.toUpperCase()}\n'
          : '${type.toUpperCase()}\n';
      return content;
    } else if (metadata.isSectionEnd()) {
      return '';
    } else {
      return metadata.isNameNecessary()
          ? '${metadata.getHumanName()}: ${metadata.value}\n'
          : '${metadata.value}\n';
    }
  }

  String generateBlank(int count) {
    return ' ' * count;
  }

  String getLyricsMonospace(Lyrics lyrics) {
    List<String> lineChords = [];
    String lineChordsWithBlanks = '';
    String lineTexts = '';
    String lineTextsWithBlanks = '';

    for (var block in lyrics.blocks) {
      List<String> chords = [];
      var slicedChords = block.chords;
      for (var slicedChord in slicedChords) {
        if (slicedChord.isKnown) {
          chords.add(slicedChord.getRootChord(notation) +
              slicedChord.getExt(notation));
        } else {
          chords.add(slicedChord.getOriginalName());
        }
      }

      String chord = chords.join('/');
      String text = block.text;
      String textWithBlanks = text;

      if (text.length < chord.length) {
        textWithBlanks = text + generateBlank(chord.length - text.length);
      }

      lineChordsWithBlanks += chord + generateBlank(text.length - chord.length);
      lineChords.add(chord);
      lineTexts += text;
      lineTextsWithBlanks += textWithBlanks;
    }

    String output = '';
    if (lyrics.hasInlineChords) {
      output += '~$lineTexts~${lineChords.join(' ')}\n';
    } else {
      if (lyrics.hasChords && lyrics.hasText) {
        output += '$lineChordsWithBlanks\n$lineTextsWithBlanks\n';
      } else if (lyrics.hasChords) {
        output += '${lineChords.join(' ')}\n';
      } else if (lyrics.hasText) {
        output += '$lineTexts\n';
      }
    }
    return output;
  }

  void transformInlineChords(List<String> lines) {
    Map<int, Map<String, String>> linesToFix = {};
    int longest = 0;

    for (int num = 0; num < lines.length; num++) {
      String line = lines[num];
      var match = RegExp(r'^~(.+)~(.+)').firstMatch(line);
      if (match != null) {
        linesToFix[num] = {
          'text': match.group(1)!.trim(),
          'chords': match.group(2)!.trim()
        };
        if (match.group(1)!.length > longest) {
          longest = match.group(1)!.length;
        }
      }
    }

    int inlineChordPosition = longest + 4;
    linesToFix.forEach((numb, lineToFix) {
      lines[numb] =
          '${lineToFix['text']!}${generateBlank(inlineChordPosition - lineToFix['text']!.length)}${lineToFix['chords']!}\n';
    });
  }

  String getLyricsOnlyMonospace(Lyrics lyrics) {
    String texts = '';
    for (var block in lyrics.blocks) {
      texts += block.text.trimLeft();
    }
    return texts.isNotEmpty ? '${texts.trimRight()}\n' : '';
  }
}
