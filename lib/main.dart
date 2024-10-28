// import 'package:arena_connect/authentication/login.dart';
// import 'package:arena_connect/homescreen.dart';
// import 'package:arena_connect/screens/authentication/beranda_screen.dart';
import 'package:flutter/material.dart';
// import 'package:arena_connect/authentication/register.dart';
// import 'package:arena_connect/screens/authentication/beranda_screen.dart';
import 'package:arena_connect/screens/homepage/home.dart';
// import 'package:arena_connect/screens/form/registerField.dart';
// import 'package:arena_connect/screens/bottomBar.dart';

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
        '/': (context) => HomePage(),
        // '/login': (context) => const LoginPage(),
        // '/register': (context) => const RegisterPage(),
        // '/beranda': (context) => const BerandaScreen(),
        // '/tes': (context) =>  NgetesAja(),
      },
    );
  }
}
