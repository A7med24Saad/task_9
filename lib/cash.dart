import 'package:shared_preferences/shared_preferences.dart';

class cash {
  static String Image = 'Image_key';
  static String NameKey = 'Name_key';
  static String isupload = 'is upload';
  static int numTasks = 0;
  static cashd(String key, String path) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, path);
  }

  static Future<String> get(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static cashbool(String key, bool path) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, path);
  }

  static Future<bool> getbool(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
  static cashnumoftasks(String key, int num) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, num);
  }

  static Future<Object> getnum(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? false;
  }
}
