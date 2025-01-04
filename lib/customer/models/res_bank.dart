// To parse this JSON data, do
//
//     final resBank = resBankFromJson(jsonString);

import 'dart:convert';

ResBank resBankFromJson(String str) => ResBank.fromJson(json.decode(str));

String resBankToJson(ResBank data) => json.encode(data.toJson());

class ResBank {
  List<Bank> data;

  ResBank({
    required this.data,
  });

  factory ResBank.fromJson(Map<String, dynamic> json) => ResBank(
        data: List<Bank>.from(json["data"].map((x) => Bank.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Bank {
  int id;
  int userId;
  String bankName;
  String accountNumber;
  int fieldCentreId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Bank({
    required this.id,
    required this.userId,
    required this.bankName,
    required this.accountNumber,
    required this.fieldCentreId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        userId: json["user_id"],
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        fieldCentreId: json["field_centre_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "bank_name": bankName,
        "account_number": accountNumber,
        "field_centre_id": fieldCentreId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
