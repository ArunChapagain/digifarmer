import 'package:digifarmer/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

///shared_preferences
class PreferencesDB {
  PreferencesDB._();
  static final PreferencesDB db = PreferencesDB._();
  SharedPreferences? _db;
  Future<SharedPreferences> get database async =>
      _db ??= await SharedPreferences.getInstance();

  static const appThemeDarkMode = 'appThemeMode';
  static const locationString = 'location';

  ///Settings-theme appearance mode
  Future<bool> setAppThemeMode(ThemeMode themeMode) async {
    final SharedPreferences prefs = await database;
    return prefs.setString(appThemeDarkMode, themeMode.name);
  }

  ///Get-theme appearance mode
  Future<ThemeMode> getAppThemeMode() async {
    final SharedPreferences prefs = await database;
    final String getThemeMode = prefs.getString(appThemeDarkMode) ?? 'system';
    return themeMode(getThemeMode);
  }

  //setting the locaiton
  Future<bool> setLocation(String location) async {
    final SharedPreferences prefs = await database;
    return prefs.setString(locationString, location);
  }

  //get
  Future<String> getLocation() async {
    final SharedPreferences prefs = await database;
    final String getLocation = prefs.getString(locationString) ?? 'pokhara';
    return getLocation;
  }
}
