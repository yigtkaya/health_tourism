import 'package:flutter/material.dart';

import 'app_theme.dart';

class ThemeManager {
  static ThemeManager? _instance;

  static ThemeManager? get instance {
    _instance ??= ThemeManager._init();
    return _instance;
  }

  ThemeManager._init() {
    _currentTheme = LightAppTheme();
  }

  IAppTheme? _currentTheme;

  void changeTheme() {
 /// TO DO change theme

  }

  ThemeMode getInitialThemeMode() {
    _currentTheme = DarkAppTheme();
    return ThemeMode.dark;
  }

  IAppTheme get getCurrentTheme => _currentTheme ?? LightAppTheme();

  static getColor() {}
}
