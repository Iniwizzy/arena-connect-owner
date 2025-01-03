// To parse this JSON data, do
//
//     final resField = resFieldFromJson(jsonString);

import 'dart:convert';

ResField resFieldFromJson(String str) => ResField.fromJson(json.decode(str));

String resFieldToJson(ResField data) => json.encode(data.toJson());

class ResField {
  bool success;
  String message;
  List<Booking> data;

  ResField({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResField.fromJson(Map<String, dynamic> json) => ResField(
        success: json["success"],
        message: json["message"],
        data: List<Booking>.from(json["data"].map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Booking {
  int id;
  int userId;
  int fieldId;
  String bookingStart;
  String bookingEnd;
  // DateTime date;
  String date;
  String cost;
  DateTime createdAt;
  DateTime updatedAt;
  Field user;
  Field field;

  Booking({
    required this.id,
    required this.userId,
    required this.fieldId,
    required this.bookingStart,
    required this.bookingEnd,
    required this.date,
    required this.cost,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.field,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        userId: json["user_id"],
        fieldId: json["field_id"],
        bookingStart: json["booking_start"],
        bookingEnd: json["booking_end"],
        // date: DateTime.parse(json["date"]),
        date: json["date"], // Ambil langsung sebagai String
        cost: json["cost"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: Field.fromJson(json["user"]),
        field: Field.fromJson(json["field"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "field_id": fieldId,
        "booking_start": bookingStart,
        "booking_end": bookingEnd,
        // "date":
        //     "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "date": date, // Simpan sebagai String
        "cost": cost,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "field": field.toJson(),
      };
}

class Field {
  int id;
  String name;

  Field({
    required this.id,
    required this.name,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
