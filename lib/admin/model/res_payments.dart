// To parse this JSON data, do
//
//     final resPayment = resPaymentFromJson(jsonString);

import 'dart:convert';

ResPayment resPaymentFromJson(String str) =>
    ResPayment.fromJson(json.decode(str));

String resPaymentToJson(ResPayment data) => json.encode(data.toJson());

class ResPayment {
  bool success;
  String message;
  int totalRevenue;
  int totalTransaksi;
  List<Payment> data;

  ResPayment({
    required this.success,
    required this.message,
    required this.totalRevenue,
    required this.totalTransaksi,
    required this.data,
  });

  factory ResPayment.fromJson(Map<String, dynamic> json) => ResPayment(
        success: json["success"],
        message: json["message"],
        totalRevenue: json["total_revenue"],
        totalTransaksi: json["total_transaksi"],
        data: List<Payment>.from(json["data"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "total_revenue": totalRevenue,
        "total_transaksi": totalTransaksi,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Payment {
  int id;
  int userId;
  int bookingId;
  String totalPayment;
  int? paymentId;
  String status;
  String orderId;
  String? receipt;
  Field field;
  Booking booking;
  User user;
  Bank bank;

  Payment({
    required this.id,
    required this.userId,
    required this.bookingId,
    required this.totalPayment,
    required this.paymentId,
    required this.status,
    required this.orderId,
    required this.receipt,
    required this.field,
    required this.booking,
    required this.user,
    required this.bank,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        userId: json["user_id"],
        bookingId: json["booking_id"],
        totalPayment: json["total_payment"],
        paymentId: json["payment_id"],
        status: json["status"],
        orderId: json["order_id"],
        receipt: json["receipt"],
        field: Field.fromJson(json["field"]),
        booking: Booking.fromJson(json["booking"]),
        user: User.fromJson(json["user"]),
        bank: Bank.fromJson(json["bank"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "booking_id": bookingId,
        "total_payment": totalPayment,
        "payment_id": paymentId,
        "status": status,
        "order_id": orderId,
        "receipt": receipt,
        "field": field.toJson(),
        "booking": booking.toJson(),
        "user": user.toJson(),
        "bank": bank.toJson(),
      };
}

class Bank {
  int id;
  String bankName;
  String accountNumber;
  int fieldCentreId;

  Bank({
    required this.id,
    required this.bankName,
    required this.accountNumber,
    required this.fieldCentreId,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        fieldCentreId: json["field_centre_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_name": bankName,
        "account_number": accountNumber,
        "field_centre_id": fieldCentreId,
      };
}

class Booking {
  int id;
  int fieldId;
  String bookingStart;
  String bookingEnd;
  DateTime date;

  Booking({
    required this.id,
    required this.fieldId,
    required this.bookingStart,
    required this.bookingEnd,
    required this.date,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        fieldId: json["field_id"],
        bookingStart: json["booking_start"],
        bookingEnd: json["booking_end"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "field_id": fieldId,
        "booking_start": bookingStart,
        "booking_end": bookingEnd,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}

class Field {
  int fieldId;
  String name;
  int fieldCentreId;
  int laravelThroughKey;
  FieldCentre fieldCentre;

  Field({
    required this.fieldId,
    required this.name,
    required this.fieldCentreId,
    required this.laravelThroughKey,
    required this.fieldCentre,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        fieldId: json["field_id"],
        name: json["name"],
        fieldCentreId: json["field_centre_id"],
        laravelThroughKey: json["laravel_through_key"],
        fieldCentre: FieldCentre.fromJson(json["field_centre"]),
      );

  Map<String, dynamic> toJson() => {
        "field_id": fieldId,
        "name": name,
        "field_centre_id": fieldCentreId,
        "laravel_through_key": laravelThroughKey,
        "field_centre": fieldCentre.toJson(),
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
        rating: json["rating"]?.toDouble(),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rating": rating,
        "address": address,
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
