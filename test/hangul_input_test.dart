import 'package:hangul/src/input.dart';
import 'package:test/test.dart';

void main() {
  group('HangulInput.pushCharacter', () {
    test('HangulInput.pushCharacter new character is not hangul', () {
      final input = HangulInput('');

      input.pushCharacter('ㅈ');
      input.pushCharacter('a');
      expect(input.text, equals('ㅈa'));
    });

    test('HangulInput.pushCharacter last character is not hangul', () {
      final input = HangulInput('');

      input.pushCharacter(' ');
      input.pushCharacter('ㅈ');
      expect(input.text, equals(' ㅈ'));
    });

    test('HangulInput.pushCharacter combine cho', () {
      final input = HangulInput('');

      input.pushCharacter('ㅈ');
      input.pushCharacter('ㅈ');
      expect(input.text, equals('ㅉ'));
    });

    test('HangulInput.pushCharacter add jung to cho', () {
      final input = HangulInput('');

      input.pushCharacter('ㅈ');
      input.pushCharacter('ㅏ');
      expect(input.text, equals('자'));
    });

    test('HangulInput.pushCharacter uncombinable cho', () {
      final input = HangulInput('');

      input.pushCharacter('ㅈ');
      input.pushCharacter('ㅂ');
      expect(input.text, equals('ㅈㅂ'));
    });

    test('HangulInput.pushCharacter combine jong', () {
      final input = HangulInput('한');

      input.pushCharacter('ㅈ');
      expect(input.text, equals('핝'));
    });

    test('HangulInput.pushCharacter uncombinable jong', () {
      final input = HangulInput('한');

      input.pushCharacter('ㄴ');
      expect(input.text, equals('한ㄴ'));
    });

    test('HangulInput.pushCharacter move jong to cho', () {
      final input = HangulInput('한');

      input.pushCharacter('ㅏ');
      expect(input.text, equals('하나'));
    });

    test('HangulInput.pushCharacter uncombine jong and move with cho', () {
      final input = HangulInput('잙');

      input.pushCharacter('ㅏ');
      expect(input.text, equals('잘가'));
    });

    test('HangulInput.pushCharacter combine jung', () {
      final input = HangulInput('오');

      input.pushCharacter('ㅐ');
      expect(input.text, equals('왜'));
    });

    test('HangulInput.pushCharacter uncombinable jung', () {
      final input = HangulInput('오');

      input.pushCharacter('ㅜ');
      expect(input.text, equals('오ㅜ'));
    });

    test('HangulInput.pushCharacter add jong to jung', () {
      final input = HangulInput('오');

      input.pushCharacter('ㄹ');
      expect(input.text, equals('올'));
    });

    test('HangulInput.pushCharacter add jong to jung', () {
      final input = HangulInput('오');

      input.pushCharacter('ㄹ');
      expect(input.text, equals('올'));
    });

    test('HangulInput.pushCharacter handles ㄲ and ㅆ properly', () {
      final input = HangulInput('아');
      input.pushCharacter('ㄱ');
      input.pushCharacter('ㄱ');
      input.pushCharacter('ㅏ');
      expect(input.text, equals('악가'));

      final input2 = HangulInput('아');
      input2.pushCharacter('ㄲ');
      input2.pushCharacter('ㅏ');
      expect(input2.text, equals('아까'));

      final input3 = HangulInput('아');
      input3.pushCharacter('ㅅ');
      input3.pushCharacter('ㅅ');
      input3.pushCharacter('ㅏ');
      expect(input3.text, equals('앗사'));

      final input4 = HangulInput('아');
      input4.pushCharacter('ㅆ');
      input4.pushCharacter('ㅏ');
      expect(input4.text, equals('아싸'));
    });

    test('HangulInput.pushCharacter shakedown', () {
      final input = HangulInput('');

      input.pushCharacter('ㅇ');
      input.pushCharacter('ㅏ');
      input.pushCharacter('ㄴ');
      input.pushCharacter('ㄴ');
      input.pushCharacter('ㅕ');
      input.pushCharacter('ㅇ');
      input.pushCharacter('ㅎ');
      input.pushCharacter('ㅏ');
      input.pushCharacter('ㅅ');
      input.pushCharacter('ㅔ');
      input.pushCharacter('ㅇ');
      input.pushCharacter('ㅛ');
      input.pushCharacter(' ');
      input.pushCharacter('ㄷ');
      input.pushCharacter('ㅏ');
      input.pushCharacter('ㄹ');
      input.pushCharacter('ㄱ');
      input.pushCharacter('ㅇ');
      input.pushCharacter('ㅡ');
      input.pushCharacter('ㄹ');
      input.pushCharacter(' ');
      input.pushCharacter('ㅇ');
      input.pushCharacter('ㅗ');
      input.pushCharacter('ㅐ');
      input.pushCharacter(' ');
      input.pushCharacter('ㅈ');
      input.pushCharacter('ㅗ');
      input.pushCharacter('ㅎ');
      input.pushCharacter('ㅇ');
      input.pushCharacter('ㅏ');
      input.pushCharacter('ㅇ');
      input.pushCharacter('ㅛ');
      input.pushCharacter('?');

      expect(input.text, equals('안녕하세요 닭을 왜 좋아요?'));
      expect(input.toString(), equals('안녕하세요 닭을 왜 좋아요?'));
    });
  });

  group('HangulInput.backspace', () {
    test('HangulInput.backspace empty', () {
      final input = HangulInput('');
      input.backspace();
      expect(input.text, equals(''));
    });

    test('HangulInput.backspace latin', () {
      final input = HangulInput('aa');
      input.backspace();
      expect(input.text, equals('a'));
      input.backspace();
      expect(input.text, equals(''));
    });

    test('HangulInput.backspace jamo', () {
      final input = HangulInput('ㅇㅏ');
      input.backspace();
      expect(input.text, equals('ㅇ'));
      input.backspace();
      expect(input.text, equals(''));
    });

    test('HangulInput.backspace syllables', () {
      final input = HangulInput('닭은?');
      input.backspace();
      expect(input.text, equals('닭은'));
      input.backspace();
      expect(input.text, equals('닭으'));
      input.backspace();
      expect(input.text, equals('닭ㅇ'));
      input.backspace();
      expect(input.text, equals('닭'));
      input.backspace();
      expect(input.text, equals('달'));
      input.backspace();
      input.backspace();
      expect(input.text, equals('ㄷ'));
      input.backspace();
      expect(input.text, equals(''));
    });
  });

  test('HangulInput.clear', () {
    final input = HangulInput('');
    input.clear();
    expect(input.text, equals(''));
    expect(input.hasBreak, false);
    input.pushCharacter('ㅇ');
    input.pushCharacter('ㅛ');

    expect(input.text, equals('요'));
    input.clear();
    expect(input.text, equals(''));
    expect(input.hasBreak, false);
  });
}
