import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/models/jaguar.dart';
import 'package:proyecto_final/screens/pagos/payment_confirmation_screen.dart';
import 'package:proyecto_final/screens/services/payment_service.dart';
import 'package:proyecto_final/settings/theme_settings.dart';

class PaymentInfoScreen extends StatefulWidget {
  final String planTitle;
  final double planPrice;
  final Jaguar jaguar;
  final int planId;

  const PaymentInfoScreen({
    Key? key,
    required this.planTitle,
    required this.planPrice,
    required this.jaguar,
    required this.planId,
  }) : super(key: key);

  @override
  _PaymentInfoScreenState createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  Future<void> makePayment(price) async {
    try {
      // 1. Solicitar el Payment Intent al backend
      final paymentIntent = await PaymentService().fetchPaymentIntent(price); // Monto en centavos
      print('PAGO: ${paymentIntent['client_secret']}');

      // 2. Inicializar el pago en Flutter
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Jaguar App'
        ),
      );

      // 3. Mostrar la hoja de pago
      await Stripe.instance.presentPaymentSheet();

      // 4. Confirmación
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pago exitoso')));
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

  final _formKey = GlobalKey<FormState>();
  String _cardNumber = '';
  String _expiryDate = '';
  String _cvv = '';
  String _cardHolderName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información de Pago'),
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.asset(
                          'assets/general/logo.png',
                          width: MediaQuery.of(context).size.width * .5,
                          height: 150,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Detalles de la tarjeta',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildTextField(
                    label: 'Número de tarjeta',
                    onSaved: (value) => _cardNumber = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el número de tarjeta';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'Fecha de expiración',
                          onSaved: (value) => _expiryDate = value!,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese la fecha de expiración';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          label: 'CVV',
                          onSaved: (value) => _cvv = value!,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el CVV';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    label: 'Nombre del titular',
                    onSaved: (value) => _cardHolderName = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el nombre del titular';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: _submitPayment,
                      child: Text(
                        'Realizar Pago',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
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

  Widget _buildTextField({
    required String label,
    required Function(String?) onSaved,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange[800]!),
        ),
      ),
      style: TextStyle(color: Colors.white),
      onSaved: onSaved,
      validator: validator,
    );
  }

  void _submitPayment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Aquí iría la lógica para procesar el pago
      await makePayment(widget.planPrice.round() * 100); // Se multiplica x 100 pq el Stripe así lo toma
    }
  }
}