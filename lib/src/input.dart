import 'package:hangul/hangul.dart';
import 'package:hangul/src/jamo.dart';

const Map<String, String> _jongCombinations = {
  'ㄱㄱ': 'ㄲ',
  'ㄱㅅ': 'ㄳ',
  'ㄴㅈ': 'ㄵ',
  'ㄴㅎ': 'ㄶ',
  'ㄹㄱ': 'ㄺ',
  'ㄹㅁ': 'ㄻ',
  'ㄹㅂ': 'ㄼ',
  'ㄹㅅ': 'ㄽ',
  'ㄹㅌ': 'ㄾ',
  'ㄹㅍ': 'ㄿ',
  'ㄹㅎ': 'ㅀ',
  'ㅂㅅ': 'ㅄ',
  'ㅅㅅ': 'ㅆ',
};

const Map<String, String> _jungCombinations = {
  'ㅗㅏ': 'ㅘ',
  'ㅗㅐ': 'ㅙ',
  'ㅗㅣ': 'ㅚ',
  'ㅜㅓ': 'ㅝ',
  'ㅜㅔ': 'ㅞ',
  'ㅜㅣ': 'ㅟ',
  'ㅡㅣ': 'ㅢ',
};

const Map<String, String> _choCombinations = {
  'ㄱㄱ': 'ㄲ',
  'ㄷㄷ': 'ㄸ',
  'ㅂㅂ': 'ㅃ',
  'ㅅㅅ': 'ㅆ',
  'ㅈㅈ': 'ㅉ'
};

class HangulInput {
  String _text;
  bool hasBreak = false;
  HangulInput(this._text);

  String get text => _text;

  void pushCharacter(String newChar) {
    if (isValidJamo(newChar) && !hasBreak) {
      final currentFinalCharacter =
          _text.isEmpty ? '' : _text.substring(_text.length - 1);

      if (isHangulSyllable(currentFinalCharacter)) {
        _addToSyllable(newChar, currentFinalCharacter);
      } else if (isValidCho(currentFinalCharacter)) {
        _addToCho(newChar, currentFinalCharacter);
      } else {
        _concatCharacter(newChar);
      }
    } else {
      _concatCharacter(newChar);
    }
  }

  void _addToCho(String newChar, String currentFinalCharacter) {
    if (_choCombinations.containsKey(currentFinalCharacter + newChar)) {
      _replaceFinalCharacter(
          _choCombinations[currentFinalCharacter + newChar]!);
    } else if (isValidJung(newChar)) {
      final newSyllable = HangulSyllable(currentFinalCharacter, newChar);
      _replaceFinalCharacter(newSyllable.toString());
    } else {
      _concatCharacter(newChar);
    }
  }

  void _addToSyllable(String newChar, String currentFinalCharacter) {
    final currentSyllable = HangulSyllable.fromString(currentFinalCharacter);
    if (currentSyllable.jong != null) {
      _addToJong(newChar, currentSyllable);
    } else {
      _addToJung(newChar, currentSyllable);
    }
  }

  void _addToJong(String newChar, HangulSyllable currentSyllable) {
    if (_jongCombinations.containsKey(currentSyllable.jong! + newChar)) {
      currentSyllable.jong = _jongCombinations[currentSyllable.jong! + newChar];
      _replaceFinalCharacter(currentSyllable.toString());
    } else if (isValidJung(newChar)) {
      if (_jongCombinations.containsValue(currentSyllable.jong)) {
        final combination = _jongCombinations.keys
            .firstWhere((k) => _jongCombinations[k] == currentSyllable.jong);

        final newFinalSyllable = HangulSyllable(combination[1], newChar);
        currentSyllable.jong = combination[0];
        _replaceFinalCharacter(
            currentSyllable.toString() + newFinalSyllable.toString());
      } else if (isValidCho(currentSyllable.jong)) {
        final newFinalSyllable = HangulSyllable(currentSyllable.jong!, newChar);
        currentSyllable.jong = null;
        _replaceFinalCharacter(
            currentSyllable.toString() + newFinalSyllable.toString());
      } else {
        _concatCharacter(newChar);
      }
    } else {
      _concatCharacter(newChar);
    }
  }

  void _addToJung(String newChar, HangulSyllable currentSyllable) {
    if (_jungCombinations.containsKey(currentSyllable.jung + newChar)) {
      currentSyllable.jung = _jungCombinations[currentSyllable.jung + newChar]!;
      _replaceFinalCharacter(currentSyllable.toString());
    } else if (isValidJong(newChar)) {
      currentSyllable.jong = newChar;
      _replaceFinalCharacter(currentSyllable.toString());
    } else {
      _concatCharacter(newChar);
    }
  }

  void _replaceFinalCharacter(String newChar) {
    _text = _text.replaceRange(_text.length - 1, null, newChar);
  }

  void _concatCharacter(String newChar) {
    _text += newChar;
  }

  @override
  String toString() {
    return _text;
  }
}
