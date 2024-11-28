// import 'package:arena_connect/profile/editprofil1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arena_connect/profile/editprofil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ProfileScreen(),
      theme: ThemeData(
        textTheme:
            GoogleFonts.poppinsTextTheme(), // Mengatur font menjadi Poppins
      ),
    );
  }
}

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
        backgroundColor: const Color(0xFF12215C),
        centerTitle: false, // Menempatkan teks di sebelah kiri
        // Warna baru untuk AppBar
      ),
      body: Column(
        children: [
          // Bagian atas dengan informasi profil
          Container(
            color: const Color(0xFF12215C), // Warna baru untuk background atas
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 29,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person,
                      size: 29, color: Color.fromRGBO(18, 33, 92, 1)),
                ),
                const SizedBox(width: 16),
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
                        color: Colors.white
                            .withOpacity(0.9), // Warna pudar pada nama Brian
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w500, // Menipiskan ketebalan nama Brian
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    // Navigasi ke halaman Edit Profil
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfileScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          // List Menu
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
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
                                builder: (context) => const AkunScreen()),
                          );
                        },
                      ),
                      _buildListTile(
                        icon: Icons.lock,
                        title: "Ubah Kata Sandi",
                        onTap: () {
                          // Navigasi ke halaman Ubah Kata Sandi
                          Navigator.pushNamed(context, '/password');
                        },
                      ),
                      _buildListTileWithSubtitle(
                        icon: Icons.language,
                        title: "Bahasa",
                        subtitle: "Indonesia",
                        onTap: () {
                          // Navigasi ke halaman Bahasa
                          Navigator.pushNamed(context, '/bahasa');
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
                const SizedBox(height: 20),

                // Bagian lainnya
                Text("Lainnya",
                    style:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 10),
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
    leading:
        Icon(icon, color: const Color(0xFF12215C)), // Warna baru untuk ikon
    title: Text(title, style: GoogleFonts.poppins()),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
    leading:
        Icon(icon, color: const Color(0xFF12215C)), // Warna baru untuk ikon
    title: Text(title, style: GoogleFonts.poppins()),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 8.0), // Menggeser ke kiri sedikit
          child: Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: const Color(0xFF12215C).withOpacity(0.7), // Warna pudar
              fontSize: 16, // Membesarkan ukuran tulisan "Indonesia"
              fontWeight: FontWeight.w400, // Menipiskan sedikit tulisan
            ),
          ),
        ),
        const Icon(Icons.arrow_forward_ios, size: 16),
      ],
    ),
    onTap: onTap, // Menambahkan navigasi saat di-tap
  );
}

// Halaman dummy untuk navigasi
class AkunScreen extends StatelessWidget {
  const AkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Akun"),
        backgroundColor: const Color(0xFF12215C), // Warna baru untuk AppBar
      ),
      body: const Center(child: Text("Halaman Akun")),
    );
  }
}

class UbahKataSandiScreen extends StatelessWidget {
  const UbahKataSandiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Kata Sandi"),
        backgroundColor: const Color(0xFF12215C), // Warna baru untuk AppBar
      ),
      body: const Center(child: Text("Halaman Ubah Kata Sandi")),
    );
  }
}

class BahasaScreen extends StatelessWidget {
  const BahasaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bahasa"),
        backgroundColor: const Color(0xFF12215C), // Warna baru untuk AppBar
      ),
      body: const Center(child: Text("Halaman Bahasa")),
    );
  }
}
