# hangul

Manipulate hangul characters in dart.

## Getting Started

Hangul syllables are composed of 3 jamos:

- a "cho" jamo that is the first consonant
- a "jung" jamo that is the vowel
- an optional "jong" jamo that is the last consonant

The class `HangulSyllable` allows to split or to assemble the jamos.

### split a syllable into jamos

```dart
import 'package:hangul/hangul.dart';

final syllable = HangulSyllable.fromString('쪲');

syllable.cho == 'ㅉ'; // true
syllable.jung == 'ㅖ'; // true
syllable.jung == 'ㅄ'; // true
```

### assemble jamos into a syllable

```dart
import 'package:hangul/hangul.dart';

final syllable = HangulSyllable('ㅉ', 'ㅖ', 'ㅄ');

syllable.tostring() == '쪲'; // true
```

### throws on invalid characters

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

// check syllable
isHangulSyllable('쪲');   // true
isHangulSyllable('쪲가'); // false
isHangulSyllable('ㄱ');   // false
isHangulSyllable('q');   // false


// list of valid cho jung and jong are also exported:
final Set allJamos = {...choJamos, ...jungJamos, ...jongJamos};
```
