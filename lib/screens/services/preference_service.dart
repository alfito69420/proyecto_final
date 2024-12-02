import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_final/provider/provider_vars.dart';
import 'package:proyecto_final/settings/theme_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {

  Future<void> saveTheme(ThemeData theme, String font, bool isDark, bool isCustom) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convertir propiedades clave del tema a un Map
    final themeDataMap = {
      'primaryColor': theme.primaryColor.value,
      'backgroundColor': theme.scaffoldBackgroundColor.value,
      'fontFamily': font, // Por defecto Roboto
      'isDark': isDark,
      'isCustom': isCustom,
    };
    // Guardar como JSON
    await prefs.setString('currentTheme', jsonEncode(themeDataMap));
    print("Tema guardado: $themeDataMap");
  }

  Future<ThemeData> loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Leer el JSON guardado
    final themeString = prefs.getString('currentTheme');
    print("Tema cargado variables: $themeString");
    if (themeString == null) {
      // Retorna un tema predeterminado si no hay datos guardados
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green[900]!),
        useMaterial3: true,
      );
    }
    // Convertir el JSON a un Map
    final Map<String, dynamic> themeDataMap = jsonDecode(themeString);
    // Reconstruir el ThemeData
    ThemeData theme;
    if(themeDataMap['isDark']){
      theme = ThemeSettings.darkTheme();
    } else if(themeDataMap['isCustom']) {
      theme = ThemeSettings.customTheme(
        primaryColor: Color(themeDataMap['primaryColor']),
        scaffoldBackgroundColor: Color(themeDataMap['backgroundColor']),
        fontFamily: themeDataMap['fontFamily'],
        baseTheme: ThemeSettings.darkTheme()
      );
    } else {
      theme = ThemeSettings.lightTheme();
    }
    print("Tema cargado: $theme");
    return theme;
  }

}