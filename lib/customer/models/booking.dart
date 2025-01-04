import 'dart:convert';

import 'package:decimal/decimal.dart';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  bool success;
  String message;
  BookingData data;

  Booking({
    required this.success,
    required this.message,
    required this.data,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      success: json["success"],
      message: json["message"],
      data: BookingData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data.toJson(),
    };
  }
}

class BookingData {
  int id;
  int userId;
  int fieldId;
  String bookingStart;
  String bookingEnd;
  String date;
  String cost;
  DateTime updatedAt;
  DateTime createdAt;
  User? user;
  Field? field;

  BookingData({
    required this.id,
    required this.userId,
    required this.fieldId,
    required this.bookingStart,
    required this.bookingEnd,
    required this.date,
    required this.cost,
    required this.updatedAt,
    required this.createdAt,
    this.user,
    this.field,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      id: json["id"],
      userId: json["user_id"],
      fieldId: json["field_id"],
      bookingStart: json["booking_start"].substring(0, 5),
      bookingEnd: json["booking_end"].substring(0, 5),
      date: json["date"],
      cost: Decimal.parse(json["cost"]).toString(),
      updatedAt: DateTime.parse(json["updated_at"]),
      createdAt: DateTime.parse(json["created_at"]),
      user: json["user"] != null ? User.fromJson(json["user"]) : null,
      field: json["field"] != null ? Field.fromJson(json["field"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "field_id": fieldId,
      "booking_start": bookingStart,
      "booking_end": bookingEnd,
      "date": date,
      "cost": cost,
      "updated_at": updatedAt.toIso8601String(),
      "created_at": createdAt.toIso8601String(),
      "user": user?.toJson(),
      "field": field?.toJson(),
    };
  }
}

class User {
  int id;
  String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Field {
  int id;
  String name;
  int fieldCentreId;
  String type;
  FieldCentre? fieldCentre;

  Field({
    required this.id,
    required this.name,
    required this.fieldCentreId,
    required this.type,
    this.fieldCentre,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        name: json["name"],
        fieldCentreId: json["field_centre_id"],
        type: json["type"],
        fieldCentre: json["field_centre"] != null
            ? FieldCentre.fromJson(json["field_centre"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "field_centre_id": fieldCentreId,
        "type": type,
        "field_centre": fieldCentre?.toJson(),
      };
}

class FieldCentre {
  int id;
  String name;
  double rating;
  String address;

  FieldCentre({
    required this.id,
    required this.name,
    required this.rating,
    required this.address,
  });

  factory FieldCentre.fromJson(Map<String, dynamic> json) => FieldCentre(
        id: json["id"],
        name: json["name"],
        rating: json["rating"].toDouble(),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rating": rating,
        "address": address,
      };
}
