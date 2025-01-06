import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arena_connect/admin/profile/tambah_rekening2.dart';

class KonfirmasiInformasiBankScreen extends StatelessWidget {
  const KonfirmasiInformasiBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        scaffoldBackgroundColor:
            const Color(0xFFF4F6F9), // Background lebih lembut
      ),
      home: const KonfirmasiInformasiBankPage(),
    );
  }
}

class KonfirmasiInformasiBankPage extends StatefulWidget {
  const KonfirmasiInformasiBankPage({super.key});

  @override
  _KonfirmasiInformasiBankPageState createState() =>
      _KonfirmasiInformasiBankPageState();
}

class _KonfirmasiInformasiBankPageState
    extends State<KonfirmasiInformasiBankPage> {
  int _currentIndex = 4; // Default: Profil tab aktif

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF12215C),
        titleSpacing: 0,
        title: const Text(
          "Konfirmasi Informasi Bank",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          splashColor: Colors.white.withOpacity(0.3), // Efek splash pada tombol
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Container dengan background putih dan border biru tua
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white, // Background putih
                border: Border.all(
                    color: const Color(0xFF12215C),
                    width: 1), // Border biru tua
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: const Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldRow("Nama Bank", "BNI",
                      fontWeight: FontWeight.bold),
                  const SizedBox(height: 8),
                  _buildFieldRow("No. Rekening", "12345678",
                      fontWeight: FontWeight.bold),
                  const SizedBox(height: 8),
                  _buildFieldRow("Nama Lengkap", "Azizah Salsa",
                      fontWeight: FontWeight.bold, hasDivider: false),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Spacer(),
            // Tombol selesai dengan desain lebih simpel
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF489DD6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 2, // Bayangan lembut pada tombol
                ),
                onPressed: () {},
                child: const Text(
                  "SELESAI",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldRow(String title, String value,
      {FontWeight fontWeight = FontWeight.normal, bool hasDivider = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF12215C),
              fontWeight: fontWeight, // Menyesuaikan ketebalan teks
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF12215C),
              fontWeight: FontWeight.w300, // Mempertipis nilai
            ),
          ),
          if (hasDivider)
            const Divider(
                color:
                    Colors.white), // Garis pembatas tipis jika hasDivider true
        ],
      ),
    );
  }
}
