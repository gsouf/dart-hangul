import 'dart:collection';

/// character set
const List<String?> _jong = [
  null,
  'ㄱ',
  'ㄲ',
  'ㄳ',
  'ㄴ',
  'ㄵ',
  'ㄶ',
  'ㄷ',
  'ㄹ',
  'ㄺ',
  'ㄻ',
  'ㄼ',
  'ㄽ',
  'ㄾ',
  'ㄿ',
  'ㅀ',
  'ㅁ',
  'ㅂ',
  'ㅄ',
  'ㅅ',
  'ㅆ',
  'ㅇ',
  'ㅈ',
  'ㅊ',
  'ㅋ',
  'ㅌ',
  'ㅍ',
  'ㅎ'
];
const List<String> _jung = [
  'ㅏ',
  'ㅐ',
  'ㅑ',
  'ㅒ',
  'ㅓ',
  'ㅔ',
  'ㅕ',
  'ㅖ',
  'ㅗ',
  'ㅘ',
  'ㅙ',
  'ㅚ',
  'ㅛ',
  'ㅜ',
  'ㅝ',
  'ㅞ',
  'ㅟ',
  'ㅠ',
  'ㅡ',
  'ㅢ',
  'ㅣ'
];
const List<String> _cho = [
  'ㄱ',
  'ㄲ',
  'ㄴ',
  'ㄷ',
  'ㄸ',
  'ㄹ',
  'ㅁ',
  'ㅂ',
  'ㅃ',
  'ㅅ',
  'ㅆ',
  'ㅇ',
  'ㅈ',
  'ㅉ',
  'ㅊ',
  'ㅋ',
  'ㅌ',
  'ㅍ',
  'ㅎ'
];

final List<int> _choCharCode = _cho.map((e) => e.codeUnitAt(0)).toList();
final List<int> _jungCharCode = _jung.map((e) => e.codeUnitAt(0)).toList();
final List<int?> _jongCharCode = _jong.map((e) => e?.codeUnitAt(0)).toList();

/// List of valid cho jamos
final choJamos = UnmodifiableListView<String>(_cho);

/// List of valid jung jamos
final jungJamos = UnmodifiableListView<String>(_jung);

/// List of valid jong jamos
final jongJamos = UnmodifiableListView<String?>(_jong);

/// Checks that given character code is a valid cho jamo in the unicode table.
///
/// ```dart
/// isValidChoCode('ㄷ'.codeUnitAt(0));    // true
/// ```
bool isValidChoCode(int char) {
  return _choCharCode.contains(char);
}

/// Checks that given character code is a valid jung jamo in the unicode table.
///
/// ```dart
/// isValidJungCode('ㅔ'.codeUnitAt(0));    // true
/// ```
bool isValidJungCode(int char) {
  return _jungCharCode.contains(char);
}

/// Checks that given character code is a valid jong jamo in the unicode table.
///
/// ```dart
/// isValidJongCode('ㄴ'.codeUnitAt(0));    // true
/// ```
bool isValidJongCode(int char) {
  return _jongCharCode.contains(char);
}

/// Checks that given character code is a valid cho jamo in the unicode table.
///
/// ```dart
/// isValidCho('ㄷ');    // true
/// ```
bool isValidCho(String? char) {
  return _cho.contains(char);
}

/// Checks that given character code is a valid jung jamo in the unicode table.
///
/// ```dart
/// isValidJung('ㅔ');    // true
/// ```
bool isValidJung(String? char) {
  return _jung.contains(char);
}

/// Checks that given character code is a valid jong jamo in the unicode table.
///
/// ```dart
/// isValidJong('ㄴ');    // true
/// ```
bool isValidJong(String? char) {
  return _jong.contains(char);
}

/// Checks that given character is a valid jamo.
///
/// ```dart
/// isValidJamo('ㄴ');    // true
/// ```
bool isValidJamo(String? char) {
  return isValidCho(char) || isValidJong(char) || isValidJung(char);
}

/// Checks that given character code is a valid jamo.
///
/// ```dart
/// isValidJamoCode('ㄴ'.codeUnitAt(0));    // true
/// ```
bool isValidJamoCode(int char) {
  return isValidChoCode(char) || isValidJongCode(char) || isValidJungCode(char);
}
