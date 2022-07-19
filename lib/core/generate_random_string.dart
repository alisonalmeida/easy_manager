import 'dart:math';

const _validChars =
    'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
String generateRandomString() {
  Random r = Random();

  return String.fromCharCodes(Iterable.generate(_validChars.length,
      (_) => _validChars.codeUnitAt(r.nextInt(_validChars.length))));
}
