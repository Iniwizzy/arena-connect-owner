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
  List<Facility> facilities;
  double rating;
  List<String> images;
  DateTime createdAt;
  DateTime updatedAt;
  User? user;

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
    this.user,
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
        facilities: List<Facility>.from(
            json["facilities"].map((x) => Facility.fromJson(x))),
        rating: json["rating"].toDouble(),
        images: List<String>.from(jsonDecode(json["images"])),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
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
        "facilities": List<dynamic>.from(facilities.map((x) => x.toJson())),
        "rating": rating,
        "images": jsonEncode(images),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user?.toJson(),
      };
}

class User {
  int id;
  String name;
  String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}

class Facility {
  String name;
  Pivot pivot;

  Facility({
    required this.name,
    required this.pivot,
  });

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        name: json["name"],
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  int fieldCentreId;
  int facilityId;

  Pivot({
    required this.fieldCentreId,
    required this.facilityId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        fieldCentreId: json["field_centre_id"],
        facilityId: json["facility_id"],
      );

  Map<String, dynamic> toJson() => {
        "field_centre_id": fieldCentreId,
        "facility_id": facilityId,
      };
}
