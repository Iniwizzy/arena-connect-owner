import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/laporan_keuangan/lap_hari.dart';
import 'package:arena_connect/pembayaran/pembayaran.dart';
import 'package:arena_connect/pemesanan/pemesanan.dart';
import 'package:arena_connect/screens/homepage/home.dart';
import 'package:arena_connect/authentication/login.dart';
import 'package:arena_connect/authentication/register.dart';
import 'package:arena_connect/homescreen.dart';
import 'package:arena_connect/beranda/beranda_screen.dart';
import 'package:arena_connect/kalender/kalender_screen.dart';
import 'package:arena_connect/kalender/kalender_detail.dart';
import 'package:arena_connect/tambah-lapangan/tambah_lapangan.dart';
import 'package:arena_connect/daftar_lapangan/daftarlapang.dart';
import 'package:arena_connect/notif/notifikasi.dart';
import 'package:arena_connect/profile/profil1.dart';
import 'package:arena_connect/profile/editprofil.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Jika menggunakan Firebase, aktifkan ini setelah konfigurasi Firebase berhasil
  // await Firebase.initializeApp();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Aktifkan hanya pada debug mode
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      locale: DevicePreview.locale(context), // Mendukung pratinjau bahasa
      builder: DevicePreview.appBuilder, // Builder untuk pratinjau perangkat
      useInheritedMediaQuery: true, // Diperlukan untuk DevicePreview
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(title: 'Beranda'),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/beranda': (context) => const BerandaScreen(),
        '/kalender': (context) => KalenderScreen(),
        '/kalenderdetail': (context) => const KalenderDetailJadwalScreen(),
        '/tambahlapangan': (context) => const TambahLapanganScreen(),
        '/daftarlapang': (context) => const Daftarlapang(),
        '/notifikasi': (context) => const SampleContainer(),
        '/profil': (context) => ProfileScreen(),
        '/editprofil': (context) => EditProfileScreen(),
        '/laporankeuangan': (context) => const LaporanKeuanganScreen(),
        '/home': (context) => const HomePage(),
        '/pesanan': (context) => OrderListScreen(),
        '/pembayaran': (context) => PaymentScreen(),
      },
    );
  }
}
