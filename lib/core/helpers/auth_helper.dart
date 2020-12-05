import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static const String _kAuth = "authentication";
  static const String _kPhotoUrl = "profilePhoto";

  static Future<String> getUserPhoto() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kPhotoUrl);
  }

  static Future<bool> setUserPhoto(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kPhotoUrl, value);
  }

  static Future<bool> removeUserPhoto() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove(_kPhotoUrl);
  }

  static Future<bool> getAuthState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_kAuth) ?? false;
  }

  // ignore: avoid_positional_boolean_parameters
  static Future<bool> setAuthState(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kAuth, value);
  }

  static Future<bool> removeAuthState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove(_kAuth);
  }
}
