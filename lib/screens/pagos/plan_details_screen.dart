import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/pagos/payment_info_screen.dart';
import 'package:proyecto_final/settings/theme_settings.dart';

class PlanDetailsScreen extends StatelessWidget {
  final String planTitle;
  final String planDescription;
  final double planPrice;
  final String imgUrl;
  final int planId;

  const PlanDetailsScreen({
    Key? key,
    required this.planTitle,
    required this.planDescription,
    required this.planPrice,
    required this.imgUrl,
    required this.planId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Plan'),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  planTitle,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  planDescription,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 24),
                _buildFeaturesList(context),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.asset(
                        imgUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * .5,
                        height: 200,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentInfoScreen(
                            planTitle: planTitle,
                            planPrice: planPrice,
                            planId: planId,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Continuar con el pago',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesList(context) {
    List<String> features;
    switch (planId) {
      case 1:
        features = [
          'Cambio entre tema claro y oscuro',
          'Acceso a contenido básico',
        ];
        break;
      case 2:
        features = [
          'Cambio entre tema claro y oscuro',
          'Personalización de colores',
          'Selección de estilos de fuente',
          'Acceso a contenido premium',
        ];
        break;
      case 3:
        features = [
          'Cambio entre tema claro y oscuro',
          'Personalización de colores',
          'Selección de estilos de fuente',
          'Acceso a contenido premium',
          'Recorrido virtual por el Santuario Jaguar Yaguar Xoo',
          'Contenido exclusivo sobre jaguares',
        ];
        break;
      default:
        features = [];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Características del plan:',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        ...features.map((feature) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green[300]),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feature,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
