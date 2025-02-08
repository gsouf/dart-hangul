import 'package:hangul/hangul.dart';

void main(List<String> arguments) {
  const wordToTransform = "하다";

  // ensure all characters are valid syllables
  wordToTransform.runes.forEach((char) {
    if (!isHangulSyllableCode(char)) {
      throw ArgumentError('Invalid Hangul syllable: $char');
    }
  });

  // convert each character to a HangulSyllable instance
  final List<HangulSyllable> syllables =
      wordToTransform.runes.map((e) => HangulSyllable.fromCharCode(e)).toList();

  // replace  the jung (vowel) of each word
  // 하다 will become 후두.
  syllables.forEach((syllable) {
    syllable.jung = 'ㅜ';
  });

  final newWord = syllables.join('');

  print('Word transformed:');
  print(newWord);

  // input hangul characters in the string
  final input = HangulInput(newWord);

  input.pushCharacter('ㄹ');
  input.pushCharacter('ㅡ');
  input.pushCharacter('ㄹ');

  print('String with added input:');
  print(input.text);

  input.backspace();
  input.backspace();
  input.pushCharacter('ㅏ');

  print('String with backspace and replaced input:');
  print(input.text);
}
