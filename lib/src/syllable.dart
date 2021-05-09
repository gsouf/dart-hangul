import 'jamo.dart';

/// position of first and last hangul syllables in the unicode table
const int _hangulFirstSyllable = 0xAC00;
const int _hangulLastSyllable = 0xD7A3;

/// An HangulSyllable instance contains 2 or 3 jamo forming a valid hangul character.
class HangulSyllable {
  /// Cho is first jamo (consonant).
  String _cho = '';

  /// Jung is middle jamo (vowel).
  String _jung = '';

  /// Jong is optional third jamo (consonant).
  String? _jong;

  /// Instantiates a syllable object from 3 valid jamos.
  ///
  /// 3 parameter [jong] is optional and can be set to bull
  ///
  /// ```dart
  /// HangulSyllable('ㄱ', 'ㅏ');         // '가'
  /// HangulSyllable('ㄱ', 'ㅏ', null);   // '가'
  /// HangulSyllable('ㄱ', 'ㅏ', 'ㄱ');   // '각'
  /// ```
  HangulSyllable(String cho, String jung, [String? jong]) {
    this.cho = cho;
    this.jung = jung;
    this.jong = jong;
  }

  /// Gets cho.
  String get cho => _cho;

  /// Gets jung.
  String get jung => _jung;

  /// Gets optional jong.
  String? get jong => _jong;

  /// Sets a valid cho jamo.
  set cho(String cho) {
    assert(isValidCho(cho), 'Invalid character provided for cho.');
    _cho = cho;
  }

  /// Sets a valid jung jamo.
  set jung(String jung) {
    assert(isValidJung(jung), 'Invalid character provided for jung.');
    _jung = jung;
  }

  /// Sets an optional valid jong jamo. Null being a valid value for jong.
  set jong(String? jong) {
    assert(isValidJong(jong), 'Invalid character provided for jong.');
    _jong = jong;
  }

  /// Instantiates a syllable from a valid hangul syllable character code.
  ///
  /// See [HangulSyllable.fromString] for alternative using a string.
  ///
  /// ```dart
  /// HangulSyllable.fromCharCode('하'.codeUnitAt(0));
  /// ```
  factory HangulSyllable.fromCharCode(int syllable) {
    return _parseHangulSyllable(syllable);
  }

  /// Instantiates a syllable from a valid hangul syllable string.
  ///
  /// See [HangulSyllable.fromCharCode] for alternative using a character code.
  ///
  /// ```dart
  /// HangulSyllable.fromString('하');
  /// ```
  factory HangulSyllable.fromString(String syllable) {
    assert(syllable.length == 1,
        'Syllable should be exactly 1 character long string.');
    return _parseHangulSyllable(syllable.codeUnitAt(0));
  }

  /// Assembles the 2 or 3 jamos composing the syllable into a single syllable character.
  ///
  /// ```dart
  /// HangulSyllable('ㄱ', 'ㅏ').toString();    // '가'
  /// ```
  @override
  String toString() {
    final choIndex = choJamos.indexOf(_cho);
    final jungIndex = jungJamos.indexOf(_jung);
    final jongIndex = _jong == null ? 0 : jongJamos.indexOf(_jong);

    final charCode =
        _hangulFirstSyllable + choIndex * 21 * 28 + jungIndex * 28 + jongIndex;

    return String.fromCharCode(charCode);
  }
}

/// Checks that given character code is an hangul syllable in the unicode table.
///
/// ```dart
/// isHangulSyllableCode('하'.codeUnitAt(0));    // true
/// ```
bool isHangulSyllableCode(int char) {
  return char >= _hangulFirstSyllable && char <= _hangulLastSyllable;
}

/// Checks that given character code is an hangul syllable in the unicode table.
///
/// ```dart
/// isHangulSyllable('하');    // true
/// ```
bool isHangulSyllable(String char) {
  if (char.length != 1) {
    return false;
  }
  return isHangulSyllableCode(char.codeUnitAt(0));
}

/// Disassembles a single unicode hangul syllable
HangulSyllable _parseHangulSyllable(int syllable) {
  assert(isHangulSyllableCode(syllable),
      'Trying to disassemble a character that is not a hangul syllable.');

  final charIndex = syllable - _hangulFirstSyllable;
  final jongIndex = charIndex % 28; // 28 being number of possible jong
  final jungIndex =
      ((charIndex - jongIndex) / 28) % 21; // 21 being number of possible jung
  final choIndex = (((charIndex - jongIndex) / 28) - jungIndex) / 21;
  return HangulSyllable(choJamos[choIndex.toInt()],
      jungJamos[jungIndex.toInt()], jongJamos[jongIndex]);
}
