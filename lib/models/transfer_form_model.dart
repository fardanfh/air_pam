// To parse this JSON data, do
//
//     final transferFormModel = transferFormModelFromJson(jsonString);

import 'dart:convert';

TransferFormModel transferFormModelFromJson(String str) =>
    TransferFormModel.fromJson(json.decode(str));

String transferFormModelToJson(TransferFormModel data) =>
    json.encode(data.toJson());

class TransferFormModel {
  final String? amount;
  final String? pin;
  final String? sendTo;

  TransferFormModel({
    this.amount,
    this.pin,
    this.sendTo,
  });

  TransferFormModel copyWith({
    String? amount,
    String? pin,
    String? sendTo,
  }) =>
      TransferFormModel(
        amount: amount ?? this.amount,
        pin: pin ?? this.pin,
        sendTo: sendTo ?? this.sendTo,
      );

  factory TransferFormModel.fromJson(Map<String, dynamic> json) =>
      TransferFormModel(
        amount: json["amount"],
        pin: json["pin"],
        sendTo: json["send_to"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "pin": pin,
        "send_to": sendTo,
      };
}
