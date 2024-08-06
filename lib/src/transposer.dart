import 'package:chordspro_dart/src/models/block.dart';
import 'package:chordspro_dart/src/models/chord.dart';
import 'package:chordspro_dart/src/models/key_tonal.dart';
import 'package:chordspro_dart/src/models/line/line.dart';
import 'package:chordspro_dart/src/models/line/lyrics.dart';
import 'package:chordspro_dart/src/models/song.dart';

class ChordsProTransposer {
  // The table of chord key mappings to semitones.
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

  // final Map<String, int> simpleMinorTransposeTable = {
  //   'Am': 0,
  //   'A#m': 1,
  //   'Bbm': 1,
  //   'Bm': 2,
  //   'Cm': 3,
  //   'C#m': 4,
  //   'Dbm': 4,
  //   'Dm': 5,
  //   'Ebm': 6,
  //   'D#m': 6,
  //   'Em': 7,
  //   'Fm': 8,
  //   'F#m': 9,
  //   'Gbm': 9,
  //   'Gm': 10,
  //   'G#m': 11,
  //   'Abm': 11,
  // };

  // The table of chord key mappings for [transposeTable].
  // final Map<String, int> transposeChords = {
  //   'C': 0,
  //   'C#': 1,
  //   'Db': 1,
  //   'D': 2,
  //   'D#': 3,
  //   'Eb': 3,
  //   'E': 4,
  //   'F': 5,
  //   'F#': 6,
  //   'Gb': 6,
  //   'G': 7,
  //   'G#': 8,
  //   'Ab': 8,
  //   'A': 9,
  //   'A#': 10,
  //   'Bb': 10,
  //   'B': 11,
  //   'Cb': 11,
  //   'Dbm': 1,
  //   'C#m': 1,
  //   'D#m': 3,
  //   'Ebm': 3,
  //   'Em': 4,
  //   'Fm': 5,
  //   'F#m': 6,
  //   'G#m': 8,
  //   'Abm': 8,
  //   'Am': 9,
  //   'A#m': 10,
  //   'Bbm': 10,
  //   'Bm': 11,
  // };

  final Map<String, int> transposeChords = {
    'Fb': 0,
    'Cb': 1,
    'Gb': 2,
    'Db': 3,
    'Ab': 4,
    'Eb': 5,
    'Bb': 6,
    'F': 7,
    'C': 8,
    'G': 9,
    'D': 10,
    'A': 11,
    'E': 12,
    'B': 13,
    'F#': 14,
    'C#': 15,
    'G#': 16,
    'Dbm': 0,
    'Abm': 1,
    'Ebm': 2,
    'Bbm': 3,
    'Fm': 4,
    'Cm': 5,
    'Gm': 6,
    'Dm': 7,
    'Am': 8,
    'Em': 9,
    'Bm': 10,
    'F#m': 11,
    'C#m': 12,
    'G#m': 13,
    'D#m': 14,
    'A#m': 15,
    'E#m': 16,
  };

  // The table of chord key mappings to transpose.
  final List<List<String>> transposeTable = [
    // // C major scale
    // [
    //   'C',
    //   'C#',
    //   'D',
    //   'D#',
    //   'E',
    //   'F',
    //   'F#',
    //   'G',
    //   'G#',
    //   'A',
    //   'A#',
    //   'B',
    //   'Cb',
    //   'Db',
    //   'Eb',
    //   'Fb',
    //   'Gb',
    //   'Ab',
    //   'Bb'
    // ],
    // // C# major scale
    // [
    //   'C#',
    //   'D',
    //   'D#',
    //   'E',
    //   'E#',
    //   'F#',
    //   'G',
    //   'G#',
    //   'A',
    //   'A#',
    //   'B',
    //   'B#',
    //   'Db',
    //   'Eb',
    //   'Fb',
    //   'F#',
    //   'Gb',
    //   'Ab',
    //   'Bb',
    //   'C'
    // ],
    // // D major scale
    // [
    //   'D',
    //   'D#',
    //   'E',
    //   'E#',
    //   'F#',
    //   'G',
    //   'G#',
    //   'A',
    //   'A#',
    //   'B',
    //   'B#',
    //   'C#',
    //   'Eb',
    //   'Fb',
    //   'Gb',
    //   'Ab',
    //   'Bb',
    //   'C',
    //   'Db',
    //   'E'
    // ],
    // // D# major scale
    // [
    //   'D#',
    //   'E',
    //   'E#',
    //   'F#',
    //   'G',
    //   'G#',
    //   'A',
    //   'A#',
    //   'B',
    //   'B#',
    //   'C#',
    //   'D',
    //   'Fb',
    //   'Gb',
    //   'Ab',
    //   'Bb',
    //   'C',
    //   'Db',
    //   'E',
    //   'F'
    // ],
    // // E major scale
    // [
    //   'E',
    //   'E#',
    //   'F#',
    //   'G',
    //   'G#',
    //   'A',
    //   'A#',
    //   'B',
    //   'B#',
    //   'C#',
    //   'D',
    //   'D#',
    //   'Gb',
    //   'Ab',
    //   'Bb',
    //   'C',
    //   'Db',
    //   'E',
    //   'F',
    //   'G'
    // ],
    // // F major scale
    // [
    //   'F',
    //   'F#',
    //   'G',
    //   'G#',
    //   'A',
    //   'A#',
    //   'B',
    //   'C',
    //   'C#',
    //   'D',
    //   'D#',
    //   'E',
    //   'Gb',
    //   'Ab',
    //   'Bb',
    //   'C',
    //   'Db',
    //   'E',
    //   'F',
    //   'G'
    // ],
    // // F# major scale
    // [
    //   'F#',
    //   'G',
    //   'G#',
    //   'A',
    //   'A#',
    //   'B',
    //   'C',
    //   'C#',
    //   'D',
    //   'D#',
    //   'E',
    //   'F',
    //   'Ab',
    //   'Bb',
    //   'C',
    //   'Db',
    //   'E',
    //   'F',
    //   'G',
    //   'A'
    // ],
    // // G major scale
    // [
    //   'G',
    //   'G#',
    //   'A',
    //   'A#',
    //   'B',
    //   'C',
    //   'C#',
    //   'D',
    //   'D#',
    //   'E',
    //   'F',
    //   'F#',
    //   'Bb',
    //   'C',
    //   'Db',
    //   'E',
    //   'F',
    //   'G',
    //   'A',
    //   'B'
    // ],
    // // G# major scale
    // [
    //   'G#',
    //   'A',
    //   'A#',
    //   'B',
    //   'C',
    //   'C#',
    //   'D',
    //   'D#',
    //   'E',
    //   'F',
    //   'F#',
    //   'G',
    //   'C',
    //   'Db',
    //   'E',
    //   'F',
    //   'G',
    //   'A',
    //   'B',
    //   'C#'
    // ],
    // // A major scale
    // [
    //   'A',
    //   'A#',
    //   'B',
    //   'C',
    //   'C#',
    //   'D',
    //   'D#',
    //   'E',
    //   'F',
    //   'F#',
    //   'G',
    //   'G#',
    //   'Db',
    //   'E',
    //   'F',
    //   'G',
    //   'A',
    //   'B',
    //   'C#',
    //   'D#'
    // ],
    // // A# major scale
    // [
    //   'A#',
    //   'B',
    //   'C',
    //   'C#',
    //   'D',
    //   'D#',
    //   'E',
    //   'F',
    //   'F#',
    //   'G',
    //   'G#',
    //   'A',
    //   'E',
    //   'F',
    //   'G',
    //   'A',
    //   'B',
    //   'C#',
    //   'D#',
    //   'F'
    // ],
    // // B major scale
    // [
    //   'B',
    //   'C',
    //   'C#',
    //   'D',
    //   'D#',
    //   'E',
    //   'F',
    //   'F#',
    //   'G',
    //   'G#',
    //   'A',
    //   'A#',
    //   'F',
    //   'G',
    //   'A',
    //   'B',
    //   'C#',
    //   'D#',
    //   'F',
    //   'G#'
    // ],
    // // Db major scale
    // [
    //   'Db',
    //   'D',
    //   'D#',
    //   'E',
    //   'F',
    //   'F#',
    //   'G',
    //   'G#',
    //   'A',
    //   'A#',
    //   'B',
    //   'C',
    //   'Gb',
    //   'Ab',
    //   'Bb',
    //   'C',
    //   'Db',
    //   'Eb',
    //   'F',
    //   'G'
    // ],
    // // Eb major scale
    // [
    //   'Eb',
    //   'E',
    //   'F',
    //   'F#',
    //   'G',
    //   'G#',
    //   'A',
    //   'A#',
    //   'B',
    //   'C',
    //   'C#',
    //   'D',
    //   'Ab',
    //   'Bb',
    //   'C',
    //   'Db',
    //   'Eb',
    //   'F',
    //   'G',
    //   'A'
    // ],
    // // Gb major scale
    // [
    //   'Gb',
    //   'G',
    //   'G#',
    //   'A',
    //   'A#',
    //   'B',
    //   'C',
    //   'C#',
    //   'D',
    //   'D#',
    //   'E',
    //   'F',
    //   'Bb',
    //   'C',
    //   'Db',
    //   'Eb',
    //   'F',
    //   'G',
    //   'A',
    //   'B'
    // ],
    // // Ab major scale
    // [
    //   'Ab',
    //   'A',
    //   'A#',
    //   'B',
    //   'C',
    //   'C#',
    //   'D',
    //   'D#',
    //   'E',
    //   'F',
    //   'F#',
    //   'G',
    //   'Db',
    //   'Eb',
    //   'F',
    //   'Gb',
    //   'Ab',
    //   'Bb',
    //   'C',
    //   'D'
    // ],
    // // Bb major scale
    // [
    //   'Bb',
    //   'B',
    //   'C',
    //   'C#',
    //   'D',
    //   'D#',
    //   'E',
    //   'F',
    //   'F#',
    //   'G',
    //   'G#',
    //   'A',
    //   'Eb',
    //   'F',
    //   'G',
    //   'Ab',
    //   'Bb',
    //   'C',
    //   'D',
    //   'E'
    // ]
    [
      'E',
      'F',
      'F',
      'Gb',
      'G',
      'G',
      'Ab',
      'A',
      'A',
      'Bb',
      'Bb',
      'B',
      'C',
      'C',
      'Db',
      'D',
      'D',
      'Eb'
    ],
    [
      'B',
      'C',
      'C',
      'Db',
      'D',
      'D',
      'Eb',
      'E',
      'E',
      'F',
      'F',
      'Gb',
      'G',
      'G',
      'Ab',
      'A',
      'A',
      'Bb'
    ],
    [
      'F',
      'G',
      'G',
      'Ab',
      'A',
      'A',
      'Bb',
      'B',
      'B',
      'C',
      'C',
      'Db',
      'D',
      'D',
      'Eb',
      'E',
      'E',
      'F'
    ],
    [
      'Db',
      'D',
      'D',
      'Eb',
      'E',
      'E',
      'F',
      'F#',
      'Gb',
      'G',
      'G',
      'Ab',
      'A',
      'A',
      'Bb',
      'B',
      'B',
      'C'
    ],
    [
      'Ab',
      'A',
      'A',
      'Bb',
      'B',
      'B',
      'C',
      'C#',
      'Db',
      'D',
      'D',
      'Eb',
      'E',
      'E',
      'F',
      'F#',
      'Gb',
      'G'
    ],
    [
      'Eb',
      'E',
      'E',
      'F',
      'F#',
      'Gb',
      'G',
      'G#',
      'Ab',
      'A',
      'A',
      'Bb',
      'B',
      'B',
      'C',
      'C#',
      'Db',
      'D'
    ],
    [
      'Bb',
      'B',
      'B',
      'C',
      'C#',
      'Db',
      'D',
      'D#',
      'Eb',
      'E',
      'E',
      'F',
      'F#',
      'Gb',
      'G',
      'G#',
      'Ab',
      'A'
    ],
    [
      'F',
      'F#',
      'Gb',
      'G',
      'G#',
      'Ab',
      'A',
      'A#',
      'Bb',
      'B',
      'B',
      'C',
      'C#',
      'Db',
      'D',
      'D#',
      'Eb',
      'E'
    ],
    [
      'C',
      'C#',
      'Db',
      'D',
      'D#',
      'Eb',
      'E',
      'F',
      'F',
      'F#',
      'Gb',
      'G',
      'G#',
      'Ab',
      'A',
      'A#',
      'Bb',
      'B'
    ],
    [
      'G',
      'G#',
      'Ab',
      'A',
      'A#',
      'Bb',
      'B',
      'C',
      'C',
      'C#',
      'Db',
      'D',
      'D#',
      'Eb',
      'E',
      'F',
      'F#'
    ],
    [
      'D',
      'D#',
      'Eb',
      'E',
      'F',
      'F',
      'F#',
      'G',
      'G',
      'G#',
      'Ab',
      'A',
      'A#',
      'Bb',
      'B',
      'C',
      'C#'
    ],
    [
      'A',
      'A#',
      'Bb',
      'B',
      'C',
      'C',
      'C#',
      'D',
      'D',
      'D#',
      'Eb',
      'E',
      'F',
      'F',
      'F#',
      'G',
      'G#'
    ],
    [
      'E',
      'F',
      'F',
      'F#',
      'G',
      'G',
      'G#',
      'A',
      'A',
      'A#',
      'Bb',
      'B',
      'C',
      'C',
      'C#',
      'D',
      'D#'
    ],
    [
      'B',
      'C',
      'C',
      'C#',
      'D',
      'D',
      'D#',
      'E',
      'E',
      'F',
      'F',
      'F#',
      'G',
      'G',
      'G#',
      'A',
      'A#'
    ],
    [
      'F#',
      'G',
      'G',
      'G#',
      'A',
      'A',
      'A#',
      'B',
      'B',
      'C',
      'C',
      'C#',
      'D',
      'D',
      'D#',
      'E',
      'E'
    ],
    [
      'C#',
      'D',
      'D',
      'D#',
      'E',
      'E',
      'F',
      'F#',
      'F#',
      'G',
      'G',
      'G#',
      'A',
      'A',
      'A#',
      'B',
      'B'
    ],
    [
      'G#',
      'A',
      'A',
      'A#',
      'B',
      'B',
      'C',
      'C#',
      'C#',
      'D',
      'D',
      'D#',
      'E',
      'E',
      'F',
      'F#',
      'F#'
    ]
  ];

  transpose(Song song, dynamic value, {KeyTonal keyTonal = KeyTonal.original}) {
    List<Block> blocks = [];
    for (var line in song.getLines()) {
      if (line is Lyrics) {
        for (var block in line.blocks) {
          var chords = block.chords;
          if (chords.isNotEmpty) {
            if (value is int) {
              blocks.add(block);
              simpleTranspose(song, chords, value, keyTonal: keyTonal);
            } else if (song.getKey() != null) {
              completeTranspose(
                chords,
                song.getKey()!,
                value,
                keyTonal: keyTonal,
              );
            }
          }
        }
      }
    }
    if (value is! int) {
      song.setKey(value);
    } else {
      final firstBlock = blocks.first;
      song.setKey(firstBlock.chords.first.getRootChord());
    }
  }

  void simpleTranspose(Song song, List<Chord> chords, int value,
      {KeyTonal keyTonal = KeyTonal.original}) {
    for (var chord in chords) {
      if (!chord.isKnown) continue;

      if (value != 0 && value < 12 && value > -12) {
        var suffix = chord.isMinor ? 'm' : '';
        var key =
            simpleTransposeTable[chord.getRootChord().replaceAll('m', '')]!;
        var newKey =
            (key + value < 0) ? 12 + (key + value) : (key + value) % 12;

        var transposedChord = simpleTransposeTable.entries
            .firstWhere((entry) => entry.value == newKey)
            .key;

        if (keyTonal != KeyTonal.original) {
          transposedChord =
              _getSharpOrFlatChord(transposedChord, keyTonal == KeyTonal.sharp);
        }

        chord.transposeTo(transposedChord + suffix);
      } else {
        if (keyTonal != KeyTonal.original) {
          var suffix = chord.isMinor ? 'm' : '';

          final transposedChord = _getSharpOrFlatChord(
              chord.getRootChord().replaceAll('m', ''),
              keyTonal == KeyTonal.sharp);

          chord.transposeTo(transposedChord + suffix);
        }
      }
    }
  }

  void completeTranspose(List<Chord> chords, String fromKey, String toKey,
      {KeyTonal keyTonal = KeyTonal.original}) {
    for (var chord in chords) {
      var suffix = chord.isMinor ? 'm' : '';
      print('Root chord: ${chord.getRootChord().replaceAll('m', '')}');
      print('From: $fromKey');
      print('To: $toKey');
      var rank = transposeTable[transposeChords[fromKey]!]
          .indexOf(chord.getRootChord().replaceAll('m', ''));
      print('Rank: $rank');
      var transposedChord = transposeTable[transposeChords[toKey]!][rank];

      if (keyTonal != KeyTonal.original) {
        transposedChord =
            _getSharpOrFlatChord(transposedChord, keyTonal == KeyTonal.sharp);
      }
      chord.transposeTo(transposedChord + suffix);
    }
  }

  // Method to transpose a song to its sharp or flat variants
  void transposeToSharpOrFlat(Song song, {bool toSharp = true}) {
    for (var line in song.getLines()) {
      if (line is Lyrics) {
        for (var block in line.blocks) {
          var chords = block.chords;
          if (chords.isNotEmpty) {
            for (var chord in chords) {
              if (!chord.isKnown) continue;

              var rootChord = chord.getRootChord();
              var suffix = chord.isMinor ? 'm' : '';
              var transposedChord = _getSharpOrFlatChord(rootChord, toSharp);
              chord.transposeTo(transposedChord + suffix);
            }
          }
        }
      }
    }
  }

  // String _getSharpOrFlatChord(String chord, bool toSharp) {
  //   var root = chord.replaceAll('m', ''); // Remove 'm' for minor chords
  //   var semitone = simpleTransposeTable[root]!;

  //   var transposedChord = root;
  //   if (toSharp) {
  //     transposedChord = simpleTransposeTable.entries
  //         .firstWhere(
  //           (entry) => entry.value == semitone && entry.key.contains('#'),
  //           orElse: () => MapEntry(transposedChord, -1),
  //         )
  //         .key;
  //   } else {
  //     transposedChord = simpleTransposeTable.entries
  //         .firstWhere(
  //           (entry) => entry.value == semitone && entry.key.contains('b'),
  //           orElse: () => MapEntry(transposedChord, -1),
  //         )
  //         .key;
  //   }
  //   return transposedChord; // Return original chord if not found
  // }

  // Helper function to convert chord to sharp or flat
  String _getSharpOrFlatChord(String chord, bool toSharp) {
    // Define sharp and flat equivalents
    final Map<String, String> flatToSharp = {
      'Bb': 'A#',
      'Db': 'C#',
      'Eb': 'D#',
      'Gb': 'F#',
      'Ab': 'G#',
    };
    final Map<String, String> sharpToFlat = {
      'A#': 'Bb',
      'C#': 'Db',
      'D#': 'Eb',
      'F#': 'Gb',
      'G#': 'Ab',
    };

    if (toSharp && flatToSharp.containsKey(chord)) {
      return flatToSharp[chord]!;
    } else if (!toSharp && sharpToFlat.containsKey(chord)) {
      return sharpToFlat[chord]!;
    }

    return chord; // If no conversion is needed, return the original chord
  }
}
