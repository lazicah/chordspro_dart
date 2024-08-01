import 'package:chordspro_dart/src/models/line/line.dart';

class Metadata extends Line {
  final String name;
  final String? value;

  Metadata(String name, this.value) : name = _convertToFullName(name);

  String getNameSlug() {
    return _slugify(name);
  }

  static String _convertToFullName(String name) {
    switch (name) {
      case 't':
        return 'title';
      case 'st':
        return 'subtitle';
      case 'c':
        return 'comment';
      case 'ci':
        return 'comment_italic';
      case 'cb':
        return 'comment_box';
      case 'soc':
        return 'start_of_chorus';
      case 'eoc':
        return 'end_of_chorus';
      case 'sov':
        return 'start_of_verse';
      case 'eov':
        return 'end_of_verse';
      case 'sob':
        return 'start_of_bridge';
      case 'eob':
        return 'end_of_bridge';
      case 'sot':
        return 'start_of_tab';
      case 'eot':
        return 'end_of_tab';
      case 'sog':
        return 'start_of_grid';
      case 'eog':
        return 'end_of_grid';
      default:
        return name;
    }
  }

  String getHumanName() {
    switch (name) {
      case 'title':
        return 'Title';
      case 'subtitle':
        return 'Subtitle';
      case 'sorttitle':
        return 'Sort title';
      case 'comment':
        return 'Comment';
      case 'comment_italic':
        return 'Comment';
      case 'comment_box':
        return 'Comment';
      case 'key':
        return 'Key';
      case 'time':
        return 'Time';
      case 'tempo':
        return 'Tempo';
      case 'duration':
        return 'Duration';
      case 'capo':
        return 'Capo';
      case 'artist':
        return 'Artist';
      case 'composer':
        return 'Composer';
      case 'lyricist':
        return 'Lyricist';
      case 'album':
        return 'Album';
      case 'year':
        return 'Year';
      case 'copyright':
        return 'Copyright';
      case 'meta':
        return 'Meta';
      default:
        return name;
    }
  }

  bool isNameNecessary() {
    switch (name) {
      case 'title':
      case 'subtitle':
      case 'comment':
      case 'comment_italic':
      case 'comment_box':
      case 'artist':
        return false;
      default:
        return true;
    }
  }

  bool isSectionStart() {
    return name.startsWith('start_of_');
  }

  bool isSectionEnd() {
    return name.startsWith('end_of_');
  }

  String getSectionType() {
    final startMatch = RegExp(r'^start_of_(.*)').firstMatch(name);
    final endMatch = RegExp(r'^end_of_(.*)').firstMatch(name);

    if (startMatch != null) {
      return _slugify(startMatch.group(1)!);
    } else if (endMatch != null) {
      return _slugify(endMatch.group(1)!);
    } else {
      return '';
    }
  }

  String _slugify(String text) {
    text = text.replaceAll(RegExp(r'[^\p{L}\d]+'), '-');
    text = text.toLowerCase();
    text = text.replaceAll(RegExp(r'[^-\w]+'), '');
    text = text.trim().replaceAll(RegExp(r'-+'), '-');

    return text.isEmpty ? 'n-a' : text;
  }
}
