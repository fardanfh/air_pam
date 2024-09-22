

import 'package:air_pam/models/payment_method_mode.dart';
import 'package:air_pam/models/transaction_type_model.dart';

class TransactionModel {
  final int? id;
  final int? userId;
  final int? transactionTypeId;
  final int? paymentMethodId;
  final int? tagihanId;
  final int? amount;
  final String? transactionCode;
  final String? description;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic product;
  final PaymentMethodModel? paymentMethod;
  final TransactionTypeModel? transactionType;

  TransactionModel({
    this.id,
    this.userId,
    this.transactionTypeId,
    this.paymentMethodId,
    this.tagihanId,
    this.amount,
    this.transactionCode,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.paymentMethod,
    this.transactionType,
  });

  TransactionModel copyWith({
    int? id,
    int? userId,
    int? transactionTypeId,
    int? paymentMethodId,
    int? tagihanId,
    int? amount,
    String? transactionCode,
    String? description,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic product,
    PaymentMethodModel? paymentMethod,
    TransactionTypeModel? transactionType,
  }) =>
      TransactionModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        transactionTypeId: transactionTypeId ?? this.transactionTypeId,
        paymentMethodId: paymentMethodId ?? this.paymentMethodId,
        tagihanId: tagihanId ?? this.tagihanId,
        amount: amount ?? this.amount,
        transactionCode: transactionCode ?? this.transactionCode,
        description: description ?? this.description,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        product: product ?? this.product,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        transactionType: transactionType ?? this.transactionType,
      );

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        userId: json["user_id"],
        transactionTypeId: json["transaction_type_id"],
        paymentMethodId: json["payment_method_id"],
        tagihanId: json["tagihan_id"],
        amount: json["amount"],
        transactionCode: json["transaction_code"],
        description: json["description"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product: json["product"],
        paymentMethod: json["payment_method"] == null
            ? null
            : PaymentMethodModel.fromJson(json["payment_method"]),
        transactionType: json["transaction_type"] == null
            ? null
            : TransactionTypeModel.fromJson(json["transaction_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "transaction_type_id": transactionTypeId,
        "payment_method_id": paymentMethodId,
        "tagihan_id": tagihanId,
        "amount": amount,
        "transaction_code": transactionCode,
        "description": description,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product,
        "payment_method": paymentMethod?.toJson(),
        "transaction_type": transactionType?.toJson(),
      };
}
