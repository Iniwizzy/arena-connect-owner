import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arena_connect/profile/editprofil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          style: GoogleFonts.poppins(
            color:
                Colors.white.withOpacity(0.9), // Warna pudar pada teks Profil
            fontWeight: FontWeight.w500, // Menipiskan ketebalan teks Profil
          ),
        ),
        backgroundColor: Color(0xFF12215C), // Warna baru untuk AppBar
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xFF12215C), // Warna baru untuk background atas
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 29,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.person,
                      size: 29, color: Color.fromRGBO(18, 33, 92, 1)),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selamat Datang',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 14)),
                    Text('Brian',
                        style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()));
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      _buildListTile(
                        icon: Icons.account_circle,
                        title: "Akun",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AkunScreen()));
                        },
                      ),
                      _buildListTile(
                        icon: Icons.lock,
                        title: "Ubah Kata Sandi",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UbahKataSandiScreen()));
                        },
                      ),
                      _buildListTileWithSubtitle(
                        icon: Icons.language,
                        title: "Bahasa",
                        subtitle: "Indonesia",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BahasaScreen()));
                        },
                      ),
                      _buildListTile(
                        icon: Icons.notifications,
                        title: "Notifikasi",
                        onTap: () {
                          // Navigasi ke halaman Notifikasi
                        },
                      ),
                      _buildListTile(
                        icon: Icons.exit_to_app,
                        title: "Keluar",
                        onTap: () {
                          _showLogoutConfirmation(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text("Lainnya",
                    style:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 10),
                Card(
                  elevation: 2,
                  child: _buildListTile(
                    icon: Icons.privacy_tip,
                    title: "Kebijakan Privasi",
                    onTap: () {
                      // Navigasi ke halaman Kebijakan Privasi
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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

  ListTile _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon,
          color: Color.fromRGBO(18, 33, 92, 1)), // Warna baru untuk ikon
      title: Text(title, style: GoogleFonts.poppins()),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  ListTile _buildListTileWithSubtitle({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF12215C)), // Warna baru untuk ikon
      title: Text(title, style: GoogleFonts.poppins()),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              subtitle,
              style: GoogleFonts.poppins(
                color: Color(0xFF12215C).withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
      onTap: onTap,
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Keluar dari akun Anda?',
                  style: GoogleFonts.poppins(
                      color: Color.fromRGBO(18, 33, 92, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Menutup dialog
                      },
                      child: Text('Batalkan',
                          style: GoogleFonts.poppins(
                              color: Color.fromRGBO(18, 33, 92, 1))),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Tambahkan logika logout di sini
                      },
                      child: Text('Keluar',
                          style: GoogleFonts.poppins(color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Halaman dummy untuk navigasi
class AkunScreen extends StatelessWidget {
  const AkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Akun"), backgroundColor: Colors.white),
      body: Center(child: Text("Halaman Akun")),
    );
  }
}

class UbahKataSandiScreen extends StatelessWidget {
  const UbahKataSandiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah Kata Sandi"),
        backgroundColor: Color(0xFF12215C),
      ),
      body: Center(child: Text("Halaman Ubah Kata Sandi")),
    );
  }
}

class BahasaScreen extends StatelessWidget {
  const BahasaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bahasa"),
        backgroundColor: Color(0xFF12215C),
      ),
      body: Center(child: Text("Halaman Bahasa")),
    );
  }
}
