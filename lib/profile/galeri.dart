import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'editprofil.dart';
import 'package:arena_connect/profile/galeri1.dart';

class GaleriPage extends StatelessWidget {
  const GaleriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GalleryScreen(),
    );
  }
}

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with SingleTickerProviderStateMixin {
  final Color darkBlue = Color.fromRGBO(18, 33, 92, 1);
  final Color lightBlue = Color.fromRGBO(72, 157, 214, 1);
  final Color greyColor = Color(0xFFA7ADC3);

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Galeri Foto',
          style: GoogleFonts.poppins(color: Colors.white), // Poppins font
        ),
        backgroundColor: darkBlue,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()));
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: lightBlue,
          labelColor: lightBlue,
          unselectedLabelColor: greyColor,
          tabs: [
            Tab(
              child: Text(
                'Terbaru',
                style: GoogleFonts.poppins(), // Poppins font
              ),
            ),
            Tab(
              child: Text(
                'Galeri',
                style: GoogleFonts.poppins(), // Poppins font
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPhotoGrid('terbaru'), // Grid untuk gambar terbaru
          _buildPhotoGrid('galeri'), // Grid untuk gambar galeri
        ],
      ),
      bottomNavigationBar: _BottomNavigation(context),
    );
  }
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

Widget _buildPhotoGrid(String prefix) {
  return GridView.builder(
    padding: const EdgeInsets.all(8.0),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      childAspectRatio: 1.0,
    ),
    itemCount: 25, // Jumlah gambar
    itemBuilder: (context, index) {
      // Tambahkan GestureDetector atau InkWell untuk mendeteksi klik
      return InkWell(
        onTap: () {
          // Deteksi jika gambar ke-6 (index 5) diklik
          if (index == 5 && prefix == 'galeri') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CropImageScreen(), // Halaman tujuan saat gambar ke-6 diklik
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[300], // Warna latar belakang
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'images/$prefix${index + 1}.jpg', // Menggunakan prefix dan index untuk gambar
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    },
  );
}

// Halaman baru yang akan dituju ketika gambar ke-6 diklik
class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Lain'),
      ),
      body: Center(
        child: Text(
          'Ini adalah halaman lain yang ditampilkan ketika galeri6 diklik.',
          style: GoogleFonts.poppins(fontSize: 18),
        ),
      ),
    );
  }
}
