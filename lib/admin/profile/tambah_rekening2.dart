import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arena_connect/admin/profile/konfirmasi_informasi.dart';

class TambahRekeningScreen extends StatelessWidget {
  const TambahRekeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const TambahRekeningPage(),
    );
  }
}

class TambahRekeningPage extends StatefulWidget {
  const TambahRekeningPage({super.key});

  @override
  _TambahRekeningPageState createState() => _TambahRekeningPageState();
}

class _TambahRekeningPageState extends State<TambahRekeningPage> {
  int _currentIndex = 4; // Default: Profil tab aktif
  bool _isRekeningUtama = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF12215C),
          titleSpacing: 0,
          title: const Text(
            "Tambah Rekening Bank",
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
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildFieldRow("Nama Lengkap", "Azizah Salsa",
                  fontWeight: FontWeight.normal),
              const SizedBox(height: 10),
              _buildFieldRow("Nama Bank", "BNI",
                  isBankField: true, fontWeight: FontWeight.normal),
              const SizedBox(height: 10),
              _buildFieldRow("No. Rekening", "12345678",
                  fontWeight: FontWeight.normal),
              const SizedBox(height: 16), // Jarak sebelum pembatas
              const Divider(color: Colors.grey),
              const SizedBox(height: 16), // Jarak setelah pembatas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Atur Sebagai Rekening Utama",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF12215C),
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isRekeningUtama = !_isRekeningUtama;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 50,
                      height: 28,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _isRekeningUtama
                            ? const Color(0xFF489DD6)
                            : const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: _isRekeningUtama
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF489DD6), // Menggunakan warna palet
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 5,
                  ),
                  onPressed: () {
                    // Navigasi ke halaman Konfirmasi Informasi Bank setelah tombol "SIMPAN" ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const KonfirmasiInformasiBankScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "SIMPAN",
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
        bottomNavigationBar: _BottomNavigation(context));
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

  Widget _buildFieldRow(String title, String value,
      {bool isBankField = false, FontWeight fontWeight = FontWeight.normal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF12215C),
              fontWeight: fontWeight, // Menyesuaikan ketebalan teks
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: isBankField
                      ? const Color(0xFF489DD6) // Warna biru untuk "BNI"
                      : const Color(0xFF12215C),
                  fontWeight: fontWeight, // Menyesuaikan ketebalan teks
                ),
              ),
              if (isBankField)
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF489DD6), // Ikon juga diberi warna biru
                ),
            ],
          ),
        ],
      ),
    );
  }
}
