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
  final parser = ChordsProParser();
  final htmlFormatter = HtmlFormatter();
  final monoSpaceFormatter = MonospaceFormatter();
  final widgetFormatter = WidgetFormatter();
  final transposer = ChordsProTransposer();
  String? html;
  List<Widget> widgets = [];
  int transpose = 0;

  @override
  void initState() {
    super.initState();
    parseData();
  }

  void parseData() {
    final song = parser.parse(sampleSong);
    widgets = widgetFormatter.format(song);
    setState(() {});
  }

  void transposeUp() {
    final song = parser.parse(sampleSong);
    transpose++;
    final transposedSong = transposer.transpose(song, transpose);
    widgets = widgetFormatter.format(transposedSong);
    setState(() {});
  }

  void transposeDown() {
    final song = parser.parse(sampleSong);
    transpose--;
    final transposedSong = transposer.transpose(song, transpose);
    widgets = widgetFormatter.format(transposedSong);
    setState(() {});
  }

  void transposeToKey() {
    final song = parser.parse(sampleSong);
    transpose = 0;
    final transposedSong = transposer.transpose(song, 'F#');
    widgets = widgetFormatter.format(transposedSong);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7E6E6),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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

const sampleSong = """"Details:
Current: Key- [Bbm] ; 1st Verse Note- [Db] ; Vocal Range- [Db] – [Gb] (1.5 oct)
Original: Tempo- 4/4 195 BPM; Key- Bbm; 1st Verse Note- Db; Vocal Range- Db3 – Gb4
Play in Am: Capo- 1; 1st Verse Note- C
Play in Em: Capo- 6; 1st Verse Note- G

Verse:
Korō[Bbm]v, korōv Hashem l'[Ebm]chol kō[Bbm]r'ov
L'[Ebm]chōl asher yikro'[Ab]uhu ve'e[Db]mes
Ko[Bbm]rōv, korōv Hashem l'[Ebm]chol kōr'ov
L'[Bbm]chōl asher yikro'[Bbm]u[F]hu ve'e[Bbm]mes

Chorus:
R't[Bbm]zōn y'rei'ov, r'tzōn y'[Ebm]rei'ov ya'a[F]se 
V'[F7]es, v'es shavosom yishma v'yōshi'[Bbm]eim - [F]- - |
R't[Bbm]zōn y'rei'ov, r't[Bb7]zōn y'rei'ov ya'a[Ebm]se 
V'[F]es, v'es shavosom yishma v'yōshi'[Bbm]eim"
""";
