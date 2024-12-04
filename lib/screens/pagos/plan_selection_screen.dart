import 'package:flutter/material.dart';
import 'package:proyecto_final/models/jaguar.dart';
import 'package:proyecto_final/screens/pagos/plan_details_screen.dart';
import 'package:proyecto_final/settings/theme_settings.dart';

class PlanSelectionScreen extends StatelessWidget {
  PlanSelectionScreen({Key? key, required this.jaguar}) : super(key: key);

  final Jaguar jaguar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planes de Adopción'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Selecciona tu Plan',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                _buildPlanCard(
                  context,
                  'Plan Básico',
                  'Cambia los temas de la app a tu preferencias',
                  99.99,
                  'assets/jaguars/mauricio1.jpg',
                  1,
                ),
                // SizedBox(height: 16),
                // _buildPlanCard(
                //   context,
                //   'Plan Personalizado',
                //   'Personaliza colores y fuentes',
                //   199.99,
                //   'assets/jaguars/abuelo_jaguar1.webp',
                //   2,
                // ),
                SizedBox(height: 16),
                _buildPlanCard(
                  context,
                  'Plan Premium',
                  'Incluye recorrido por el Santuario',
                  499.99,
                  'assets/jaguars/celestun_y_nicte1.jpg',
                  2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String title, String description, double price, String imgUrl, int planId) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PlanDetailsScreen(
          //       planTitle: title,
          //       planDescription: description,
          //       planPrice: price,
          //       imgUrl: imgUrl,
          //       jaguar: jaguar,
          //       planId: planId,
          //     ),
          //   ),
          // );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  // color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${price.toStringAsFixed(2)} MXN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      // color: Colors.green[800],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlanDetailsScreen(
                            planTitle: title,
                            planDescription: description,
                            planPrice: price,
                            imgUrl: imgUrl,
                            jaguar: jaguar,
                            planId: planId,
                          ),
                        ),
                      );
                    },
                    child: Text('Seleccionar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}