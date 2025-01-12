// To parse this JSON data, do
//
//     final resField = resFieldFromJson(jsonString);

import 'dart:convert';

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
  int fieldCentreId;
  String type;
  String descriptions;
  String status;
  List<Price> price;
  List<Schedule> schedules;
  String address;
  String priceFrom;
  List<String> images;

  Field({
    required this.id,
    required this.name,
    required this.fieldCentreId,
    required this.type,
    required this.descriptions,
    required this.status,
    required this.price,
    required this.schedules,
    required this.address,
    required this.priceFrom,
    required this.images,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        name: json["name"],
        fieldCentreId: json["field_centre_id"],
        type: json["type"],
        descriptions: json["descriptions"],
        status: json["status"],
        price: List<Price>.from(json["price"].map((x) => Price.fromJson(x))),
        schedules: List<Schedule>.from(
            json["schedules"].map((x) => Schedule.fromJson(x))),
        address: json["address"],
        priceFrom: json["price_from"],
        images: List<String>.from(jsonDecode(json["images.*"])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "field_centre_id": fieldCentreId,
        "type": type,
        "descriptions": descriptions,
        "status": status,
        "price": List<dynamic>.from(price.map((x) => x.toJson())),
        "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
        "address": address,
        "price_from": priceFrom,
        "images.*": jsonEncode(images),
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
        priceFrom: json["price_from"],
        priceTo: json["price_to"],
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
        startTime: json["start_time"],
        endTime: json["end_time"],
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
