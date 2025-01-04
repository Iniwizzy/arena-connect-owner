// To parse this JSON data, do
//
//     final resField = resFieldFromJson(jsonString);

import 'dart:convert';

import 'package:decimal/decimal.dart';

ResField resFieldFromJson(String str) => ResField.fromJson(json.decode(str));

String resFieldToJson(ResField data) => json.encode(data.toJson());

class ResField {
  bool success;
  String message;
  List<Field> data;

  ResField({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResField.fromJson(Map<String, dynamic> json) => ResField(
        success: json["success"],
        message: json["message"],
        data: List<Field>.from(json["data"].map((x) => Field.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

// // ignore: constant_identifier_names
// enum FieldType { Futsal, Badminton, Volley, Basketball }

class Field {
  int id;
  String name;
  int fieldCentreId;
  String type;
  String descriptions;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  FieldCentre fieldCentre;

  Field({
    required this.id,
    required this.name,
    required this.fieldCentreId,
    required this.type,
    required this.descriptions,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.fieldCentre,
  });

  // // Custom method to convert string to FieldType enum
  // static FieldType _parseFieldType(String typeString) {
  //   return FieldType.values.firstWhere(
  //     (e) =>
  //         e.toString().split('.').last.toLowerCase() ==
  //         typeString.toLowerCase(),
  //     orElse: () => FieldType.Badminton, // Default value if not found
  //   );
  // }

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        name: json["name"],
        fieldCentreId: json["field_centre_id"],
        // Convert string types to enum types
        type: json['type'],
        // ? (json['type'] as List)
        //     .map((typeString) => _parseFieldType(typeString))
        //     .toList()
        // : [],
        descriptions: json["descriptions"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fieldCentre: FieldCentre.fromJson(json["field_centre"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "field_centre_id": fieldCentreId,
        "type": type,
        "descriptions": descriptions,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "field_centre": fieldCentre.toJson(),
      };
}

class FieldCentre {
  int id;
  String name;
  String address;
  Decimal priceFrom;
  List<String> images;

  FieldCentre({
    required this.id,
    required this.name,
    required this.address,
    required this.priceFrom,
    required this.images,
  });

  factory FieldCentre.fromJson(Map<String, dynamic> json) => FieldCentre(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        priceFrom: Decimal.parse(json["price_from"].toString()),
        images: List<String>.from(jsonDecode(json["images"])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "price_from": priceFrom,
        "images": jsonEncode(images),
      };
}
