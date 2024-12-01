import 'package:flutter/material.dart';

class ProviderVars extends ChangeNotifier{
  // Variables
  String _name = 'Miguel Ruiz';
  bool _flagDarkTheme = false;
  int _flagCustomTheme = 0;
  Color? _customPrimaryColor = null;
  Color? _customScaffoldBackgroundColor = null;
  String? _customFontFamily = null;
  ThemeData _currentTheme;

  ProviderVars(this._currentTheme);

  // Getters
  String get name => _name;
  bool get flagDarkTheme => _flagDarkTheme;
  int get flagCustomTheme => _flagCustomTheme;
  Color? get customPrimaryColor => _customPrimaryColor;
  Color? get customScaffoldBackgroundColor => _customScaffoldBackgroundColor;
  String? get customFontFamily => _customFontFamily;
  ThemeData get currentTheme => _currentTheme;

  // Setters
  set name(String value){
    _name = value;
    notifyListeners();
  }

  set flagDarkTheme(bool value){
    _flagDarkTheme = value;
    notifyListeners();
  }

  set flagCustomTheme(int value){
    _flagCustomTheme = value;
    notifyListeners();
  }

  set customPrimaryColor(Color? value){
    _customPrimaryColor = value;
    notifyListeners();
  }

  set customScaffoldBackgroundColor(Color? value){
    _customScaffoldBackgroundColor = value;
    notifyListeners();
  }

  set customFontFamily(String? value){
    _customFontFamily = value;
    notifyListeners();
  }

  // NOSÉ
  set currentTheme(ThemeData value){
    _currentTheme = value;
    notifyListeners();
  }
}