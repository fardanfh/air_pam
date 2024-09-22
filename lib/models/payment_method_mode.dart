// To parse this JSON data, do
//
//     final paymentMethodModel = paymentMethodModelFromJson(jsonString);

import 'dart:convert';

List<PaymentMethodModel> paymentMethodModelFromJson(String str) =>
    List<PaymentMethodModel>.from(
        json.decode(str).map((x) => PaymentMethodModel.fromJson(x)));

String paymentMethodModelToJson(List<PaymentMethodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentMethodModel {
  final int? id;
  final String? name;
  final String? code;
  final String? thumbnail;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PaymentMethodModel({
    this.id,
    this.name,
    this.code,
    this.thumbnail,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  PaymentMethodModel copyWith({
    int? id,
    String? name,
    String? code,
    String? thumbnail,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PaymentMethodModel(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        thumbnail: thumbnail ?? this.thumbnail,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        thumbnail: json["thumbnail"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "thumbnail": thumbnail,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
