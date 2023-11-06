import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  static final StorageServices instance = StorageServices();
  late final SharedPreferences _preferences;

  Future<void> initPrefs() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveUserToken(String token) async {
    return await _preferences.setString("token", token);
  }
  Future<bool> removeUserToken() async {
    return await _preferences.remove("token");
  }
  String? getUserToken(){
    return _preferences.getString('token');
  }
}
