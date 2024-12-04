import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/models/jaguar.dart';
import 'package:proyecto_final/screens/pagos/payment_confirmation_screen.dart';
import 'package:proyecto_final/screens/services/payment_service.dart';
import 'package:proyecto_final/settings/theme_settings.dart';

class PlanDetailsScreen extends StatefulWidget {
  final String planTitle;
  final String planDescription;
  final double planPrice;
  final String imgUrl;
  final Jaguar jaguar;
  final int planId;

  const PlanDetailsScreen({
    Key? key,
    required this.planTitle,
    required this.planDescription,
    required this.planPrice,
    required this.imgUrl,
    required this.jaguar,
    required this.planId,
  }) : super(key: key);

  @override
  State<PlanDetailsScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {
  Future<void> _addJaguarToFirestore(Jaguar jaguar) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      // Referencia a la colección "usuarios" en Firestore
      CollectionReference jaguares =
          FirebaseFirestore.instance.collection('jaguares');

      // Crear un nuevo documento en Firestore con el ID del usuario de Firebase
      await jaguares.doc(jaguar.name).set({
        'nombre': jaguar.name ?? 'Jaguar sin nombre',
        'edad': jaguar.age,
        'sexo': jaguar.sex,
        'foto': jaguar.imageUrl,
        'descripcion': jaguar.description,
        'estatus': jaguar.status,
        'adoptante': user?.uid
      });

      print("Usuario agregado a Firestore.");
    } catch (e) {
      print("Error al agregar el usuario a Firestore: $e");
    }
  }

  Future<void> makePayment(price) async {
    try {
      // 1. Solicitar el Payment Intent al backend
      final paymentIntent =
          await PaymentService().fetchPaymentIntent(price); // Monto en centavos
      print('PAGO: ${paymentIntent['client_secret']}');

      // 2. Inicializar el pago en Flutter
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent['client_secret'],
            merchantDisplayName: 'Jaguar App'),
      );

      // 3. Mostrar la hoja de pago
      await Stripe.instance.presentPaymentSheet();

      // 4. Confirmación
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pago exitoso')));

      //jaguar
      _addJaguarToFirestore(widget.jaguar);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentConfirmationScreen(
            planTitle: widget.planTitle,
            planPrice: widget.planPrice,
            jaguar: widget.jaguar,
            planId: widget.planId,
          ),
        ),
      );
    } catch (e) {
      print('Error during payment process: $e');
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Stripe error: ${e.error.localizedMessage}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred: $e')),
        );
      }
    }
  }

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
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              ThemeSettings.generateSimilarColorHSL(
                  Theme.of(context).scaffoldBackgroundColor)
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.planTitle,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  widget.planDescription,
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
                        widget.imgUrl,
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
                    onPressed: _submitPayment, //() {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => PaymentInfoScreen(
                    //         planTitle: widget.planTitle,
                    //         planPrice: widget.planPrice,
                    //         jaguar: widget.jaguar,
                    //         planId: widget.planId,
                    //       ),
                    //     ),
                    //   );
                    // },
                    child: Text(
                      'Continuar con el pago',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
    switch (widget.planId) {
      case 1:
        features = [
          'Cambio entre tema claro y oscuro',
          'Personalización de colores',
          'Selección de estilos de fuente',
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

  void _submitPayment() async {
    try {
      await makePayment(widget.planPrice.round() *
          100); // Se multiplica x 100 pq el Stripe así lo toma
    } catch (e) {
      print('EXCEPTION $e');
    }
  }
}
