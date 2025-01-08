import 'dart:convert';
import 'dart:io';
import 'package:arena_connect/admin/model/res_user.dart';
// import 'package:arena_connect/customer/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:arena_connect/customer/models/booking.dart' as booking;

// const String baseUrl = 'http://localhost:8000/api';
const String baseUrl = 'http://103.150.117.116/api';
const String imageUrl = 'http://103.150.117.116/storage/receipts/';

class ApiService {
  Future<Map<String, dynamic>> register(
      String name, String email, String phoneNumber, String password) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return {'success': true, 'data': ResUser.fromJson(responseData['data'])};
    } else {
      final errorData = jsonDecode(response.body);
      return {'success': false, 'errors': errorData['data']};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', responseData['token']);
      await prefs.setString('user_id', responseData['user']['id'].toString());
      return {
        'success': true,
        'token': responseData['token'],
        'data': User.fromJson(responseData['user'])
      };
    } else {
      final errorData = jsonDecode(response.body);
      return {'success': false, 'errors': errorData['data']};
    }
  }

  Future<Map<String, dynamic>> getUser(String token) async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return {
        'success': true,
        'data': responseData,
      };
    } else {
      final errorData = jsonDecode(response.body);
      return {'success': false, 'errors': errorData};
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, dynamic>> getFacilities() async {
    try {
      String? token = await getToken();
      final url = Uri.parse('$baseUrl/facilities');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData['data'],
          'message': responseData['message'] ?? 'Berhasil mengambil fasilitas'
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Gagal mengambil fasilitas'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan: $e'};
    }
  }

  Future<Map<String, dynamic>> registerField({
    required String userId,
    required String name,
    required String descriptions,
    required String rules,
    required String address,
    required String maps,
    required String phoneNumber,
    required String priceFrom,
    required List<int> facilityIds,
    required List<File> images,
    required String rating,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/field-centres'),
      );

      // Tambahkan token autentikasi
      String? token = await getToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Ubah cara mengirim facility_ids
      for (var i = 0; i < facilityIds.length; i++) {
        request.fields['facility_ids[$i]'] = facilityIds[i].toString();
      }

      // Tambahkan field sesuai dengan validasi Laravel
      request.fields['user_id'] = userId;
      request.fields['name'] = name;
      request.fields['descriptions'] = descriptions;
      request.fields['rules'] = rules;
      request.fields['address'] = address;
      request.fields['maps'] = maps;
      request.fields['phone_number'] = phoneNumber;
      request.fields['price_from'] = priceFrom;
      request.fields['rating'] = rating;

      // Tambahkan file gambar
      for (var i = 0; i < images.length; i++) {
        var pic = await http.MultipartFile.fromPath(
          'images[]',
          images[i].path,
        );
        request.files.add(pic);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Debug print
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        // Parse the response to get the newly created field centre ID
        final responseData = jsonDecode(response.body);

        // Save the field centre ID to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'field_centre_id', responseData['data']['id'].toString());

        return {
          'success': true,
          'data': responseData['data'],
          'field_centre_id': responseData['data']['id'].toString(),
        };
      } else {
        return {
          'success': false,
          'errors': jsonDecode(response.body)['data'] ??
              {'message': 'Gagal menyimpan data'},
        };
      }
    } catch (e) {
      print('Error creating field centre: $e');
      return {
        'success': false,
        'errors': {'message': 'Terjadi kesalahan: $e'},
      };
    }
  }

  Future<Map<String, dynamic>> addField({
    required String name,
    required String fieldCentreId,
    required String type,
    required String descriptions,
    required String status,
  }) async {
    try {
      String? token = await getToken();
      final url = Uri.parse('$baseUrl/fields');

      // Convert status string to boolean before sending
      final bool statusBool = status.toLowerCase() == 'true';

      // Create the request body
      final requestBody = {
        'name': name,
        'field_centre_id': int.parse(fieldCentreId),
        'type': type,
        'descriptions': descriptions,
        'status': statusBool,
      };

      // Debug print the complete request
      print('Request URL: $url');
      print('Request Headers: {');
      print('  Content-Type: application/json');
      if (token != null)
        print(
            '  Authorization: Bearer ${token.substring(0, 20)}...'); // Only print part of token for security
      print('}');
      print('Request Body: ${jsonEncode(requestBody)}');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json', // Add Accept header
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Raw Response Body: ${response.body}');

      // Handle empty response
      if (response.body.isEmpty) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          // If status is success but body is empty, treat as success
          return {
            'success': true,
            'message': 'Lapangan berhasil ditambahkan',
            'data': requestBody // Return the sent data as confirmation
          };
        } else {
          return {
            'success': false,
            'message':
                'Server returned empty response with status ${response.statusCode}',
          };
        }
      }

      // Try to parse the response body
      try {
        final responseData = jsonDecode(response.body);

        if (response.statusCode == 201 || response.statusCode == 200) {
          return {
            'success': true,
            'data': responseData['data'] ?? requestBody,
            'message':
                responseData['message'] ?? 'Lapangan berhasil ditambahkan'
          };
        } else if (response.statusCode == 422) {
          return {
            'success': false,
            'message': 'Validasi gagal',
            'errors': responseData['data']
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Gagal menambahkan lapangan',
            'errors': responseData['data']
          };
        }
      } catch (parseError) {
        print('Error parsing response: $parseError');
        // If we can't parse the response but got a success status code, treat as success
        if (response.statusCode == 200 || response.statusCode == 201) {
          return {
            'success': true,
            'message': 'Lapangan berhasil ditambahkan',
            'data': requestBody
          };
        }
        return {
          'success': false,
          'message': 'Gagal memproses response dari server: $parseError',
        };
      }
    } catch (e) {
      print('Error adding field: $e');
      return {'success': false, 'message': 'Terjadi kesalahan: $e'};
    }
  }

  Future<booking.Booking?> createBooking(int userId, int fieldId,
      String bookingStart, String bookingEnd, String date, String cost) async {
    try {
      String? token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      final response = await http.post(
        Uri.parse("$baseUrl/bookings"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_id": userId,
          "field_id": fieldId,
          "booking_start": bookingStart,
          "booking_end": bookingEnd,
          "date": date,
          "cost": cost,
        }),
      );

      debugPrint('Response status: ${response.statusCode}');
      // debugPrint('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        debugPrint('Parsed response data: $responseData');
        return booking.Booking.fromJson(responseData);
      } else {
        debugPrint('Failed to create booking: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Error creating booking: $e');
      return null;
    }
  }

  Future<booking.Booking> getBooking(int bookingId) async {
    try {
      String? token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/bookings/$bookingId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        debugPrint(response.body);
        return booking.Booking.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load booking: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error in getBooking: $e');
    }
  }

  Future<Map<String, dynamic>> createPayment({
    required int userId,
    required int bookingId,
    required String totalPayment,
    required String status,
    required String orderId,
    String? receipt,
  }) async {
    try {
      String? token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await http.post(
        Uri.parse("$baseUrl/payments"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_id": userId,
          "booking_id": bookingId,
          "total_payment": totalPayment,
          "status": status,
          "order_id": orderId,
          "receipt": receipt,
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {
          'success': true,
          'data': responseData['data'],
        };
      } else {
        final errorData = jsonDecode(response.body);
        debugPrint('Response status: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        return {'success': false, 'errors': errorData['data'] ?? errorData};
      }
    } catch (e) {
      debugPrint('Error creating payment: $e');
      return {'success': false, 'errors': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getBanksByFieldCentreId(
      int fieldCentreId) async {
    try {
      String? token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await http.get(
        Uri.parse("$baseUrl/payments/$fieldCentreId/banks"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {
          'success': true,
          'data': responseData['data'],
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {'success': false, 'errors': errorData['data'] ?? errorData};
      }
    } catch (e) {
      return {'success': false, 'errors': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updatePayment({
    required int paymentId,
    required int userId,
    required int bookingId,
    required String totalPayment,
    required String status,
    required String orderId,
    String? receipt,
  }) async {
    try {
      String? token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await http.put(
        Uri.parse("$baseUrl/payments/$paymentId"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_id": userId,
          "booking_id": bookingId,
          "total_payment": totalPayment,
          "status": status,
          "order_id": orderId,
          "payment_id": paymentId, // Add this field
          "receipt": receipt,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {
          'success': true,
          'data': responseData['data'],
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {'success': false, 'errors': errorData['data'] ?? errorData};
      }
    } catch (e) {
      return {'success': false, 'errors': e.toString()};
    }
  }

  Future<Map<String, dynamic>> uploadReceipt({
    required int paymentId,
    required int userId,
    required int bookingId,
    required String totalPayment,
    required String status,
    required String orderId,
    required String receiptPath,
  }) async {
    try {
      String? token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/payments/$paymentId"),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['user_id'] = userId.toString();
      request.fields['booking_id'] = bookingId.toString();
      request.fields['total_payment'] = int.parse(totalPayment).toString();
      request.fields['status'] = status;
      request.fields['order_id'] = orderId;
      request.files
          .add(await http.MultipartFile.fromPath('receipt', receiptPath));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: $responseBody');

      if (response.statusCode == 200) {
        final responseData = json.decode(responseBody);
        return {
          'success': true,
          'data': responseData['data'],
        };
      } else {
        final responseData = json.decode(responseBody);
        return {
          'success': false,
          'errors': responseData['data'] ?? responseData
        };
      }
    } catch (e) {
      return {'success': false, 'errors': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getPaymentDetails(int paymentId) async {
    try {
      String? token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/payments/$paymentId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {
          'success': responseData['success'],
          'data': responseData['data'],
        };
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        return {
          'success': false,
          'errors': errorData['message'] ?? 'Unknown error',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'errors': e.toString(),
      };
    }
  }

  //   Future<String?> getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

  Future<Map<String, dynamic>> getUserProfile(String token) async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return {
        'success': true,
        'data': responseData,
      };
    } else {
      final errorData = jsonDecode(response.body);
      return {'success': false, 'errors': errorData};
    }
  }

  // Add this method to your ApiService class
  Future<Map<String, dynamic>> addBank({
    required String bankName,
    required String accountNumber,
    required String fieldCentreId,
    required String userId,
  }) async {
    try {
      String? token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final url = Uri.parse('$baseUrl/bank');
      
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'bank_name': bankName,
          'account_number': accountNumber,
          'field_centre_id': int.parse(fieldCentreId),
          'user_id': int.parse(userId),
        }),
      );
      
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData['data'],
          'message': responseData['message'],
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to add bank account',
          'errors': errorData['errors'],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }
}
