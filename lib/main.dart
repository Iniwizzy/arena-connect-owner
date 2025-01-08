// import 'package:firebase_core/firebase_core.dart';
import 'package:arena_connect/admin/beranda/home_page.dart';
import 'package:arena_connect/admin/daftar_lapangan/daftar_lapangan.dart';
import 'package:arena_connect/admin/daftar_lapangan/deskripsi_lapangan.dart';
import 'package:arena_connect/admin/daftar_lapangan/field_search.dart';
import 'package:arena_connect/admin/daftar_lapangan/jam_sewa.dart';
import 'package:arena_connect/admin/daftar_lapangan/mendaftar_lapangan.dart';
import 'package:arena_connect/admin/daftar_lapangan/tambah_lapangan.dart';
import 'package:arena_connect/admin/kalender/kalender_detail.dart';
import 'package:arena_connect/admin/kalender/kalender_screen.dart';
import 'package:arena_connect/admin/laporan_keuangan/laporan.dart';
import 'package:arena_connect/admin/notif/notifikasi.dart';
import 'package:arena_connect/admin/pemesanan/pemesanan.dart';
import 'package:arena_connect/admin/profile/bahasa.dart';
import 'package:arena_connect/admin/profile/editprofil.dart';
import 'package:arena_connect/admin/profile/kebijakanprivasi.dart';
import 'package:arena_connect/admin/profile/konfirmasi_informasi.dart';
import 'package:arena_connect/admin/profile/notifikasi_profile.dart';
import 'package:arena_connect/admin/profile/profil.dart';
import 'package:arena_connect/admin/profile/tambah_rekening2.dart';
import 'package:arena_connect/admin/profile/tambahakun.dart';
import 'package:arena_connect/admin/profile/ubahsandi.dart';
import 'package:arena_connect/admin/transaksi/transaksi.dart';
import 'package:arena_connect/authentication/login2.dart';
import 'package:arena_connect/authentication/register.dart';
import 'package:arena_connect/customer/layouts/bottom_navigation.dart';
import 'package:arena_connect/customer/screens/history/history.dart';
import 'package:arena_connect/customer/screens/homepage/home.dart';
import 'package:arena_connect/customer/screens/profile/profilepage.dart';
import 'package:arena_connect/customer/screens/search/sparring_search.dart';
import 'package:arena_connect/homescreen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  runApp(const MainApp());
  await initializeDateFormatting('id_ID', null);

  // runApp(DevicePreview(builder: (context) => const MainApp()));
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
        '/homepage': (context) => const BottomNavWrapper(child: Home()),
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
        '/kebijakanprivasi': (context) => const PrivacyPolicyScreen(),
        '/rekening': (context) => const TambahRekeningScreen(),
        // '/validasi': (context) => const ValidasiPesanan()
        '/profile': (context) => const BottomNavWrapper(child: ProfilePage()),
        '/search': (context) => const BottomNavWrapper(child: SparringSearch()),
        '/history': (context) => BottomNavWrapper(child: HistoryScreen()),
      },
    );
  }
}

class BottomNavWrapper extends StatelessWidget {
  final Widget child;

  const BottomNavWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
