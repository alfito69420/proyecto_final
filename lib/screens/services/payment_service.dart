/*
import 'dart:convert';

import 'package:dio/dio.dart';

class PaymentService {
  
  Future<Map<String, dynamic>> fetchPaymentIntent(int amount) async {
    final response = await Dio().post(
      'http://189.169.104.94:8080/create-payment-intent',
      data: {'amount': amount, 'currency': 'mxn'},
    );

    return jsonDecode(response.data);
  }

}*/

import 'dart:convert';
import 'package:dio/dio.dart';

class PaymentService {
  Future<Map<String, dynamic>> fetchPaymentIntent(int amount) async {
    Dio dio = Dio();

    // Establecer tiempos de espera de conexión y respuesta
    dio.options.connectTimeout = Duration(hours: 0, minutes: 0, seconds: 30); // 5 segundos para conectar
    dio.options.receiveTimeout = Duration(hours: 0, minutes: 0, seconds: 30); // 5 segundos para recibir respuesta

    try {
      final response = await dio.post(
        'http://192.168.1.71:8080/create-payment-intent',
        data: {'amount': amount, 'currency': 'mxn'},
      );

      return jsonDecode(response.data);
    } catch (e) {
      if (e is DioException) {
        // Manejo específico de errores de Dio
        print('Error during payment process: ${e.message}');
      } else {
        // Otros errores generales
        print('Unexpected error: $e');
      }
      rethrow;
    }
  }
}
