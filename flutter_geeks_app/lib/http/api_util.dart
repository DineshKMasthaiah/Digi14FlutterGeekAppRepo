import 'dart:math';

class GEApiUtility {
  static late Random _random;
  static GEApiUtility utility = GEApiUtility._internal();

  factory GEApiUtility() {
    _random = Random();
    return utility;
  }

  GEApiUtility._internal();

  String getRandomString({int length = 20}) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return String.fromCharCodes(Iterable.generate(length, (_) {
      var n = _random.nextInt(_chars.length);
      return _chars.codeUnitAt(n);
    }));
  }
}
