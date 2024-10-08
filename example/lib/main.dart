import 'package:chordspro_dart/chordspro_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

const minorKeys = [
  "Am",
  "Bbm",
  "Bm",
  "Cm",
  "C#m",
  "Dm",
  "D#m",
  "Em",
  "Fm",
  "F#m",
  "Gm",
  "G#m"
];

const majorKeys = [
  "C",
  "Db",
  "D",
  "Eb",
  "E",
  "F",
  "F#",
  "G",
  "Ab",
  "A",
  "Bb",
  "B"
];

final flats = [
  'Am',
  'Bbm',
  'Cm',
  'Dm',
  'Fm',
  'Gm',
  'C',
  'Db',
  'Eb',
  'F',
  'Ab',
  'Bb',
];
final sharps = [
  'Bm',
  'C#m',
  'D#m',
  'Em',
  'F#m',
  'G#m',
  'D',
  'E',
  'F#',
  'G',
  'A',
  'B'
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final sampleSong = """"
{title: 25,000 Candles, V'zakeini 2}
{artist: Benny Friedman}
{key: B}
{time: 4/4}
{tempo: 110}
Producer- Bonei Olam; Arranger- Doni Gross; Composer- Miriam Israeli, Yitzy Waldner; Lyricist- Miriam Israeli; Album- Singles, 2021

These chords have not yet been edited or polished, but you should still find them useful.  I Hope you enjoy!

Details:
Current: Key- [B] ; 1st Intro Note- [A#] ; 1st Verse Note- [F#] ; Vocal Range- [B] – [B] (2.5 oct)
Original: Tempo- 4/4 110 BPM; Key- B; 1st Intro Note- F#; 1st Verse Note- F#; Vocal Range- B2 - B4
Play in C: Capo- 11; 1st Intro Note- B; 1st Verse Note- G
Play in G: Capo- 4; 1st Intro Note- F#; 1st Verse Note- D

Intro:
[E(add#11)]- - [E] - [Esus2]- | - - [E]- - | [B]- - [Bsus2] - [B5] - | [F#sus4]- - [F#]- - | 
[E(add#11)]- - [E] - [Esus2]- | - - [E]- - | [Bsus2]- [B]- - - | [B(add2)]- - - - |

Verse 1:
For [B]so many years they've been [F#/B]wai[B]ting
Now [G#m]finally [F#/A#]they're cele[F#/B]bra[B]ting
It's a [C#m7]girl, it's a boy, it's a [F#7]bundle of joy
A [E(add9)]baby is born, [F#sus4]Mazol tov [F#]- - |

For [B]so many years they'd i[F#/B]ma[B]gined
The [D#m7b5]miracle finally [Em7]happened
All the [G#m]prayers that were said, all the [C#m]tears that were shed
Brought [F#sus4]down the blessing from a[F#]bove

Bridge:
[F#] For there's a [G#m]power that [F#]can't be un[E]done
[E] When we u[B]nite in a cause, its a [C#m7(add11)]powerful force
And [E(add9)]all the gates will [E]open [F#sus4]up - - - | [F#]- - |

Chorus:
[F#]Twenty-five [B]thousand candles [C#m]burned
[C#m]Twenty-five [E]thousand hearts that [B]yearned
[B]Praying for a[D#m]nother, to be a [G#m]mother
Our [C#m7]deepest plea [F#sus4]- - |

[F#]Twenty-five [B]thousand gave their [C#m]share
[C#m]Twenty-five [E]thousand really [B]cared
[B] It's our am[D#m]bition, we've got a [G#m]mission
V'[C#m7]zakeini, [F#sus4] v'[F#]zakei[E(add#11)]ni…

Interlude:
[E(add#11)]- - [E] - [Esus2]- | - - [E]- - | [B]- - - - | [F#sus4]- - | 

Verse 2:
[F#] You're [B]making the circle grow [F#]wi[B]der
You're [G#m]helping the [F#/G#]world become [F#/B]brigh[B]ter
You're a [C#m7]link in the chain, to bring an [F#]end to the pain
You [E]fill our nation with [F#]light

The [B]number of candles keeps [F#/B]grow[B]ing
The [D#m7b5]light of our children keeps [Em7]glowing
And as you [G#m]whisper a prayer, for a [C#m7]sister out there
You're [F#sus4]helping us drive away in the [F#]night [F#sus4]- |

Bridge:
[F#] For there's a [G#m]power that [F#]can't be un[E]done
When we u[B]nite in a cause, its a [C#m7(add11)]powerful force
And [E(add9)]all the gates will [E]open [F#sus4]up - - - | [F#]- - |

Chorus:
[F#]Twenty-five [B]thousand candles [C#m]burned
[C#m]Twenty-five [E]thousand hearts that [B]yearned
[B]Praying for a[D#m]nother, to be a [G#m]mother
Our [C#m7]deepest plea [F#sus4]- - |

[F#]Twenty-five [B]thousand gave their [C#m]share
[C#m]Twenty-five [E]thousand really [B]cared
[B] It's our am[D#m]bition, we've got a [G#m]mission
V'[C#m7]zakeini, [F#sus4]- - [F#]- - |

Sax solo:
[B]- - - - | - - - - | [D#m]- - - - | - - - - |
[G#m]- - - - | [E]- - - - | [Ebsus4]- - - - | [Eb]- - - - |

Interlude (La, la la…)
[Abm]- - - - | [Gb]- - - - | [Ebm]- - - - | [E]- - - - |
[Dbm]- - - - | [Ebm]- - - - | [Absus4]- - - - | [Ab]- - |

Chorus:
[Ab]Twenty-five [Db]thousand candles [Ebm]burned
[Ebm]Twenty-five [Gb]thousand hearts that [Db]yearned
[Db]Praying for a[Fm]nother, to be a [Bbm]mother
Our [Ebm7]deepest plea [Absus4]- - |

[Ab]Twenty-five [Db]thousand gave their [Ebm]share
[Ebm]Twenty-five [Gb]thousand really [Db]cared
[Db] It's our am[Fm]bition, we've got a [Bbm]mission
V'[Ebm7]zakeini, [Absus4]- - |

Chorus 2:
[Ab]Twenty-five [Db]thousand candles [Ebm]bright
[Ebm] How many [Gb]more can we ig[Db]nite
Illumi[Fm]nating, as we're cre[Bbm]ating
E[Ebm7]terni[Absus4]ty

[Ab]Twenty-five [Dbsus4]thou[Db]sand, we've just be[Ebm]gun
[Ebm]Let's keep on [Gb]adding one-by-[Db]one
[Db]We're on a [Fm]mission, it's our am[Bbm]bition
V'[Ebm7]zakeini, [Absus4] v'[Ab]za[Db]keini…

Outro:
[Db]- - - - | [Gb/Db]- - - - | [Db]- - [Dbsus4]- - | [Db(add2)]- |

Performer- Benny Friedman; Album- Singles

Translation:
N/A
- N/A
- N/A"
""";

  final parser = ChordsProParser();
  final htmlFormatter = HtmlFormatter();
  final monoSpaceFormatter = MonospaceFormatter();
  final widgetFormatter = WidgetFormatter();
  final transposer = ChordsProTransposer();
  String? html;
  List<Widget> widgets = [];
  int transpose = 0;
  KeyTonal _keyTonal = KeyTonal.sharp;

  late Song originalSong;

  @override
  void initState() {
    super.initState();
    parseData();
  }

  Song getSong() {
    return originalSong;
  }

  void parseData() {
    originalSong = parser.parse(sampleSong, keyTonal: _keyTonal);
    widgets = widgetFormatter.format(originalSong);
    transpose = 0;
    setState(() {});
  }

  void transposeUp() {
    final song = getSong();
    final newKey = _transposeUp(song.getKey()!);

    if (newKey != null) {
      transposeToKey(newKey);
    }
  }

  void transposeDown() {
    final song = getSong();
    final newKey = _transposeDown(song.getKey()!);

    if (newKey != null) {
      transposeToKey(newKey);
    }
  }

  String? _transposeUp(String key) {
    int minorIndex = minorKeys.indexOf(key);
    if (minorIndex != -1) {
      // If key is in minor keys
      return minorKeys[(minorIndex + 1) % minorKeys.length];
    }

    int majorIndex = majorKeys.indexOf(key);
    if (majorIndex != -1) {
      // If key is in major keys
      return majorKeys[(majorIndex + 1) % majorKeys.length];
    }

    // Key not found in either array
    return null;
  }

  String? _transposeDown(String key) {
    int minorIndex = minorKeys.indexOf(key);
    if (minorIndex != -1) {
      // If key is in minor keys
      return minorKeys[(minorIndex - 1 + minorKeys.length) % minorKeys.length];
    }

    int majorIndex = majorKeys.indexOf(key);
    if (majorIndex != -1) {
      // If key is in major keys
      return majorKeys[(majorIndex - 1 + majorKeys.length) % majorKeys.length];
    }

    // Key not found in either array
    return null;
  }

  void transposeToKey(String key) {
    final song = getSong();
    transposer.transpose(song, key, _keyTonal);
    originalSong = song;
    widgets = widgetFormatter.format(originalSong);
    setState(() {});
  }

  void reformatSong() {
    final song = getSong();
    parser.changeSongTone(song, keyTonal: _keyTonal);
    originalSong = song;
    widgets = widgetFormatter.format(originalSong);
    setState(() {});
  }

  @override
  void reassemble() {
    parseData();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7E6E6),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                transposeToKey('G#');
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: transposeDown,
            child: const Text('-'),
          ),
          FloatingActionButton(
            onPressed: transposeUp,
            child: const Text('+'),
          ),
        ],
      ),
      body: widgets.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ToggleButtons(
                    isSelected: [
                      _keyTonal == KeyTonal.sharp,
                      _keyTonal == KeyTonal.flat,
                    ],
                    onPressed: (index) {
                      setState(() {
                        _keyTonal = index == 0 ? KeyTonal.sharp : KeyTonal.flat;
                      });

                      reformatSong();
                    },
                    children: const [Text('#'), Text('b')],
                  ),
                  ...widgets
                ],
              ),
            )
          : html != null
              ? SingleChildScrollView(child: Text(html!))
              // ? SingleChildScrollView(
              //     child: HtmlWidget(
              //     html!,
              //     customStylesBuilder: (element) {
              //       if (element.classes.contains('chordpro-chord') &&
              //           element.innerHtml.isNotEmpty) {
              //         return {
              //           'color': 'rgb(0, 0, 0)',
              //           'background-color': 'rgb(255, 255, 255)',
              //         };
              //       }

              //       if (element.classes.contains('chordpro-table')) {
              //         return {
              //           "display": "table",
              //           "border-collapse": "separate",
              //           "box-sizing": "border-box",
              //           "text-indent": "initial",
              //           "unicode-bidi": "isolate",
              //           "border-spacing": "4px",
              //           "border-color": "black",
              //         };
              //       }

              //       if (element.classes.contains('chordpro-inline-chords')) {
              //         return {'color': 'blue'};
              //       }

              //       if (element.classes.contains('chordpro-text')) {
              //         return {"font-family": "Roboto Mono"};
              //       }

              //       return null;
              //     },
              //   ))
              : Container(),
    );
  }
}
