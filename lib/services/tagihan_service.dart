import 'dart:convert';

import 'package:air_pam/models/tagihan_bayar_model.dart';
import 'package:air_pam/models/tagihan_model.dart';
import 'package:air_pam/services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../models/topup_form_model.dart';
import '../models/transfer_form_model.dart';
import '../shared/share_values.dart';

class TagihanService {

Future<List<TagihanModel>> getTagihan() async {
  try {
    final token = await AuthService().getToken();

    final res = await http.get(
      Uri.parse('$baseUrl/tagihan'),
      headers: {
        'Authorization': token,
      },
    );
    final jsonResponse = jsonDecode(res.body);

    if (res.statusCode == 200) {
   
      if (jsonResponse is List) {
        return List<TagihanModel>.from(
          jsonResponse.map(
            (data) {
              return TagihanModel.fromJson(data);
            },
          ),
        );
      } else {
        throw 'Expected a list but got: ${jsonResponse.runtimeType}';
      }
    } else {
      throw jsonResponse['message'] ?? 'An error occurred';
    }
  } catch (e) {
    print('Error: $e'); // Print error details
    rethrow;
  }
}

Future<void> sendTagihanRequest(TagihanBayarModel requestModel) async {
   try {
      // Define the endpoint URL
      final token = await AuthService().getToken();
      final url = Uri.parse('$baseUrl/tagihan');

      // Convert the model to JSON
      final body = jsonEncode(requestModel.toJson());
      print('Request body: $body');
      // Send the POST request
      final response = await http.post(
        url,
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: body,
      );
    
      // Check the status code of the response
      if (response.statusCode == 200) {
        print('Request successful');
      } else {
        throw Exception('Failed to send request: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
      rethrow;
    }
  }

  // Future<String> bayarTagihan(TagihanModel data) async {
  //   try {
  //     final token = await AuthService().getToken();

  //     final res = await http.post(
  //       Uri.parse(
  //         '$baseUrl/tagihan',
  //       ),
  //       headers: {
  //         'Authorization': token,
  //       },
  //       body: data.toJson(),
  //     );

  //     if (res.statusCode == 200) {
  //       return jsonDecode(res.body)['message'];
  //     } else {
  //       throw jsonDecode(res.body)['message'];
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> dataPlane(DataPlanFormModel data) async {
  //   try {
  //     final token = await AuthService().getToken();

  //     final res = await http.post(
  //       Uri.parse(
  //         '$baseUrl/data_plans',
  //       ),
  //       headers: {
  //         'Authorization': token,
  //       },
  //       body: data.toJson(),
  //     );

  //     if (res.statusCode != 200) {
  //       throw jsonDecode(res.body)['message'];
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<List<TransactionModel>> getTransactions() async {
  //   try {
  //     final token = await AuthService().getToken();
  //     final res = await http.get(
  //         Uri.parse(
  //           '$baseUrl/transactions',
  //         ),
  //         headers: {
  //           'Authorization': token,
  //         });

  //     if (res.statusCode == 200) {
  //       return List<TransactionModel>.from(
  //         jsonDecode(res.body)['data'].map(
  //           (transaction) => TransactionModel.fromJson(transaction),
  //         ),
  //       ).toList();
  //     }
  //     throw jsonDecode(res.body)['message'];
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
