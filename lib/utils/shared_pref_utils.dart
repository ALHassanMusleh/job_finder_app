import 'dart:convert';

import 'package:job_finder_app/data/model/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  Future<AppUser?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userAsString = prefs.getString("current_user");
    if (userAsString == null) return null;
    return AppUser.fromJson(jsonDecode(userAsString));
  }

  saveUser(AppUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("current_user", jsonEncode(user.toJson()));
  }

  static Future<bool> removeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove("current_user");
  }
}
