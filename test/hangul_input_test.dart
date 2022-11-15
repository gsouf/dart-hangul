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
    test('HangulInput.pushCharacter shakedown', () {
      final input = HangulInput('');

      input.pushCharacter('ㅎ');
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
      input.pushCharacter('ㄴ');
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

      expect(input.text, equals('한녕하세요 닭은 왜 좋아요?'));
      expect(input.toString(), equals('한녕하세요 닭은 왜 좋아요?'));
    });
  });
}
