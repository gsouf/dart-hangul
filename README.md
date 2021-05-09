# Hangul

This package is an utility to manipulate korean hangul characters (한글) in dart.

## Install

```sh
$ dart pub add hangul
```

## Getting Started

The basics of the library is to manipulate hangul syllables.

A hangul syllable is composed of 3 jamos:

- a "cho" jamo that is the first consonant
- a "jung" jamo that is the vowel
- an optional "jong" jamo that is the last consonant

### split a syllable into jamos

`HangulSyllable.fromString` will split a given hangul syllable\
and return a valid HangulSyllable instance.

It throws if the given string is not a valid syllable.

```dart
import 'package:hangul/hangul.dart';

final syllable = HangulSyllable.fromString('쪲');

syllable.cho == 'ㅉ'; // true
syllable.jung == 'ㅖ'; // true
syllable.jung == 'ㅄ'; // true
```

### assemble jamos into a syllable


`HangulSyllable` constructor allows to instantiate a syllable from 3 valid jamos.

It throws if the given string is not a valid jamo (order for cho, jung and jong matters).

```dart
import 'package:hangul/hangul.dart';

final syllable = HangulSyllable('ㅉ', 'ㅖ', 'ㅄ');

syllable.tostring() == '쪲'; // true
```

The following will throw

```dart
import 'package:hangul/hangul.dart';

HangulSyllable('ㅆ', 'a');

// thrown AssertionError with message "Invalid character provided for jung."
```


### utilities

```dart
import 'package:hangul/hangul.dart';

// check jamo
isValidCho('ㄱ');  // true
isValidJung('ㅏ'); // true
isValidJong('ㄱ'); // true
isValidJong('ㅄ'); // true
isValidCho('ㅏ');  // false
isValidCho('ㅄ');  // false

// can also be used from character code
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

// list of valid cho jung and jong are also exported:
final Set allJamos = {...choJamos, ...jungJamos, ...jongJamos};
```
