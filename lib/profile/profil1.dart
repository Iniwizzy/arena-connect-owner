import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'editprofil.dart'; // Import halaman edit profil

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(), // Mengatur font menjadi Poppins
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          style: GoogleFonts.poppins(
            color: Colors.white.withOpacity(0.9), // Warna pudar pada teks Profil
            fontWeight: FontWeight.w500, // Menipiskan ketebalan teks Profil
          ),
        ),
        backgroundColor: Color(0xFF12215C), // Warna baru untuk AppBar
      ),
      body: Column(
        children: [
          // Bagian atas dengan informasi profil
          Container(
            color: Color(0xFF12215C), // Warna baru untuk background atas
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 29,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.person, size: 29, color: Colors.grey),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Brian',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.9), // Warna pudar pada nama Brian
                        fontSize: 18,
                        fontWeight: FontWeight.w500, // Menipiskan ketebalan nama Brian
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    // Navigasi ke halaman Edit Profil
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          // List Menu
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
                          // Navigasi ke halaman Akun
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AkunScreen()),
                          );
                        },
                      ),
                      _buildListTile(
                        icon: Icons.lock,
                        title: "Ubah Kata Sandi",
                        onTap: () {
                          // Navigasi ke halaman Ubah Kata Sandi
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UbahKataSandiScreen()),
                          );
                        },
                      ),
                      _buildListTileWithSubtitle(
                        icon: Icons.language,
                        title: "Bahasa",
                        subtitle: "Indonesia",
                        onTap: () {
                          // Navigasi ke halaman Bahasa
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BahasaScreen()),
                          );
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
                          // Navigasi ke halaman Keluar
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Bagian lainnya
                Text("Lainnya",
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey)),
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

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF12215C), // Warna baru untuk item terpilih
        unselectedItemColor: Color(0xFFA7ADC3), // Warna baru untuk item tidak terpilih
        currentIndex: 4, // Mengatur tab Profil yang terpilih
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book), // Mengganti ikon pemesanan menjadi ikon buku
            label: "Pemesanan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_sharp), // Mengganti ikon pembayaran
            label: "Pembayaran",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Laporan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
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
      leading: Icon(icon, color: Color(0xFF12215C)), // Warna baru untuk ikon
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
            padding: const EdgeInsets.only(right: 8.0), // Menggeser ke kiri sedikit
            child: Text(
              subtitle,
              style: GoogleFonts.poppins(
                color: Color(0xFF12215C).withOpacity(0.7), // Warna pudar
                fontSize: 16, // Membesarkan ukuran tulisan "Indonesia"
                fontWeight: FontWeight.w400, // Menipiskan sedikit tulisan
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
      onTap: onTap, // Menambahkan navigasi saat di-tap
    );
  }
}

// Halaman dummy untuk navigasi
class AkunScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akun"),
        backgroundColor: Color(0xFF12215C), // Warna baru untuk AppBar
      ),
      body: Center(child: Text("Halaman Akun")),
    );
  }
}

class UbahKataSandiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah Kata Sandi"),
        backgroundColor: Color(0xFF12215C), // Warna baru untuk AppBar
      ),
      body: Center(child: Text("Halaman Ubah Kata Sandi")),
    );
  }
}

class BahasaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bahasa"),
        backgroundColor: Color(0xFF12215C), // Warna baru untuk AppBar
      ),
      body: Center(child: Text("Halaman Bahasa")),
    );
  }
}
