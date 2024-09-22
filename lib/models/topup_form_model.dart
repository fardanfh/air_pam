// To parse this JSON data, do
//
//     final topupFormModel = topupFormModelFromJson(jsonString);

import 'dart:convert';

TopupFormModel topupFormModelFromJson(String str) =>
    TopupFormModel.fromJson(json.decode(str));

String topupFormModelToJson(TopupFormModel data) => json.encode(data.toJson());

class TopupFormModel {
  final String? amount;
  final String? pin;
  final String? paymentMethodCode;

  TopupFormModel({
    this.amount,
    this.pin,
    this.paymentMethodCode,
  });

  TopupFormModel copyWith({
    String? amount,
    String? pin,
    String? paymentMethodCode,
  }) =>
      TopupFormModel(
        amount: amount ?? this.amount,
        pin: pin ?? this.pin,
        paymentMethodCode: paymentMethodCode ?? this.paymentMethodCode,
      );

  factory TopupFormModel.fromJson(Map<String, dynamic> json) => TopupFormModel(
        amount: json["amount"],
        pin: json["pin"],
        paymentMethodCode: json["payment_method_code"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "pin": pin,
        "payment_method_code": paymentMethodCode,
      };
}
