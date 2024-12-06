import 'dart:math';

import 'package:flutter/material.dart';

class ThemeSettings {
  static ThemeData lightTheme(){
    final theme = ThemeData.light();
    return theme.copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 246, 213),
      primaryColor: const Color.fromARGB(255, 230, 203, 109)
    );
  }

  static ThemeData darkTheme(){
    final theme = ThemeData.dark();
    return theme.copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 105, 87, 87),
      primaryColor: Colors.black,
    );
  }

  // static ThemeData customTheme({
  //   required Color primaryColor,
  //   required Color scaffoldBackgroundColor,
  //   required String fontFamily,
  //   required ThemeData baseTheme,
  // }) {
  //   return baseTheme.copyWith(
  //     primaryColor: primaryColor,
  //     scaffoldBackgroundColor: scaffoldBackgroundColor,
  //     appBarTheme: AppBarTheme(color: scaffoldBackgroundColor),
  //     /*textTheme: baseTheme.textTheme.apply(
  //       fontFamily: GoogleFonts.getFont(fontFamily).fontFamily,
  //     ),*/
  //   );
  // }
  static ThemeData customTheme({
    required Color primaryColor,
    required Color scaffoldBackgroundColor,
    required String fontFamily, // Recibe el nombre de la fuente.
    required ThemeData baseTheme,
  }) {
    return baseTheme.copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(color: scaffoldBackgroundColor),
      textTheme: baseTheme.textTheme.copyWith(
        bodyLarge: baseTheme.textTheme.bodyLarge?.copyWith(fontFamily: fontFamily),
        bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(fontFamily: fontFamily),
        bodySmall: baseTheme.textTheme.bodySmall?.copyWith(fontFamily: fontFamily),
        titleLarge: baseTheme.textTheme.titleLarge?.copyWith(fontFamily: fontFamily),
        titleMedium: baseTheme.textTheme.titleMedium?.copyWith(fontFamily: fontFamily),
        titleSmall: baseTheme.textTheme.titleSmall?.copyWith(fontFamily: fontFamily),
        labelLarge: baseTheme.textTheme.labelLarge?.copyWith(fontFamily: fontFamily),
        labelMedium: baseTheme.textTheme.labelMedium?.copyWith(fontFamily: fontFamily),
        labelSmall: baseTheme.textTheme.labelSmall?.copyWith(fontFamily: fontFamily),
        headlineLarge: baseTheme.textTheme.headlineLarge?.copyWith(fontFamily: fontFamily),
        headlineMedium: baseTheme.textTheme.headlineMedium?.copyWith(fontFamily: fontFamily),
        headlineSmall: baseTheme.textTheme.headlineSmall?.copyWith(fontFamily: fontFamily),
      ),
    );
  }

  // Genera colores similares a uno. Se usa para donde haya degradados.
  static Color generateSimilarColorHSL(Color baseColor) {
  // Convertir el color base a HSL
  final hslColor = HSLColor.fromColor(baseColor);

  // Rango de variación más amplio
  final random = Random();
  final newHue = (hslColor.hue + random.nextDouble() * 120 - 60) % 360; // Variar ±60 grados
  final newSaturation = (hslColor.saturation + random.nextDouble() * 0.6 - 0.3).clamp(0.0, 1.0); // Variar ±0.3
  final newLightness = (hslColor.lightness + random.nextDouble() * 0.6 - 0.3).clamp(0.0, 1.0); // Variar ±0.3

  return HSLColor.fromAHSL(
    hslColor.alpha,
    newHue,
    newSaturation,
    newLightness,
  ).toColor();
}



}