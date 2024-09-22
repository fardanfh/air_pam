// To parse this JSON data, do
//
//     final operatorCardModel = operatorCardModelFromJson(jsonString);

import 'dart:convert';

import 'data_plane_model.dart';

OperatorCardModel operatorCardModelFromJson(String str) =>
    OperatorCardModel.fromJson(json.decode(str));

String operatorCardModelToJson(OperatorCardModel data) =>
    json.encode(data.toJson());

class OperatorCardModel {
  final int? id;
  final String? name;
  final String? status;
  final String? thumbnail;
  final dynamic createdAt;
  final dynamic updatedAt;
  final List<DataPlanModel>? dataPlans;

  OperatorCardModel({
    this.id,
    this.name,
    this.status,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
    this.dataPlans,
  });

  OperatorCardModel copyWith({
    int? id,
    String? name,
    String? status,
    String? thumbnail,
    dynamic createdAt,
    dynamic updatedAt,
    List<DataPlanModel>? dataPlans,
  }) =>
      OperatorCardModel(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        thumbnail: thumbnail ?? this.thumbnail,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        dataPlans: dataPlans ?? this.dataPlans,
      );

  factory OperatorCardModel.fromJson(Map<String, dynamic> json) =>
      OperatorCardModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        thumbnail: json["thumbnail"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        dataPlans: json["data_plans"] == null
            ? []
            : List<DataPlanModel>.from(
                json["data_plans"]!.map((x) => DataPlanModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "thumbnail": thumbnail,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "data_plans": dataPlans == null
            ? []
            : List<dynamic>.from(dataPlans!.map((x) => x.toJson())),
      };
}
