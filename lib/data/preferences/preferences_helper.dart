import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  static const darkTheme = 'DARK_THEME';
  static const dailyRestaurant = 'DAILY_RESTAURANT';

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }

  Future<bool> get isDailyNewsActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRestaurant) ?? false;
  }

  void setDailyRestaurant(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRestaurant, value);
  }
}
