import 'package:flutter/material.dart';

import 'package:chordspro_dart/src/notation/chord_notation_interface.dart';

class FormatingOptions {
  ChordNotationInterface? notation;
  bool? noChords;
  List<String> ignoreMetadata;

  /// Only works for WidgetFormatter
  double? breakPoint;
  double? lineSpacing;
  TextStyle? textStyle;
  TextStyle? chordStyle;
  TextStyle? metadataStyle;
  Color? chordBgColor;
  double? textScaleFactor;
  double? chordBgBorderRadius;

  FormatingOptions({
    this.notation,
    this.noChords,
    this.ignoreMetadata = const [],
    this.breakPoint,
    this.lineSpacing,
    this.textStyle,
    this.chordStyle,
    this.metadataStyle,
    this.chordBgColor,
    this.textScaleFactor,
    this.chordBgBorderRadius,
  });

  FormatingOptions.empty() : this();
}
