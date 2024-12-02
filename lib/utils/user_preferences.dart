import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? preferences;
  static const _keyIsLoggedIn = 'IsLoggedIn';
  static const _keyUserEmail = 'UserEmail';
  static const _keyUserPassword = 'UserPassword';
  static Future init() async =>
      preferences = await SharedPreferences.getInstance();
  static Future setIsLoggedIn(bool IsLoggedIn) async =>
      preferences!.setBool(_keyIsLoggedIn, IsLoggedIn);
  static bool? getIsLoggedIn() => preferences!.getBool(_keyIsLoggedIn);
  static Future setUserEmail(String userEmail) async =>
      preferences!.setString(_keyUserEmail, userEmail);
  static String? getUserEmail() => preferences!.getString(_keyUserEmail);
  static Future setUserPassword(String UserPassword) async =>
      preferences!.setString(_keyUserPassword, UserPassword);
  static String? getUserPassword() => preferences!.getString(_keyUserPassword);
}
