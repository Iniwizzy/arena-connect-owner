// To parse this JSON data, do
//
//     final resField = resFieldFromJson(jsonString);

import 'dart:convert';

ResField resFieldFromJson(String str) => ResField.fromJson(json.decode(str));

String resFieldToJson(ResField data) => json.encode(data.toJson());

class ResField {
  bool success;
  String message;
  List<Payment> data;

  ResField({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResField.fromJson(Map<String, dynamic> json) => ResField(
        success: json["success"],
        message: json["message"],
        data: List<Payment>.from(json["data"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Payment {
  int id;
  int userId;
  int bookingId;
  String totalPayment;
  String paymentMethod;
  String status;
  String orderId;
  // String paymentCode;
  List<String> receipt;
  // DateTime date;
  // String date;
  DateTime createdAt;
  DateTime updatedAt;
  Field field;
  User user;
  Booking booking;

  Payment({
    required this.id,
    required this.userId,
    required this.bookingId,
    required this.totalPayment,
    required this.paymentMethod,
    required this.status,
    required this.orderId,
    // required this.paymentCode,
    required this.receipt,
    // required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.field,
    required this.user,
    required this.booking,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        userId: json["user_id"],
        bookingId: json["booking_id"],
        totalPayment: json["total_payment"],
        paymentMethod: json["payment_method"],
        status: json["status"],
        orderId: json["order_id"],
        // paymentCode: json["payment_code"],
        receipt: List<String>.from(jsonDecode(json["receipt"])),
        // receipt: json["receipt"],
        // date: DateTime.parse(json["date"]),
        // date: json["date"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        field: Field.fromJson(json["field"]),
        user: User.fromJson(json["user"]),
        booking: Booking.fromJson(json["booking"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "booking_id": bookingId,
        "total_payment": totalPayment,
        "payment_method": paymentMethod,
        "status": status,
        "order_id": orderId,
        // "payment_code": paymentCode,
        "receipt": jsonEncode(receipt),
        // "date":
        //     "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        // "date": date,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "field": field.toJson(),
        "user": user.toJson(),
        "booking": booking.toJson(),
      };
}

class Booking {
  int id;
  int userId;
  int fieldId;
  String bookingStart;
  String bookingEnd;
  String date;
  String cost;
  DateTime createdAt;
  DateTime updatedAt;

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
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        userId: json["user_id"],
        fieldId: json["field_id"],
        bookingStart: json["booking_start"],
        bookingEnd: json["booking_end"],
        date: json["date"],
        // date: DateTime.parse(json["date"]),
        cost: json["cost"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "field_id": fieldId,
        "booking_start": bookingStart,
        "booking_end": bookingEnd,
        "date": date,
        // "date":
        //     "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "cost": cost,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Field {
  int fieldId;
  String name;
  int laravelThroughKey;

  Field({
    required this.fieldId,
    required this.name,
    required this.laravelThroughKey,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        fieldId: json["field_id"],
        name: json["name"],
        laravelThroughKey: json["laravel_through_key"],
      );

  Map<String, dynamic> toJson() => {
        "field_id": fieldId,
        "name": name,
        "laravel_through_key": laravelThroughKey,
      };
}

class User {
  int id;
  String name;
  String email;
  String phoneNumber;
  DateTime? emailVerifiedAt;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.emailVerifiedAt,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}


// // To parse this JSON data, do
// //
// //     final resField = resFieldFromJson(jsonString);

// import 'dart:convert';

// ResPayment resPaymentFromJson(String str) =>
//     ResPayment.fromJson(json.decode(str));

// String resPaymentToJson(ResPayment data) => json.encode(data.toJson());

// class ResPayment {
//   bool success;
//   String message;
//   List<Payment> data;

//   ResPayment({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory ResPayment.fromJson(Map<String, dynamic> json) => ResPayment(
//         success: json["success"],
//         message: json["message"],
//         data: List<Payment>.from(json["data"].map((x) => Payment.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class Payment {
//   int id;
//   int userId;
//   int bookingId;
//   String totalPayment;
//   String paymentMethod;
//   String status;
//   String orderId;
//   String paymentCode;
//   String receipt;
//   DateTime date;
//   DateTime createdAt;
//   DateTime updatedAt;
//   User user;
//   Bookings booking;

//   Payment({
//     required this.id,
//     required this.userId,
//     required this.bookingId,
//     required this.totalPayment,
//     required this.paymentMethod,
//     required this.status,
//     required this.orderId,
//     required this.paymentCode,
//     required this.receipt,
//     required this.date,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.user,
//     required this.booking,
//   });

//   factory Payment.fromJson(Map<String, dynamic> json) => Payment(
//         id: json["id"],
//         userId: json["user_id"],
//         bookingId: json["booking_id"],
//         totalPayment: json["total_payment"],
//         paymentMethod: json["payment_method"],
//         status: json["status"],
//         orderId: json["order_id"],
//         paymentCode: json["payment_code"],
//         receipt: json["receipt"],
//         date: DateTime.parse(json["date"]),
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         user: User.fromJson(json["user"]),
//         booking: Bookings.fromJson(json["booking"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "booking_id": bookingId,
//         "total_payment": totalPayment,
//         "payment_method": paymentMethod,
//         "status": status,
//         "order_id": orderId,
//         "payment_code": paymentCode,
//         "receipt": receipt,
//         "date":
//             "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "user": user.toJson(),
//         "booking": booking.toJson(),
//       };
// }

// class Bookings {
//   int id;
//   int fieldId;

//   Bookings({
//     required this.id,
//     required this.fieldId,
//   });

//   factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
//         id: json["id"],
//         fieldId: json["field_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "field_id": fieldId,
//       };
// }

// class User {
//   int id;
//   String name;

//   User({
//     required this.id,
//     required this.name,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }
