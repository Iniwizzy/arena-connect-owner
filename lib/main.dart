// import 'package:firebase_core/firebase_core.dart';
import 'package:arena_connect/daftar_lapangan/daftar_lapangan.dart';
// import 'package:arena_connect/daftar_lapangan/daftar_lapangan_full.dart';
import 'package:arena_connect/daftar_lapangan/deskripsi_lapangan.dart';
import 'package:arena_connect/daftar_lapangan/field_search.dart';
import 'package:arena_connect/daftar_lapangan/jam_sewa.dart';
import 'package:arena_connect/daftar_lapangan/mendaftar_lapangan.dart';
import 'package:arena_connect/daftar_lapangan/tambah_lapangan.dart';
// import 'package:arena_connect/laporan_keuangan/lap_hari.dart';
import 'package:arena_connect/laporan_keuangan/laporan.dart';
// import 'package:arena_connect/pemesanan/deskripsi_pesanan.dart';
import 'package:arena_connect/pemesanan/pemesanan.dart';
import 'package:arena_connect/profile/kebijakanprivasi.dart';
import 'package:arena_connect/profile/notifikasi_profile.dart';
// import 'package:arena_connect/pemesanan/validasi_pesanan.dart';
import 'package:arena_connect/profile/profil.dart';
import 'package:arena_connect/profile/tambahakun.dart';
import 'package:arena_connect/profile/ubahsandi1.dart';
import 'package:arena_connect/transaksi/transaksi.dart';
// import 'package:arena_connect/pesanan/pesanan.dart';
import 'package:arena_connect/profile/bahasa.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/authentication/login2.dart';
import 'package:arena_connect/authentication/register.dart';
import 'package:arena_connect/homescreen.dart';
// import 'package:arena_connect/beranda/beranda_screen.dart';
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
        '/home': (context) => const HomePage(),
        '/listlapang': (context) => const ListFields(),
        '/tambahlapangan': (context) => const TambahLapangan(),
        '/daftarlapangan': (context) => const RegisterField(),
        // '/beranda': (context) => const BerandaScreen(),
        '/kalender': (context) => KalenderScreen(),
        '/kalenderdetail': (context) => const KalenderDetailJadwalScreen(),
        // '/daftarlapang': (context) => const ListFullLapang(),
        '/fieldsearch': (context) => const FieldSearch(),
        '/notifikasi': (context) => const SampleContainer(),
        '/laporankeuangan': (context) => const FinancialReportScreen(),
        '/pesanan': (context) => const OrderListScreen(),
        '/pembayaran': (context) => const PaymentScreen(),
        '/password': (context) => ChangePasswordScreen(),
        // '/deskpesanan': (context) => const DeskripsiPesanan(),
        '/desklapangan': (context) => FieldDescription(),
        '/jamsewa': (context) => const JamSewaPage(),
        '/profil': (context) => const ProfilPage(),
        '/editprofil': (context) => const EditProfileScreen(),
        '/tambahakun': (context) => const TambahAkunScreen(),
        '/ubahsandi': (context) => ChangePasswordScreen(),
        '/bahasa': (context) => LanguageSelectionScreen(),
        '/notifikasiprofil': (context) => const NotificationSettingsScreen(),
        // '/keluar': (context) =>
        '/kebijakanprivasi': (context) => const PrivacyPolicyScreen()
        // '/validasi': (context) => const ValidasiPesanan()
      },
    );
  }
}
