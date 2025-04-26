import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences sharedPreferences;

  SharedPreferencesHelper(this.sharedPreferences);

  Future<void> saveToken(String token, String role) async {
    await sharedPreferences.setString('auth_token', token);
    await sharedPreferences.setString('auth_role', role);
  }

  Future<Map<String, dynamic>?> getToken() async {
          return {
       'token' : sharedPreferences.getString('auth_token'),
       'role' : sharedPreferences.getString('auth_role'),
     };
  }

  Future<void> clearToken() async {
    await sharedPreferences.remove('auth_token');
    await sharedPreferences.remove('auth_role');
  }



}
