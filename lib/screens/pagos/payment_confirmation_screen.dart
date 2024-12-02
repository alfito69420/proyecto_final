import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/pagos/plan_selection_screen.dart';
import 'package:proyecto_final/settings/theme_settings.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final String planTitle;
  final double planPrice;
  final int planId;

  const PaymentConfirmationScreen({
    Key? key,
    required this.planTitle,
    required this.planPrice,
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
                  SizedBox(height: 8),
                  Text(
                    'Monto pagado: \$${planPrice.toStringAsFixed(2)} MXN',
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => PlanSelectionScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      'Volver al Inicio',
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