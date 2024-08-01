# The chordpro-dart library 🎸

A simple tool to parse, transpose & format [ChordPro](https://www.chordpro.org) songs with lyrics & chords. 

Ported from <https://github.com/intelektron/chordpro-php> by [Grzegorz Pietrzak](https://github.com/intelektron), on LGPL-3 license._

The following output formats are currently supported:

- **HTML** (verses contain blocks with embedded `span` for aligning chords with lyrics).
- **JSON** (verses are arrays of chords and lyrics for alignment purposes).
- **Plain text** (chords are aligned with monospace text thanks to whitespace).
- **Widget** (chords are displayed with flutter widget that can be styled).

The library provides some extra functionality:

- Tranpose chords by semitones or to the target key.
- Parse and display various chord notations:
  - French (`Do`, `Ré`, `Mi`).
  - German (`Fis`, `a`).
  - With UTF characters (`A♭`, `F♯`).
- Guess the key of a song.

## Installation

Via composer:

``` bash
flutter pub get chordspro_dart
```

## Usage

See [Example](example/lib/main.dart) for demo.

![Screenshot](screenshot.jpeg)

## Formatting options

Simply give an array with values at true or false for each key/option.

``` dart
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
  });
```

## The song key

The key can be set/changed in the following ways:

- By parsing a song with metadata, e.g. `{key:A}`.
- By transposing the song to another key.

You can get the key by calling:

- `song.getKey()` - get the key if it is defined by `setKey()`, otherwise, use the key from the metadata.
- `song.getMetadataKey()` - get the key from the metadata.

If the song has no key defined, there is a possibility to guess it. This feature is experimental and not reliable (20% error rate, tested with ~1000 songs), but can be very useful.

``` dart
final guess = GuessKey();
final key = guess.guessKey(song);
```

## Chord notations

The library supports several chord notations. You can also create your own (by implementing [ChordNotationInterface.dart](lib/src/notation/ChordNotationInterface.dart]). Notations are used for both parsing and formatting. So you can parse a song in German notation and display it as French:

```dart
final txt = 'A typical [fis]German [a]verse';
final parser = ChordsProParser();
final notation = GermanChordNotation();
final song = parser.parse(song, notation)
```

At this point, `fis` is recognized and saved internally as `F#m`, and `a` is saved as `Am`. Note that you can pass multiple notations to the parser, in order of precedence. This can be useful if you have mixed up chord notations in one song.

Now, to show this song in French:

```dart
final monospaceFormatter = MonospaceFormatter();
final html = monospaceFormatter.format($song, options: FormatingOptions({notation: FrenchChordNotation()}));

//           Fa♯m   Lam
// A typical German verse
```

The `UtfChordFormatter` provides a nice-looking chords with `♭` and `♯` symbols instead of ASCII characters.

## Styling the HTML code

### Song lines

Lines are made up of blocks. Each block consists of a text and a chord. The chord has the class `chordpro-chord` and the text has the class `chordpro-text`.

A typical line of the song looks like this:

```html
<div class="chordpro-line">
    <span class="chordpro-block">
        <span class="chordpro-chord" data-chord="C">C</span>
        <span class="chordpro-text">This is the </span>
    </span>
    <span class="chordpro-block" data-chord="Dm">
        <span class="chordpro-chord">Dm</span>
        <span class="chordpro-text">beautiful song</span>
    </span>
</div>
```

The `data-chord` attribute stores an English representation of the chord, regardless of the output notation.

### Song sections

The ChordPro format allows to organize your songs into sections. The following song fragment:

```chordpro
{start_of_verse Verse 1}
...
{end_of_verse}

{start_of_foobar}
...
{end_of_foobar}
```

Will be converted to:

```html
<div class="chordpro-section-label chordpro-verse-label">Verse 1</div>
<div class="chordpro-section chordpro-verse">
    ...
</div>

<div class="chordpro-section chordpro-foobar">
    ...
</div>
```

You can use anything in place of `foobar`. However, the following shortcuts are supported:

- `{soc}` → `{start_of_chorus}`
- `{eoc}` → `{end_of_chorus}`
- `{sov}` → `{start_of_verse}`
- `{eov}` → `{end_of_verse}`
- `{sob}` → `{start_of_bridge}`
- `{eob}` → `{end_of_bridge}`
- `{sot}` → `{start_of_tab}`
- `{eot}` → `{end_of_tab}`
- `{sog}` → `{start_of_grid}`
- `{eog}` → `{end_of_grid}`

### Metadata

The library reads ChordPro metadata and renders it as HTML in the following way:

```chordpro
{title: Let's Sing!}
{c: Very loud}
{key: C}
```

Becomes:

``` html
<div class="chordpro-metadata chordpro-title">Let's Sing!</div>
<div class="chordpro-metadata chordpro-comment">Very loud</div>
<div class="chordpro-metadata chordpro-key">
    <span class="chordpro-metadata-name">Key: </span>
    <span class="chordpro-metadata-value">C</span>
</div>
```

The names of metadata are not restricted in any way, however, there are some standard ones described by ChordPro format. The following shortcuts are supported:

- `{t}` → `{title}`
- `{st}` → `{subtitle}`
- `{c}` → `{comment}`
- `{ci}` → `{comment_italic}`
- `{cb}` → `{comment_box}`

## Extensions to ChordPro 6.x

The library provides some non-standard features that can be useful for songbook creators.

### Inline chords

If you don't know how to assign the chord to syllables, or it's not important to you, you can use the inline chords assigned to the lyric line:

```chordpro
You don't know where the chords are? ~ [F] [C]
You don't have to know ~ [G] [G/F#]
```

The chords appear above the line (in the HTML formatter) or to the right (in the monospace formatter).