import 'package:digifarmer/db/preference_db.dart';
import 'package:flutter/material.dart';

class MyappProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ///Get-theme mode
  void loadThemeMode() async {
    _themeMode = await PreferencesDB.db.getAppThemeMode();
    notifyListeners();
  }

  ///Settings-theme mode
  set themeMode(ThemeMode themeMode) {
    PreferencesDB.db.setAppThemeMode(themeMode);
    _themeMode = themeMode;
    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;
}
