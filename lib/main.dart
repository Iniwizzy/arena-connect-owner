// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/authentication/login.dart';
import 'package:arena_connect/authentication/register.dart';
import 'package:arena_connect/homescreen.dart';
import 'package:arena_connect/beranda/beranda_screen.dart';
import 'package:arena_connect/kalender/kalender.dart';
import 'package:arena_connect/tambah-lapangan/tambah_lapangan.dart';
import 'package:arena_connect/daftar_lapangan/daftarlapang.dart';
import 'package:arena_connect/notif/notifikasi.dart';
import 'package:arena_connect/profile/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

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
        '/kalender': (context) => const KalenderScreen(),
        '/tambahlapangan': (context) => const TambahLapanganScreen(),
        '/daftarlapang': (context) => const DaftarLapang(),
        '/notifikasi': (context) => const SampleContainer(),
        '/profil': (context) => const ProfileScreen(),
      },
    );
  }
}
