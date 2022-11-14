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
  'ㄷ': 'ㄸ',
  'ㅂ': 'ㅃ',
  'ㅅ': 'ㅆ',
  'ㅈ': 'ㅉ'
};

class HangulInput {
  String _text;
  bool hasBreak = true;
  HangulInput(this._text);

  String get text => _text;

  void pushCharacter(String char) {
    if (isValidJamo(char)) {
      final currentCharacter =
          _text.isEmpty ? '' : _text.substring(_text.length - 1);

      if (!hasBreak && isHangulSyllable(currentCharacter)) {
        final currentSyllable = HangulSyllable.fromString(currentCharacter);

        if (currentSyllable.jong != null) {
          if (_jongCombinations.containsKey(currentSyllable.jong! + char)) {
            currentSyllable.jong =
                _jongCombinations[currentSyllable.jong! + char];
            _text = _text.replaceRange(
                _text.length - 1, null, currentSyllable.toString());
            hasBreak = false;
          } else {
            _text += char;
            hasBreak = false;
          }
        } else {
          // TODO
        }
      } else {
        _text += char;
        hasBreak = !isValidCho(char);
      }
    } else {
      _text += char;
      hasBreak = true;
    }
  }
}
