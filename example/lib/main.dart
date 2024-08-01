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
  final sampleSong = """{t:A Nice Sample Song}
{st:Grzegorz Pietrzak}
{key:C}

# Let's start it!
[C]Let's sing this [G]song [Am]together [Em]aloud
[F]It's an [C]example [Dm]with some nice [G]sound

{soc: Chorus}
[Bb]Whenever you [Am7]need to [Bb]format your [Am7]chords
[Dm]The solution to your [F]problems [G]is very close
{eoc}

{comment: Now we recite some text}
Sometimes you write text
And there's no more room for chords

{comment: Sometimes you play music without any words}
[C] [G] [Am] [Em]

You don't know where the chords are? ~ [F] [C]
You don't have to know ~ [G] [G/F#]

{sot: Outro}
E-12---------------------|
B----11-12---------------|
G----------11s13-14------|
D-------------------10-12|
A------------------------|
E------------------------|
{eot}

{comment: The end}
Let's finish this song. [G] It's the end of the show.
""";

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
