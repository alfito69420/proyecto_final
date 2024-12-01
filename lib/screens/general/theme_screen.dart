import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/components/custom_theme_buttons.dart';
import 'package:proyecto_final/provider/provider_vars.dart';
import 'package:proyecto_final/settings/theme_settings.dart'; // Asegúrate de que la ruta sea correcta

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  Color? _selectedBgColor; // Color inicial del fondo
  Color? _selectedPrColor; // Color inicial primario
  void changeBgColor(Color color) => setState(() { /*currentColor = color*/ 
    _selectedBgColor = color;
  });
  void changePrColor(Color color) => setState(() { /*currentColor = color*/ 
    _selectedPrColor = color;
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderVars>(
      builder: (context, providerVars, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Tema',
              style: TextStyle(
                color: Theme.of(context).canvasColor,
              ),
            ),
            backgroundColor: Colors.green[700],
          ),
          body: Container(
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [_selectedBgColor ?? Theme.of(context).scaffoldBackgroundColor, ThemeSettings.generateSimilarColorHSL(_selectedBgColor ?? Theme.of(context).scaffoldBackgroundColor) /*Colors.green[700]!*/],
            //   ),
            // ),
            decoration: BoxDecoration(
              color: _selectedBgColor ?? Theme.of(context).scaffoldBackgroundColor
            ),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CustomThemeButtons(
                      onBgColorChange: (Color color) => setState(() {
                        _selectedBgColor = color;
                      }),
                      onPrColorChange: (Color color) => setState(() {
                        _selectedPrColor = color;
                      }),
                      onFontChange: (String font) {
                        providerVars.customFontFamily = font;
                      },
                      currentFont: providerVars.customFontFamily ?? 'Roboto', // Theme.of(context).textTheme.titleLarge!.fontFamily!.replaceAll('_regular', ''),
                      currentBgColor: _selectedBgColor ?? Theme.of(context).scaffoldBackgroundColor,//providerVars.customScaffoldBackgroundColor,
                      currentPrColor: _selectedPrColor ?? Theme.of(context).primaryColor,
                      resetColors: () {
                        _selectedBgColor = null;
                        _selectedPrColor = null;
                        providerVars.customScaffoldBackgroundColor = null;
                        providerVars.customPrimaryColor = null;
                        providerVars.customFontFamily = null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}