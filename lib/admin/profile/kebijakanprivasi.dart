import 'package:arena_connect/admin/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final Color darkBlue = Color.fromRGBO(18, 33, 92, 1);
  final Color lightBlue = Color(0xFF4285F4);
  final Color greyColor = Color(0xFFA7ADC3);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBlue,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Kebijakan Privasi',
              style: GoogleFonts.poppins(
                color: white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        leadingWidth: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildSection(
              '1. Jenis data yang dikumpulkan',
              'Kami mengumpulkan data yang diperlukan untuk menyediakan dan meningkatkan layanan Arena Connect, termasuk nama, email, nomor telepon, serta preferensi lapangan dan jadwal pemesanan. Data Anda hanya dikumpulkan dengan persetujuan dan sesuai dengan peraturan yang berlaku.',
            ),
            const SizedBox(height: 16),
            buildSection(
              '2. Penggunaan data Pribadi',
              'Data pribadi digunakan untuk memproses pemesanan, mengelola akun, memberi dukungan pelanggan, serta mengirimkan pemberitahuan layanan. Kami juga memanfaatkannya untuk analisis dan perbaikan layanan. Arena Connect berkomitmen untuk tidak menggunakan data Anda di luar keperluan ini tanpa persetujuan.',
            ),
            const SizedBox(height: 16),
            buildSection(
              '3. Pengungkapan data Pribadi',
              'Arena Connect tidak akan membagikan data pribadi Anda kepada pihak ketiga tanpa izin, kecuali jika diwajibkan oleh hukum atau untuk tujuan penegakan layanan seperti pembayaran. Jika terdapat kebutuhan untuk membagikan data kepada pihak ketiga, Arena Connect akan mengambil langkah-langkah perlindungan yang diperlukan untuk menjaga keamanan data Anda.',
            ),
            const SizedBox(height: 16),
            buildSection(
              '4. Keamanan data',
              'Arena Connect menerapkan langkah-langkah keamanan teknis dan organisasi untuk melindungi data pribadi Anda dari akses tidak sah, penggunaan yang salah, atau kebocoran data. Kami terus memperbarui sistem keamanan sesuai standar industri.',
            ),
            const SizedBox(height: 16),
            buildSection(
              '5. Hak pengguna',
              'Anda memiliki hak untuk mengakses, mengubah, atau menghapus data pribadi Anda yang telah kami kumpulkan. Jika Anda ingin menggunakan hak tersebut, silakan hubungi tim dukungan kami melalui email resmi Arena Connect.',
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNavigation(context),
    );
  }

  Widget _BottomNavigation(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10), // Padding vertikal
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bottomNavItem(context, '/home', Icons.home, "Beranda", false),
          _bottomNavItem(context, '/pesanan', Icons.book, "Pesanan", false),
          _bottomNavItem(
              context, '/pembayaran', Icons.payments_sharp, "Transaksi", false),
          _bottomNavItem(
              context, '/laporankeuangan', Icons.bar_chart, "Laporan", false),
          _bottomNavItem(context, '/profil', Icons.person, "Profil", true),
        ],
      ),
    );
  }

  Widget _bottomNavItem(BuildContext context, String route, IconData icon,
      String label, bool isActive) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? const Color(0xFF0D2C76) : Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins', // Mengatur font menjadi Poppins
              fontSize: 12,
              color: isActive ? const Color(0xFF0D2C76) : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Colors.black54,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
