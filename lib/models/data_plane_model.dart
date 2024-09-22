// To parse this JSON data, do
//
//     final dataPlanModel = dataPlanModelFromJson(jsonString);

import 'dart:convert';

DataPlanModel dataPlanModelFromJson(String str) =>
    DataPlanModel.fromJson(json.decode(str));

String dataPlanModelToJson(DataPlanModel data) => json.encode(data.toJson());

class DataPlanModel {
  final int? id;
  final String? name;
  final int? price;
  final int? operatorCardId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DataPlanModel({
    this.id,
    this.name,
    this.price,
    this.operatorCardId,
    this.createdAt,
    this.updatedAt,
  });

  DataPlanModel copyWith({
    int? id,
    String? name,
    int? price,
    int? operatorCardId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      DataPlanModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        operatorCardId: operatorCardId ?? this.operatorCardId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DataPlanModel.fromJson(Map<String, dynamic> json) => DataPlanModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        operatorCardId: json["operator_card_id"],
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
        "price": price,
        "operator_card_id": operatorCardId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
