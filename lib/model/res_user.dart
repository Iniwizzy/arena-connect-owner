// To parse this JSON data, do
//
//     final resUser = resUserFromJson(jsonString);

import 'dart:convert';

ResUser resUserFromJson(String str) => ResUser.fromJson(json.decode(str));

String resUserToJson(ResUser data) => json.encode(data.toJson());

class ResUser {
  bool success;
  String message;
  List<User> data;

  ResUser({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResUser.fromJson(Map<String, dynamic> json) => ResUser(
        success: json["success"],
        message: json["message"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class User {
  int id;
  String name;
  String email;
  String phoneNumber;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
