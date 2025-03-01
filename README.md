# Hangul

This package is an utility to manipulate korean hangul characters (한글) in dart.

[![pub.dev - hangul](https://img.shields.io/badge/pub.dev-hangul-2ea44f)](https://pub.dev/packages/hangul)


# Install

```sh
$ dart pub add hangul
```

# Getting Started

The library is composed of 2 modules:
- HangulSyllable: to validate and create hangul syllables from jamos and to destruct syllables into jamos.
- HangulInput: to create hangul sentences from input string in order to emulate keyboard strokes.

# HangulSyllable

The basics of the library is to manipulate hangul syllables.

A hangul syllable is composed of 3 jamos:

- A "cho" jamo that is the first consonant.
- A "jung" jamo that is the vowel
- An optional "jong" jamo that is the last consonant.


Note that "double" characters such as ᅯ, ㅉ or ㅄ are considered as jamos.


## Split a syllable into 2 or 3 jamos

`HangulSyllable.fromString` will split a given hangul syllable
and return an instance of `HangulSyllable`.

It throws if the given string is not a valid syllable.

```dart
import 'package:hangul/hangul.dart';

final syllable = HangulSyllable.fromString('쪲');

syllable.cho == 'ㅉ'; // true
syllable.jung == 'ㅖ'; // true
syllable.jong == 'ㅄ'; // true
```

## Assemble 2 or 3 jamos into a single syllable


`HangulSyllable` constructor allows to instantiate a syllable from 3 valid jamos.

It throws if one of the given string is not a valid jamo (order for cho, jung and jong matters).

```dart
import 'package:hangul/hangul.dart';

final syllable = HangulSyllable('ㅉ', 'ㅖ', 'ㅄ');

syllable.tostring() == '쪲'; // true
```

The following will throw:

```dart
import 'package:hangul/hangul.dart';

HangulSyllable('ㅆ', 'a');

// thrown ArgumentError with message "Invalid character provided for jung."
```

# HangulInput

The class `HangulInput` will simulate the behavior of keyboard strokes. 
The goal is to make it possible to implement virtual keyboards.
It can also be used to combine a string of jamos together into a string of syllables.

```dart
import 'package:hangul/hangul.dart';

final input = HangulInput('');

input.pushCharacter('ㄷ');
input.pushCharacter('ㅏ');
input.pushCharacter('ㄹ');
input.pushCharacter('ㄱ');
input.pushCharacter('ㅇ');
input.pushCharacter('ㅡ');
input.pushCharacter('ㄴ');

print(input.text); // "닭은"

input.backspace();
print(input.text); // "닭ㅇ"

input.backspace();
input.backspace();
print(input.text); // "달"

// empty
input.clear();
print(input.text); // ""
```

# utilities

```dart
import 'package:hangul/hangul.dart';

// check jamo
isValidJamo('ㄱ');  // true
isValidCho('ㄱ');  // true
isValidJung('ㅏ'); // true
isValidJong('ㄱ'); // true
isValidJong('ㅄ'); // true
isValidCho('ㅏ');  // false
isValidCho('ㅄ');  // false

// can also be used from character code
isValidJamoCode('ㄱ'.codeUnitAt(0));  // true
isValidChoCode('ㄱ'.codeUnitAt(0));  // true
isValidJungCode('ㅏ'.codeUnitAt(0)); // true
isValidJongCode('ㄱ'.codeUnitAt(0)); // true

// check syllable
isHangulSyllable('쪲');   // true
isHangulSyllable('쪲가'); // false
isHangulSyllable('ㄱ');   // false
isHangulSyllable('q');   // false

// can also be used from character code
isHangulSyllableCode('쪲'.codeUnitAt(0));   // true

// check that ends with a jong character
syllableHasJong('하');    // false
syllableHasJong('은');    // true
syllableHasJong('a');    // false

// can also be used from character code
syllableCodeHasJong('하'.codeUnitAt(0));    // false
syllableCodeHasJong('은'.codeUnitAt(0));    // true
syllableCodeHasJong('a'.codeUnitAt(0));    // false


// list of valid cho jung and jong are also exported:
final Set allJamos = {...choJamos, ...jungJamos, ...jongJamos};
```
