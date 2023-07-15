import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/app_logger.dart';

class LocalCache {
  static const userToken = 'userTokenId';
  static const user = "currentUser";

  static Object? getFromLocalCache(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    try {
      return sharedPreferences.get(key);
    } catch (e) {
      AppLogger.log(e);
    }
    return null;
  }

  static Future<void> removeFromLocalCache(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  static Future<void> saveToLocalCache(
      {required String key, required value}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    AppLogger.log('Data being saved: key: $key, value: $value');

    if (value is String) {
      await sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
    }
    if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    }
    if (value is Map) {
      await sharedPreferences.setString(key, json.encode(value));
    }
  }

  //
  // Future<void> cacheUserData({required String value}) async {
  //   await saveToLocalCache(key: user, value: value);
  // }

  //
  // Future<void> deleteUserData() async {
  //   await removeFromLocalCache(user);
  // }
}
