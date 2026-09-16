import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _tokenKey = 'token';
  static const _expiryKey = 'token_expiry';
  static const _firstTimeKey = 'isFirstTime';
  static const _langKey = 'lang';

  static Future<void> saveToken(String token, DateTime expiry) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_expiryKey, expiry.toIso8601String());
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<DateTime?> getTokenExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryString = prefs.getString(_expiryKey);
    if (expiryString == null) return null;
    final parsed = DateTime.tryParse(expiryString);
    if (parsed == null) {
      await clearToken();
      return null;
    }
    return parsed;
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_expiryKey);
  }

  static Future<void> setFirstTime(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstTimeKey, value);
  }

  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstTimeKey) ?? true;
  }

  static Future<void> setLang(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, langCode);
  }

  static Future<String?> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_langKey);
  }

  static Future<void> clearLang() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_langKey);
  }
}
