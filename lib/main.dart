import 'package:arena_connect/add_field/field_list.dart';
import 'package:arena_connect/add_field/field_list_full.dart';
import 'package:arena_connect/authentication/login.dart';
import 'package:arena_connect/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/authentication/register.dart';
import 'package:arena_connect/authentication/beranda_screen.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(builder: (context) => const MainApp())
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const HomeScreen(),
      //   '/login': (context) => const LoginPage(),
      //   '/register': (context) => const RegisterPage(),
      //   '/beranda': (context) => const BerandaScreen(),
      // },
      home: const ListFullLapang(),
    );
  }
}
