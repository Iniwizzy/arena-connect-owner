import 'dart:convert';
import 'dart:io';
import 'package:arena_connect/model/res_user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = 'http://localhost:8000/api';
// const String imageUrl = 'http://localhost/storage/foto_lapangan/';

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

      print('Adding Field with Details:');
      print('Field Centre ID: $fieldCentreId');
      print('Name: $name');
      print('Type: $type');
      print('Descriptions: $descriptions');
      print('Status: $status');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'field_centre_id':
              int.parse(fieldCentreId), // Force parsing as integer
          'type': type,
          'descriptions': descriptions,
          'status': status,
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData['data'],
          'message': responseData['message'] ?? 'Lapangan berhasil ditambahkan'
        };
      } else if (response.statusCode == 422) {
        // Validation error
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': 'Validasi gagal',
          'errors': errorData['data']
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Gagal menambahkan lapangan',
          'errors': errorData['data']
        };
      }
    } catch (e) {
      print('Error adding field: $e');
      return {'success': false, 'message': 'Terjadi kesalahan: $e'};
    }
  }

  // Future<Map<String, dynamic>> registerField({
  //   required String userId,
  //   required String name,
  //   required String descriptions,
  //   required String rules,
  //   required String address,
  //   required String maps,
  //   required String phoneNumber,
  //   required String priceFrom,
  //   required List<int> facilityIds,
  //   required List<File> images,
  //   required String rating,
  // }) async {
  //   try {
  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse('$baseUrl/fields'),
  //     );

  //     // Add text fields
  //     request.fields['nama_lapangan'] = name;
  //     request.fields['lokasi'] = ;
  //     request.fields['deskripsi'] = descriptions;
  //     request.fields['aturan_lapangan'] = rules;
  //     request.fields['fasilitas_lapangan'] = jsonEncode(facilities);

  //     // Add image files
  //     for (var i = 0; i < images.length; i++) {
  //       var pic = await http.MultipartFile.fromPath(
  //         'foto_lapangan[]',
  //         images[i].path,
  //       );
  //       request.files.add(pic);
  //     }

  //     // Add auth token if needed
  //     // request.headers['Authorization'] = 'Bearer $token';

  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       return {
  //         'success': true,
  //         'data': jsonDecode(response.body),
  //       };
  //     } else {
  //       return {
  //         'success': false,
  //         'errors': jsonDecode(response.body)['errors'],
  //       };
  //     }
  //   } catch (e) {
  //     return {
  //       'success': false,
  //       'errors': {'message': 'Terjadi kesalahan pada server'},
  //     };
  //   }
  // }
}
