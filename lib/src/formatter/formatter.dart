import 'package:chordspro_dart/src/formatter/formating_options.dart';
import 'package:chordspro_dart/src/notation/chord_notation_interface.dart';
import 'package:flutter/material.dart';

abstract class Formatter {
  ChordNotationInterface? notation;
  bool noChords = false;
  List<String> ignoreMetadata = [];
  double? breakPoint;
  double lineSpacing = 5;
  TextStyle textStyle = const TextStyle();
  TextStyle chordStyle = const TextStyle();
  TextStyle metadataStyle = const TextStyle();
  Color chordBgColor = Colors.white;
  double textScaleFactor = 1;
  double chordBgBorderRadius = 0;

  void setOptions(FormatingOptions options) {
    notation = null;
    noChords = false;
    ignoreMetadata = [];
    breakPoint = null;
    lineSpacing = 5;
    textStyle = const TextStyle();
    chordStyle = const TextStyle();
    metadataStyle = const TextStyle();
    chordBgColor = Colors.white;
    textScaleFactor = 1;
    chordBgBorderRadius = 0;

    if (options.notation != null) {
      notation = options.notation;
    }
    if (options.noChords != null && options.noChords!) {
      noChords = true;
    }
    if (options.ignoreMetadata.isNotEmpty) {
      ignoreMetadata = options.ignoreMetadata;
    }

    if (options.breakPoint != null) {
      breakPoint = options.breakPoint;
    }

    if (options.lineSpacing != null) {
      lineSpacing = options.lineSpacing!;
    }

    if (options.textStyle != null) {
      textStyle = options.textStyle!;
    }

    if (options.chordStyle != null) {
      chordStyle = options.chordStyle!;
    }

    if (options.metadataStyle != null) {
      metadataStyle = options.metadataStyle!;
    }

    if (options.chordBgColor != null) {
      chordBgColor = options.chordBgColor!;
    }

    if (options.textScaleFactor != null) {
      textScaleFactor = options.textScaleFactor!;
    }

    if (options.chordBgBorderRadius != null) {
      chordBgBorderRadius = options.chordBgBorderRadius!;
    }
  }
}
