import 'package:chordspro_dart/chordspro_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

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
{key: F}
Details:
Current: Key- [F] ; 1st Intro Note- [C] ; 1st Verse Note- [C] ; Vocal Range- [C] – [F] (1.5 oct)
Original: Tempo- 4/4 125 BPM; Key- F; 1st Intro Note- C; 1st Verse Note- C; Vocal Range- C3 – F4
Play in C: Capo- 5; 1st Intro Note- G; 1st Verse Note- G
Play in G: Capo- 10; 1st Intro Note- D; 1st Verse Note- D

Intro:
[F]- - - [C7]- | [F]- - - - |

Verse (2x):
Ki [F]heim, ki heim cha[C7]yeinu
V'ō[C7]rech yomei[F]nu
Uvo[F]hem, uvohem ne-[C7]--ge
Uvo[C7]hem nege yōmom voloi[F]lo

Chorus (2x):
Ki [F]heim, ki heim cha[Bb]yei[F]nu
[Bb] V'ōrech [G7(b9)]yomei[F]nu
Uvo[Gm]hem, uvo[C7]hem ne-[Bb] [F]ge
Uvo[C7]hem nege yōmom voloi[F]lo

Interlude 1 (2x):
[F]- - - - | [C7]- - - - | - - - - | [F6]- - - - |
[F]- - - - | [C7]- - - - | - - - - | [F6]- - - - |

Interlude 2 (2x):
[F]- - - - | [Bb]- - [F]- - | [Bb]- - [G7(b9)]- - | [F]- - - - | 
[Gm]- - - [C7]- | [Bb]- - [F]- - | [C7]- - - - | [F]- - - - |

Verse (2x):
Ki [F]heim, ki heim cha[C7]yeinu
V'ō[C7]rech yomei[F]nu
Uvo[F]hem, uvohem ne-[C7]--ge
Uvo[C7]hem nege yōmom voloi[F]lo

Chorus:
Ki [F]heim, ki heim cha[Bb]yei[F]nu
[Bb] V'ō[G7(b9)]rech yomei[F]nu
Uvo[Gm]hem, uvo[C7]hem ne-[Bb] [F]ge
Uvo[C7]hem nege yōmom voloi[F]lo

Chorus to Outro:
Ki [F]heim, ki heim cha[Bb]yei[F]nu
[Bb] V'ō[G7(b9)]rech yomei[F]nu
Uvo[Gm]hem, uvo[C7]hem ne-[Bb] [F]ge
[C7]Uvohem nege, uvohem nege
[C7]Uvohem nege yōmom voloi[F]lo | - - - - |"
""";

  final parser = ChordsProParser();
  final htmlFormatter = HtmlFormatter();
  final monoSpaceFormatter = MonospaceFormatter();
  final widgetFormatter = WidgetFormatter();
  final transposer = ChordsProTransposer();
  String? html;
  List<Widget> widgets = [];
  int transpose = 0;

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
    originalSong = parser.parse(sampleSong, keyTonal: KeyTonal.original);
    widgets = widgetFormatter.format(originalSong);
    transpose = 0;
    setState(() {});
  }

  void transposeUp() {
    final song = getSong();

    transposer.transpose(song, 1, keyTonal: KeyTonal.sharp);
    widgets = widgetFormatter.format(song);
    setState(() {});
  }

  void transposeDown() {
    final song = getSong();

    transposer.transpose(song, -1, keyTonal: KeyTonal.sharp);
    widgets = widgetFormatter.format(song);
    setState(() {});
  }

  void transposeToKey() {
    final newSong = parser.parse(sampleSong, keyTonal: KeyTonal.original);
    transpose = 0;
    print('main');
    transposer.transpose(newSong, 'G#');
    originalSong = newSong;
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
      backgroundColor: Color(0xffE7E6E6),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                transposeToKey();
              },
              icon: Icon(Icons.settings))
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: transposeDown,
            child: Text('-'),
          ),
          FloatingActionButton(
            onPressed: transposeUp,
            child: Text('+'),
          ),
        ],
      ),
      body: widgets.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgets,
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
