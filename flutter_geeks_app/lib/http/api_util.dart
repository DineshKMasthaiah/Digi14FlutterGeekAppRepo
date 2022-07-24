import 'dart:math';
///A utility class to generate random number that is used as http request Identifier while making API call.
///Request Identifiers help us in searching the request logs if we use any logging service in the backend.
class GEApiUtility {
  static late Random _random;
  static GEApiUtility utility = GEApiUtility._internal();

  factory GEApiUtility() {
    _random = Random();
    return utility;
  }

  GEApiUtility._internal();

  String getRandomString({int length = 20}) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return String.fromCharCodes(Iterable.generate(length, (_) {
      var n = _random.nextInt(chars.length);
      return chars.codeUnitAt(n);
    }));
  }
}
