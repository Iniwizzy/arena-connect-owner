// lib/api/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:8080/api/login'), // ganti dengan URL endpoint login Anda
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        print('Error: ${response.statusCode}, Body: ${response.body}');
        return {
          'success': false,
          'errors': {
            'general': ['Failed to log in']
          }
        };
      }
    } catch (e) {
      print('Exception: $e');
      return {
        'success': false,
        'errors': {
          'general': ['Failed to log in due to an error']
        }
      };
    }
  }
}
