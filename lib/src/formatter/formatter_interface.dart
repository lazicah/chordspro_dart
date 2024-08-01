import 'package:chordspro_dart/src/formatter/formating_options.dart';
import 'package:chordspro_dart/src/models/song.dart';

abstract class FormatterInterface<T> {
  T format(Song song, {FormatingOptions? options});
}
