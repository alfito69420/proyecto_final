import 'dart:convert';

import 'package:dio/dio.dart';

class PaymentService {
  
  Future<Map<String, dynamic>> fetchPaymentIntent(int amount) async {
    final response = await Dio().post(
      'http://192.168.1.71:8080/create-payment-intent',
      data: {'amount': amount, 'currency': 'mxn'},
    );

    return jsonDecode(response.data);
  }

}