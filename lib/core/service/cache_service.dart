import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheService {
  Future<bool> saveUserData(String userData);
  Future<String?> getUserData();

  Future<bool?> clearUserData();

  Future<String?> getLanguageCode();
  Future<void> setLanguageCode(String languageCode);

  Future<bool> getIsFirstLaunch();
  Future<void> setIsFirstLaunch(bool isFirstLaunch);
}

class CacheServiceImpl implements CacheService {
  static const _USERDATA = "USER_DATA";
  static const _LOCALE = 'locale';
  static const _HAS_RUN_BEFORE = "HAS_RUN_BEFORE";
  static const _IS_FIRST_LAUNCH = "IS_FIRST_LAUNCH";

  final _completer = Completer<FlutterSecureStorage>();

  CacheServiceImpl() {
    SharedPreferences.getInstance().then((prefs) async {
      if (prefs.getBool(_HAS_RUN_BEFORE) != true) {
        const storage = FlutterSecureStorage();
        await storage.deleteAll();
        await prefs.setBool(_HAS_RUN_BEFORE, true);
        _completer.complete(storage);
      } else
        _completer.complete(const FlutterSecureStorage());
    });
  }

  @override
  Future<bool> saveUserData(String userData) async {
    final storage = await _completer.future;
    await storage.write(key: _USERDATA, value: userData);
    return true;
  }

  @override
  Future<String?> getUserData() async {
    final storage = await _completer.future;

    return await storage.read(key: _USERDATA);
  }

  @override
  Future<String?> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LOCALE);
  }

  @override
  Future<void> setLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_LOCALE, languageCode);
  }

  @override
  Future<bool> getIsFirstLaunch() async {
    final storage = await _completer.future;

    final isFirstLaunch = await storage.read(key: _IS_FIRST_LAUNCH);
    return isFirstLaunch == null ? true : false;
  }

  @override
  Future<void> setIsFirstLaunch(bool isFirstLaunch) async {
    final storage = await _completer.future;

    await storage.write(key: _IS_FIRST_LAUNCH, value: isFirstLaunch.toString());
  }

  @override
  Future<bool?> clearUserData() async {
    final storage = await _completer.future;

    await storage.delete(key: _USERDATA);
    return true;
  }
}
