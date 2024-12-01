import 'package:flutter/material.dart';
import 'package:proyecto_final/components/custom_theme_buttons.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  Color? _selectedBgColor; // Color inicial del fondo
  Color? _selectedPrColor; // Color inicial primario
  String? _selectedFont; // Fuente de letra inicial
  void changeBgColor(Color color) => setState(() {
    _selectedBgColor = color;
  });
  void changePrColor(Color color) => setState(() {
    _selectedPrColor = color;
  });
  void resetColors() {
    setState(() {
      _selectedBgColor = null;
      _selectedPrColor = null;
      _selectedFont = null;
      // print('El bg color es: ' + _selectedBgColor.toString());
    });
  }
  void changeFont(String font) {
    setState(() {
      _selectedFont = font;
      print(_selectedFont);
    });
  }

  Widget build(BuildContext context) {
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[900]!, Colors.green[700]!],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false, // Esto asegura que ocupe todo el espacio restante
              child: Center(
                child: CustomThemeButtons(
                  onBgColorChange: changeBgColor,
                  onPrColorChange: changePrColor,
                  onFontChange: changeFont,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}