import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  String? currentTheme;

  void changeTheme(String theme) {
    currentTheme = theme;
    notifyListeners();
  }

  void resetTheme() {
    currentTheme = null;
    notifyListeners();
  }
}
