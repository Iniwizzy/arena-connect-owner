import 'package:arena_connect/authentication/login.dart';
import 'package:arena_connect/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/authentication/register.dart';
import 'package:arena_connect/authentication/beranda_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/beranda': (context) => const BerandaScreen(),
      },
    );
  }
}
