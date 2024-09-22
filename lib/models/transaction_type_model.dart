// To parse this JSON data, do
//
//     final transactionType = transactionTypeFromJson(jsonString);

import 'dart:convert';

TransactionTypeModel transactionTypeFromJson(String str) =>
    TransactionTypeModel.fromJson(json.decode(str));

String transactionTypeToJson(TransactionTypeModel data) =>
    json.encode(data.toJson());

class TransactionTypeModel {
  final int? id;
  final String? code;
  final String? name;
  final String? action;
  final String? thumbnail;

  TransactionTypeModel({
    this.id,
    this.code,
    this.name,
    this.action,
    this.thumbnail,
  });

  TransactionTypeModel copyWith({
    int? id,
    String? code,
    String? name,
    String? action,
    String? thumbnail,
  }) =>
      TransactionTypeModel(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        action: action ?? this.action,
        thumbnail: thumbnail ?? this.thumbnail,
      );

  factory TransactionTypeModel.fromJson(Map<String, dynamic> json) =>
      TransactionTypeModel(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        action: json["action"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "action": action,
        "thumbnail": thumbnail,
      };
}
