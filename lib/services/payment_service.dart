import 'dart:convert';

import 'package:air_pam/models/payment_method_mode.dart';
import 'package:http/http.dart' as http;

import '../shared/share_values.dart';
import 'auth_service.dart';

class PaymentMethodService {
  Future<List<PaymentMethodModel>> getPaymentMedthods() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse('$baseUrl/payment_methods'),
        headers: {
          'Authorization': token,
        },
      );
      if (res.statusCode == 200) {
        return List<PaymentMethodModel>.from(
          jsonDecode(res.body).map(
            (e) => PaymentMethodModel.fromJson(e),
          ),
        ).toList();
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
