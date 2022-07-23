import 'package:shared_preferences/shared_preferences.dart';

class GESharedPrefsManager {
  static final GESharedPrefsManager _sharedPrefs =
      GESharedPrefsManager._internal();
  final Future<SharedPreferences> _prefsFuture =
      SharedPreferences.getInstance();
  static const String favoriteEventIdsKey = "favoriteEventIdsKey";

  factory GESharedPrefsManager() {
    return _sharedPrefs;
  }
  GESharedPrefsManager._internal();

  Future<bool> saveFavoriteEvent(int id) async {
    List<String> list = await getFavoriteEventList() ?? [];
    if (!list.contains('$id')) {
      list.add('$id');
    }
    var prefs = await _prefsFuture;
    return prefs.setStringList(favoriteEventIdsKey, list);
  }

  Future<bool> removeFavoriteEvent(int id) async {
    List<String>? list = await getFavoriteEventList();
    list?.removeWhere((element) => element == '$id');
    var prefs = await _prefsFuture;
    return prefs.setStringList(favoriteEventIdsKey, list ?? []);
  }

  Future<List<String>?> getFavoriteEventList() async {
    var prefs = await _prefsFuture;
    return prefs.getStringList(favoriteEventIdsKey);
  }
}
