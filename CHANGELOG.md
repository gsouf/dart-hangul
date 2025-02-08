## [0.7.0] - 2025-02-08.

* BREAKING CHANGE - replaced assert with throwing ArgumentError in:
  * `syllableHasJong`
  * `syllableCodeHasJong`
  * `HangulSyllable.fromString`
  * `HangulSyllable.fromCharCode`
  * `HangulSyllable.cho` setter
  * `HangulSyllable.jung` setter
  * `HangulSyllable.jong` setter

## [0.6.0] - 2023-12-08.

* added syllableHasJong and syllableCodeHasJong

## [0.5.0] - 2023-03-03.

* BREAKING CHANGE - Fix: inputting 아,ㄲ,ㅏ was producing "악가"  instead of "아까"
* Dart version <4.0 instead of <3.0

## [0.4.0] - 2023-03-03.

* added method HangulInput.clear

## [0.3.0] - 2022-26-11.

* added method HangulInput.backspace

## [0.2.0] - 2022-23-11.

* added function isValidJamo
* added function isValidJamoCode
* added class HangulInput for creating hangul syllables from individual characters

## [0.1.1] - 2021-05-09.

* added example
* improved doc
* added tests
* standardized error messages

## [0.1.0] - 2021-05-09.

* initial release with basic