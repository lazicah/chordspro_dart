import 'package:chordspro_dart/src/models/line/line.dart';
import 'package:chordspro_dart/src/models/line/metadata.dart';

class Song {
  String? _key;
  final List<Line> lines;

  Song(this.lines);

  String? getMetadataKey() {
    for (var line in lines) {
      if (line is Metadata && line.name == 'key') {
        return line.value;
      }
    }
    return null;
  }

  String? getMetadataValue(String key) {
    for (var line in lines) {
      if (line is Metadata && line.value!.contains(key)) {
        return line.value;
      }
    }
    return null;
  }

  String? getKey() {
    return _key ?? getMetadataKey();
  }

  void setKey(String value) {
    _key = value;
    for (var line in lines) {
      if (line is Metadata && line.name == 'key') {
        line.setValue(value);
      }
    }
  }

  List<Line> getLines() {
    return lines;
  }

  @override
  String toString() => 'Song(_key: $_key, lines: $lines)';
}
