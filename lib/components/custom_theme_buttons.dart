import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/components/colors_slider.dart';
import 'package:proyecto_final/provider/provider_vars.dart';
import 'package:proyecto_final/settings/theme_settings.dart';
import 'package:quickalert/quickalert.dart';

class CustomThemeButtons extends StatefulWidget {
  CustomThemeButtons({
    super.key,
    this.currentFont,
    required this.onBgColorChange, 
    required this.onPrColorChange,
    required this.onFontChange,
    required this.resetColors,
    this.currentBgColor,
    this.currentPrColor,
  });

  String? currentFont;
  Function(Color) onBgColorChange;
  Function(Color) onPrColorChange;
  Function(String) onFontChange;
  Color? currentBgColor;
  Color? currentPrColor;
  VoidCallback resetColors;

  @override
  State<CustomThemeButtons> createState() => _CustomThemeButtonsState();
}

class _CustomThemeButtonsState extends State<CustomThemeButtons> {
  final List<String> fonts = ['Roboto', 'Lobster', 'Poppins', 'Pacifico', 'Oswald'];

  @override
  Widget build(BuildContext context) {
    ProviderVars providerVars = Provider.of<ProviderVars>(context);
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    List<Color> colorHistory = [];

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'TEMAS',
              style: GoogleFonts.getFont(
                widget.currentFont != null ? widget.currentFont! : 'Roboto',
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).canvasColor
              )
            ),
            SizedBox(height: 40,),
            Text(
              'GENÉRICOS',
              style: GoogleFonts.getFont(
                widget.currentFont != null ? widget.currentFont! : 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).canvasColor
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: currentWidth * .4,
                  child: TextButton(
                    onPressed: () {
                      // providerVars.flagDarkTheme = false;
                      // providerVars.flagCustomTheme = 0;
                      providerVars.currentTheme = ThemeSettings.lightTheme();
                      widget.resetColors();
                    },
                    child: Icon(Icons.light_mode),
                    style: TextButton.styleFrom(
                      backgroundColor:
                          widget.currentPrColor ?? Theme.of(context).primaryColor, // Color de fondo
                      foregroundColor: Theme.of(context).canvasColor, // Color del texto
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: currentWidth * .4,
                  child: TextButton(
                    onPressed: () {
                      // providerVars.flagDarkTheme = true;
                      // providerVars.flagCustomTheme = 0;
                      providerVars.currentTheme = ThemeSettings.darkTheme();
                      widget.resetColors();
                    },
                    child: Icon(Icons.dark_mode),
                    style: TextButton.styleFrom(
                      backgroundColor:
                          widget.currentPrColor ?? Theme.of(context).primaryColor, // Color de fondo
                      foregroundColor: Theme.of(context).canvasColor, // Color del texto
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Text(
              'PERSONALIZADO',
              style: GoogleFonts.getFont(
                widget.currentFont != null ? widget.currentFont! : 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).canvasColor
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ColorsSlider(
                      pickerColor: widget.currentBgColor ?? Theme.of(context).scaffoldBackgroundColor,
                      onColorChanged: widget.onBgColorChange,
                      buttonTxt: 'Fondo',
                      buttonWidth: MediaQuery.of(context).size.width * .35,
                      colorHistory: colorHistory,
                      onHistoryChanged: (List<Color> colors) => colorHistory = colors,
                      currentFont: widget.currentFont != null ? widget.currentFont! : 'Roboto',
                    ),
                    ColorsSlider(
                      pickerColor: widget.currentPrColor ?? Theme.of(context).primaryColor,
                      onColorChanged: widget.onPrColorChange,
                      buttonTxt: 'Primario',
                      buttonWidth: MediaQuery.of(context).size.width * .35,
                      colorHistory: colorHistory,
                      onHistoryChanged: (List<Color> colors) => colorHistory = colors,
                      currentFont: widget.currentFont != null ? widget.currentFont! : 'Roboto',
                    ),
                    SizedBox(height: 5),
                    dropDownBtn(),
                    SizedBox(height: 6,),
                    Container(
                      width: currentWidth * .3,
                      child: TextButton(
                        onPressed: () {
                          if(widget.currentBgColor != null || widget.currentPrColor != null || widget.currentFont != 'Roboto'){
                            // print('Fuente actual $widget.currentFont');
                            // providerVars.flagCustomTheme++;
                            // providerVars.flagDarkTheme = false;
                            providerVars.currentTheme = ThemeSettings.customTheme(
                              primaryColor: widget.currentPrColor ?? Theme.of(context).primaryColor,
                              scaffoldBackgroundColor: widget.currentBgColor ?? Theme.of(context).scaffoldBackgroundColor,
                              fontFamily: widget.currentFont ?? 'Roboto', // Ajusta según sea necesario
                              baseTheme: ThemeSettings.darkTheme()
                            );
                            // providerVars.customPrimaryColor = Theme.of(context).primaryColor;
                            // providerVars.customScaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
                            // providerVars.customFontFamily = widget.currentFont != null ? widget.currentFont! : 'Roboto';
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: '¡Tema guardado con éxito!',
                              autoCloseDuration: const Duration(seconds: 4),
                            );
                          } else { // Ambas son nulas
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.warning,
                              text: 'Elige al menos un color personalizado',
                              autoCloseDuration: const Duration(seconds: 4),
                              showConfirmBtn: true
                            );
                          }
                        },
                        child: Text(
                          'Aplicar',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(
                            widget.currentFont != null ? widget.currentFont! : 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: widget.currentPrColor ?? Theme.of(context).primaryColor, // Color de fondo
                          foregroundColor: Theme.of(context).canvasColor,//Theme.of(context).textTheme.bodyMedium!.color, // Color del texto
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),        
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDownBtn(){
    return Container(
      width: MediaQuery.of(context).size.width * .35,
      child: DecoratedBox(
        decoration: BoxDecoration( 
          color: widget.currentPrColor ?? Theme.of(context).primaryColor, //background color of dropdown button
          borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: DropdownButton<String>(
              value: widget.currentFont,
              underline: SizedBox(),
              dropdownColor: widget.currentPrColor ?? Theme.of(context).primaryColor,
              items: fonts.map((String font) {
                return DropdownMenuItem<String>(
                  value: font,
                  child: Text(
                    font,
                    style: GoogleFonts.getFont(
                      font,
                      color: Theme.of(context).canvasColor
                    ), // Aplicar fuente de muestra
                  ),
                );
              }).toList(),
              onChanged: (String? newFont) {
                widget.onFontChange(newFont!);
              },
            ),
        ),
        ),
    );
  }
}