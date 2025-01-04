import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TambahAkunScreen extends StatefulWidget {
  const TambahAkunScreen({super.key});

  @override
  _TambahAkunScreenState createState() => _TambahAkunScreenState();
}

class _TambahAkunScreenState extends State<TambahAkunScreen> {
  final Color darkBlue = Color.fromRGBO(18, 33, 92, 1);
  final Color lightBlue = Color.fromRGBO(72, 157, 214, 1);
  final Color greyColor = Color(0xFFA7ADC3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: darkBlue,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   toolbarHeight: 50,
      // ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tambahkan akun atau hapus akun. Menghapus akun juga akan menghapus profil apapun yang dikelola oleh akun tersebut.',
                  style:
                      GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Aksi saat tombol Tambahkan Akun ditekan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkBlue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '+ Tambahkan Akun',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: darkBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                            'https://picsum.photos/200'), // Ganti dengan path gambar
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Brian Imanuel',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'ArenaConnect',
                            style: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Teks "Akun" dan ikon kembali
          Positioned(
            top: 45, // Sesuaikan nilai ini untuk menurunkan teks
            left: 50,
            child: Text(
              'Akun',
              style: GoogleFonts.poppins(
                color: Color.fromRGBO(18, 33, 92, 1),
                fontWeight: FontWeight.w500,
                fontSize: 24, // Menambahkan ukuran font jika diperlukan
              ),
            ),
          ),
          Positioned(
            top: 40, // Menurunkan posisi ikon "<"
            left: 5,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color.fromRGBO(18, 33, 92, 1),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
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
