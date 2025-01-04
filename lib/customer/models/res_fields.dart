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

class Field {
  int id;
  String name;
  FieldCentreId fieldCentreId;
  String type;
  String descriptions;
  String status;
  List<Price> price;
  List<Schedule> schedules;

  Field({
    required this.id,
    required this.name,
    required this.fieldCentreId,
    required this.type,
    required this.descriptions,
    required this.status,
    required this.price,
    required this.schedules,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        name: json["name"],
        fieldCentreId: FieldCentreId.fromJson(json["field_centre_id"]),
        type: json["type"],
        descriptions: json["descriptions"],
        status: json["status"],
        price: (json["price"] as List)
            .map((price) => Price.fromJson(price))
            .toList(),
        schedules: (json["schedules"] as List)
            .map((schedule) => Schedule.fromJson(schedule))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "field_centre_id": fieldCentreId.toJson(),
        "type": type,
        "descriptions": descriptions,
        "status": status,
        "price": List<dynamic>.from(price.map((x) => x.toJson())),
        "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
      };
}

class FieldCentreId {
  String name;
  int id;

  FieldCentreId({
    required this.name,
    required this.id,
  });

  factory FieldCentreId.fromJson(Map<String, dynamic> json) => FieldCentreId(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class Price {
  int fieldId;
  String priceFrom;
  String priceTo;

  Price({
    required this.fieldId,
    required this.priceFrom,
    required this.priceTo,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        fieldId: json["field_id"],
        priceFrom: Decimal.parse(json["price_from"]).toString(),
        priceTo: Decimal.parse(json["price_to"]).toString(),
      );

  Map<String, dynamic> toJson() => {
        "field_id": fieldId,
        "price_from": priceFrom,
        "price_to": priceTo,
      };
}

class Schedule {
  int fieldId;
  DateTime date;
  String startTime;
  String endTime;
  int isBooked;

  Schedule({
    required this.fieldId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        fieldId: json["field_id"],
        date: DateTime.parse(json["date"]),
        startTime: json["start_time"].substring(0, 5),
        endTime: json["end_time"].substring(0, 5),
        isBooked: json["is_booked"],
      );

  Map<String, dynamic> toJson() => {
        "field_id": fieldId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "is_booked": isBooked,
      };
}
