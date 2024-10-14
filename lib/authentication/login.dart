import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const SizedBox(height: 120)
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
                                fontFamily: "SourceSans3"),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
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
                          ),
                          style: const TextStyle(
                              fontFamily: "SourceSans3",
                              fontWeight: FontWeight.w100,
                              color: Color(0xFF0A0A0A),
                              fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
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
                            fontFamily: "SourceSans3",
                            fontWeight: FontWeight.w100,
                            color: Color(0xFF0A0A0A),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/beranda');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF489DD6),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontFamily: 'SourceSans3',
                                  color: Color(0xFFffffff)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: 'Belum punya akun? ',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF12215C),
                              fontFamily: "SourceSans3",
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
