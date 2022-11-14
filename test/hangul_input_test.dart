import 'package:hangul/src/input.dart';
import 'package:test/test.dart';

void main() {
  group('HangulInput', () {
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
    test('HangulInput.pushCharacter combine jong', () {
      final input = HangulInput('한');
      input.hasBreak = false;

      input.pushCharacter('ㅈ');
      expect(input.text, equals('핝'));
    });
    test('HangulInput.pushCharacter uncombinable jong', () {
      final input = HangulInput('한');
      input.hasBreak = false;

      input.pushCharacter('ㄴ');
      expect(input.text, equals('한ㄴ'));
    });
  });
}
