import 'package:test/test.dart';
import 'package:hangul/hangul.dart';

void main() {
  group('Jamo', () {
    test('isValidCho', () {
      expect(isValidCho('ㄱ'), equals(true));
      expect(isValidCho('ㄱㄱ'), equals(false));
      expect(isValidCho('가'), equals(false));
      expect(isValidCho('ㅀ'), equals(false));
      expect(isValidCho('ㅏ'), equals(false));
      expect(isValidCho('a'), equals(false));
      expect(isValidCho(null), equals(false));
    });
    test('isValidChoCode', () {
      expect(isValidChoCode('ㄱ'.codeUnitAt(0)), equals(true));
      expect(isValidChoCode('가'.codeUnitAt(0)), equals(false));
      expect(isValidChoCode('ㅀ'.codeUnitAt(0)), equals(false));
      expect(isValidChoCode('ㅏ'.codeUnitAt(0)), equals(false));
      expect(isValidChoCode('a'.codeUnitAt(0)), equals(false));
    });
    test('isValidJung', () {
      expect(isValidJung('ㄱ'), equals(false));
      expect(isValidJung('ㄱㄱ'), equals(false));
      expect(isValidJung('가'), equals(false));
      expect(isValidJung('ㅀ'), equals(false));
      expect(isValidJung('ㅏ'), equals(true));
      expect(isValidJung('a'), equals(false));
      expect(isValidJung(null), equals(false));
    });
    test('isValidJamo', () {
      expect(isValidJamo('ㄱ'), equals(true));
      expect(isValidJamo('ㄱㄱ'), equals(false));
      expect(isValidJamo('가'), equals(false));
      expect(isValidJamo('ㅀ'), equals(true));
      expect(isValidJamo('ㅏ'), equals(true));
      expect(isValidJamo('a'), equals(false));
      expect(isValidJamo(null), equals(true));
    });
    test('isValidJungCode', () {
      expect(isValidJungCode('ㄱ'.codeUnitAt(0)), equals(false));
      expect(isValidJungCode('가'.codeUnitAt(0)), equals(false));
      expect(isValidJungCode('ㅀ'.codeUnitAt(0)), equals(false));
      expect(isValidJungCode('ㅏ'.codeUnitAt(0)), equals(true));
      expect(isValidJungCode('a'.codeUnitAt(0)), equals(false));
    });
    test('isValidJong', () {
      expect(isValidJong('ㄱ'), equals(true));
      expect(isValidJong('ㄱㄱ'), equals(false));
      expect(isValidJong('가'), equals(false));
      expect(isValidJong('ㅀ'), equals(true));
      expect(isValidJong('ㅏ'), equals(false));
      expect(isValidJong('a'), equals(false));
      expect(isValidJong(null), equals(true));
    });
    test('isValidJongCode', () {
      expect(isValidJongCode('ㄱ'.codeUnitAt(0)), equals(true));
      expect(isValidJongCode('가'.codeUnitAt(0)), equals(false));
      expect(isValidJongCode('ㅀ'.codeUnitAt(0)), equals(true));
      expect(isValidJongCode('ㅏ'.codeUnitAt(0)), equals(false));
      expect(isValidJongCode('a'.codeUnitAt(0)), equals(false));
    });
    test('isValidJamo', () {
      expect(isValidJamoCode('ㄱ'.codeUnitAt(0)), equals(true));
      expect(isValidJamoCode('가'.codeUnitAt(0)), equals(false));
      expect(isValidJamoCode('ㅀ'.codeUnitAt(0)), equals(true));
      expect(isValidJamoCode('ㅏ'.codeUnitAt(0)), equals(true));
      expect(isValidJamoCode('a'.codeUnitAt(0)), equals(false));
    });
  });
  group('isHangulSyllableCode()', () {
    test('is true', () {
      const chars = ['가', '각', '걖', '괓', '쪲', '힢', '힣'];

      chars.forEach((element) {
        final res = isHangulSyllableCode(element.codeUnitAt(0));
        expect(res, equals(true));
      });
    });
    test('is false', () {
      const chars = [
        'ㄱ',
        'ㅎ',
        'ㅞ',
        'ㄿ',
        'a',
        '[',
        '.',
        '2',
        '漢',
        'ф',
        ' ',
        '😃'
      ];

      chars.forEach((element) {
        final res = isHangulSyllableCode(element.codeUnitAt(0));
        expect(res, equals(false));
      });
    });
  });
  group('isHangulSyllable()', () {
    test('is true', () {
      const chars = ['가', '각', '걖', '괓', '쪲', '힢', '힣'];

      chars.forEach((element) {
        final res = isHangulSyllable(element);
        expect(res, equals(true));
      });
    });
    test('is false', () {
      const chars = [
        'ㄱ',
        'ㅎ',
        'ㅞ',
        'ㄿ',
        'a',
        '[',
        '.',
        '2',
        '漢',
        'ф',
        ' ',
        '😃'
      ];

      chars.forEach((element) {
        final res = isHangulSyllable(element);
        expect(res, equals(false));
      });
    });
  });
  group('HangulSyllable', () {
    test('fromString 2 jamo', () {
      final syllable = HangulSyllable.fromString('가');
      expect(syllable.cho, equals('ㄱ'));
      expect(syllable.jung, equals('ㅏ'));
      expect(syllable.jong, equals(null));
    });
    test('fromString 3 jamo', () {
      final syllable = HangulSyllable.fromString('쪲');
      expect(syllable.cho, equals('ㅉ'));
      expect(syllable.jung, equals('ㅖ'));
      expect(syllable.jong, equals('ㅄ'));
    });
    test('fromCharCode', () {
      final syllable = HangulSyllable.fromCharCode('쪲'.codeUnitAt(0));
      expect(syllable.cho, equals('ㅉ'));
      expect(syllable.jung, equals('ㅖ'));
      expect(syllable.jong, equals('ㅄ'));
    });
    test('fromJamos', () {
      final syllable = HangulSyllable('ㅆ', 'ㅜ', 'ㄼ');
      expect(syllable.cho, equals('ㅆ'));
      expect(syllable.jung, equals('ㅜ'));
      expect(syllable.jong, equals('ㄼ'));
    });
    test('throws on invalid', () {
      expect(
          () => HangulSyllable.fromString('쪲쪲'),
          throwsA(predicate((e) =>
              e is AssertionError &&
              e.message ==
                  'Syllable should be exactly 1 character long string.')));
      expect(
          () => HangulSyllable.fromString('a'),
          throwsA(predicate((e) =>
              e is AssertionError &&
              e.message ==
                  'Trying to disassemble a character that is not a hangul syllable.')));
      expect(
          () => HangulSyllable('쪲', 'ㅜ'),
          throwsA(predicate((e) =>
              e is AssertionError &&
              e.message == 'Invalid character provided for cho.')));
      expect(
          () => HangulSyllable('ㅆ', 'a'),
          throwsA(predicate((e) =>
              e is AssertionError &&
              e.message == 'Invalid character provided for jung.')));
      expect(
          () => HangulSyllable('ㅆ', 'ㅜ', 'ㅜ'),
          throwsA(predicate((e) =>
              e is AssertionError &&
              e.message == 'Invalid character provided for jong.')));
    });
    test('toString', () {
      expect(HangulSyllable('ㄱ', 'ㅏ').toString(), equals('가'));
      expect(HangulSyllable('ㅎ', 'ㅣ').toString(), equals('히'));
      expect(HangulSyllable('ㅎ', 'ㅞ').toString(), equals('훼'));
      expect(HangulSyllable('ㄱ', 'ㅏ', 'ㄱ').toString(), equals('각'));
      expect(HangulSyllable('ㅎ', 'ㅣ', 'ㅎ').toString(), equals('힣'));
      expect(HangulSyllable('ㅆ', 'ㅞ', 'ㄼ').toString(), equals('쒧'));
    });
  });
}
