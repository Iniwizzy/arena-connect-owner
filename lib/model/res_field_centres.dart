// To parse this JSON data, do
//
//     final resFieldCentres = resFieldCentresFromJson(jsonString);

import 'dart:convert';
import 'package:decimal/decimal.dart';

ResFieldCentres resFieldCentresFromJson(String str) =>
    ResFieldCentres.fromJson(json.decode(str));

String resFieldCentresToJson(ResFieldCentres data) =>
    json.encode(data.toJson());

class ResFieldCentres {
  bool success;
  String message;
  List<FieldCentre> data;

  ResFieldCentres({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResFieldCentres.fromJson(Map<String, dynamic> json) =>
      ResFieldCentres(
        success: json["success"],
        message: json["message"],
        data: List<FieldCentre>.from(
            json["data"].map((x) => FieldCentre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FieldCentre {
  int id;
  int userId;
  String name;
  String descriptions;
  String rules;
  String address;
  String maps;
  String phoneNumber;
  Decimal priceFrom;
  List<String> facilities;
  double rating;
  List<String> images;
  DateTime createdAt;
  DateTime updatedAt;

  FieldCentre({
    required this.id,
    required this.userId,
    required this.name,
    required this.descriptions,
    required this.rules,
    required this.address,
    required this.maps,
    required this.phoneNumber,
    required this.priceFrom,
    required this.facilities,
    required this.rating,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FieldCentre.fromJson(Map<String, dynamic> json) => FieldCentre(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        descriptions: json["descriptions"],
        rules: json["rules"],
        address: json["address"],
        maps: json["maps"],
        phoneNumber: json["phone_number"],
        priceFrom: Decimal.parse(json["price_from"].toString()),
        facilities: List<String>.from(jsonDecode(json["facilities"])),
        rating: json["rating"].toDouble(),
        images: List<String>.from(jsonDecode(json["images"])),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "descriptions": descriptions,
        "rules": rules,
        "address": address,
        "maps": maps,
        "phone_number": phoneNumber,
        "price_from": priceFrom,
        "facilities": jsonEncode(facilities),
        "rating": rating,
        "images": jsonEncode(images),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
