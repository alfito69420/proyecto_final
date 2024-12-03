import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/models/jaguar.dart';
import 'package:proyecto_final/screens/jaguars/adopted_jaguars_screen.dart';
import 'package:proyecto_final/screens/pagos/plan_selection_screen.dart';
import 'package:proyecto_final/settings/theme_settings.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final String planTitle;
  final double planPrice;
  final Jaguar jaguar;
  final int planId;

  const PaymentConfirmationScreen({
    Key? key,
    required this.planTitle,
    required this.planPrice,
    required this.jaguar,
    required this.planId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmación de Pago'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).scaffoldBackgroundColor, ThemeSettings.generateSimilarColorHSL(Theme.of(context).scaffoldBackgroundColor)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 100,
                  ),
                  SizedBox(height: 24),
                  Text(
                    '¡Pago Exitoso!',
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Gracias por tu compra del $planTitle',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Con esto, ayudas a que ${jaguar.name} tenga una vida más larga y feliz',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Monto pagado: \$${planPrice.toStringAsFixed(2)} MXN',
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      List<Jaguar> misJaguares = [];
                      misJaguares.add(jaguar);
                      Navigator.of(context).pushAndRemoveUntil(
                        // MaterialPageRoute(builder: (context) => PlanSelectionScreen(jaguar: jaguar,)),
                        MaterialPageRoute(builder: (context) => AdoptedJaguarsScreen(adoptedJaguars: misJaguares,)),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      'Ver mis adopciones',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}