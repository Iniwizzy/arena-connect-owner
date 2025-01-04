import 'package:arena_connect/admin/config/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/api/api.dart';
import 'package:arena_connect/admin/model/res_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isPasswordObscured = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  String? _emailError;
  String? _passwordError;

  void _login() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final result = await _apiService.login(email, password);

    // Validasi input awal
    if (result['success']) {
      // Asumsikan result['data'] memberikan object User
      final user = result['data'] as User; // Cast ke model User

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login berhasil')),
      );

      // Gunakan property role dari class User
      if (user.role == 'Customer') {
        Navigator.pushReplacementNamed(context, '/homepage');
      } else if (user.role == 'Admin Lapangan') {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Role tidak valid')),
        );
      }
    } else {
      final errors = result['errors'] ?? {};

      setState(() {
        _emailError = errors['email']?.first ?? null;
        _passwordError = errors['password']?.first ?? null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login gagal, periksa input Anda')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'images/background-image.png',
              fit: BoxFit.cover,
            ),
          ),
          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 40),
                        child: Image.asset(
                          'images/arena-connect1.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 120),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFffffff),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Color(0xFF12215C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Source Sans Pro"),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email,
                                color: Colors.grey, size: 20),
                            hintText: 'Email',
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 233, 233, 233),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 0.8,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 0.8,
                              ),
                            ),
                            errorText: _emailError,
                          ),
                          style: const TextStyle(
                              fontFamily: "Source Sans Pro",
                              fontWeight: FontWeight.w100,
                              color: Color(0xFF0A0A0A),
                              fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isPasswordObscured,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock,
                                color: Colors.grey, size: 20),
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 233, 233, 233),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 0.8,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 0.8,
                              ),
                            ),
                            errorText: _passwordError,
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _isPasswordObscured
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                  size: 16),
                              onPressed: () {
                                setState(() {
                                  _isPasswordObscured = !_isPasswordObscured;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: "Source Sans Pro",
                            fontWeight: FontWeight.w100,
                            color: Color(0xFF0A0A0A),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _login,
                          style: shortButtonSecondary,
                          child: Text(
                            "Login",
                            style: buttonFont3,
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: 'Belum punya akun? ',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF12215C),
                              fontFamily: "Source Sans Pro",
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Register',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/register');
                                    }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
