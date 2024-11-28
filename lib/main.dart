// import 'package:firebase_core/firebase_core.dart';
import 'package:arena_connect/daftar_lapangan/daftar_lapangan.dart';
import 'package:arena_connect/daftar_lapangan/daftar_lapangan_full.dart';
import 'package:arena_connect/daftar_lapangan/deskripsi_lapangan.dart';
import 'package:arena_connect/daftar_lapangan/field_search.dart';
import 'package:arena_connect/daftar_lapangan/jam_sewa.dart';
import 'package:arena_connect/daftar_lapangan/mendaftar_lapangan.dart';
import 'package:arena_connect/daftar_lapangan/tambah_lapangan.dart';
import 'package:arena_connect/laporan_keuangan/lap_hari.dart';
import 'package:arena_connect/pemesanan/deskripsi_pesanan.dart';
import 'package:arena_connect/pemesanan/pemesanan.dart';
import 'package:arena_connect/profile/profil.dart';
import 'package:arena_connect/profile/ubahsandi.dart';
import 'package:arena_connect/transaksi/transaksi.dart';
// import 'package:arena_connect/pesanan/pesanan.dart';
import 'package:arena_connect/profile/bahasa.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/authentication/login2.dart';
import 'package:arena_connect/authentication/register.dart';
import 'package:arena_connect/homescreen.dart';
import 'package:arena_connect/beranda/beranda_screen.dart';
import 'package:arena_connect/kalender/kalender_screen.dart';
import 'package:arena_connect/kalender/kalender_detail.dart';
// import 'package:arena_connect/tambah-lapangan/tambah_lapangan.dart';
// import 'package:arena_connect/daftar_lapangan/daftarlapang.dart';
import 'package:arena_connect/notif/notifikasi.dart';
// import 'package:arena_connect/profile/profile.dart';
// import 'package:arena_connect/profile/profil1.dart';
import 'package:arena_connect/profile/editprofil.dart';
// import 'package:arena_connect/laporan_keuangan/daily.dart';
import 'package:arena_connect/beranda/home_page.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

  runApp(DevicePreview(builder: (context) => const MainApp()));
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
        '/': (context) => const HomeScreen(
              title: 'Beranda',
            ),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/beranda': (context) => const BerandaScreen(),
        '/kalender': (context) => KalenderScreen(),
        '/kalenderdetail': (context) => const KalenderDetailJadwalScreen(),
        '/tambahlapangan': (context) => const TambahLapangan(),
        '/daftarlapangan': (context) => const RegisterField(),
        '/daftarlapang': (context) => const ListFullLapang(),
        '/fieldsearch': (context) => const FieldSearch(),
        '/listlapang': (context) => const ListFields(),
        '/notifikasi': (context) => const SampleContainer(),
        '/profil': (context) => const ProfilPage(),
        '/editprofil': (context) => const EditProfileScreen(),
        '/laporankeuangan': (context) => const LaporanKeuanganScreen(),
        '/home': (context) => const HomePage(),
        '/pesanan': (context) => const OrderListScreen(),
        '/pembayaran': (context) => const PaymentScreen(),
        '/bahasa': (context) => LanguageSelectionScreen(),
        '/password': (context) => ChangePasswordScreen(),
        '/deskpesanan': (context) => const DeskripsiPesanan(),
        '/desklapangan': (context) => FieldDescription(),
        '/jamsewa': (context) => const JamSewaPage(),
      },
    );
  }
}
