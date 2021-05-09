import 'package:hangul/hangul.dart';

void main(List<String> arguments) {
  const wordToTransform = "하다";

  // ensure all characters are valid syllables
  wordToTransform.runes.forEach((char) {
    assert(isHangulSyllableCode(char));
  });

  // convert each character to a HangulSyllable instance
  final List<HangulSyllable> syllables =
      wordToTransform.runes.map((e) => HangulSyllable.fromCharCode(e)).toList();

  // replace  the jung (vowel) of each word
  syllables.forEach((syllable) {
    syllable.jung = 'ㅜ';
  });

  print('Word transformed:');
  print(syllables.join(''));
}
