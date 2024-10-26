import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

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
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        children: [
          // Bagian atas dengan informasi profil
          Container(
            color: Colors.blue[900],
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, size: 40, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Brian',
                      style: GoogleFonts.poppins(
                        color: Colors.white
                            .withOpacity(0.9), // Warna pudar pada nama Brian
                        fontSize: 24,
                        fontWeight:
                            FontWeight.w500, // Menipiskan ketebalan nama Brian
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.edit, color: Colors.white),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UbahKataSandiScreen()),
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
                                builder: (context) => const BahasaScreen()),
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

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        currentIndex: 4, // Mengatur tab Profil yang terpilih
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.book), // Mengganti ikon pemesanan menjadi ikon buku
            label: "Pemesanan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons
                .payments_sharp), // Mengganti ikon pembayaran menjadi payments_sharp
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
      leading: Icon(icon, color: Colors.blue[900]),
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
      leading: Icon(icon, color: Colors.blue[900]),
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
                color: Colors.blue.withOpacity(0.7), // Warna pudar
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
}

// Halaman dummy untuk navigasi
class AkunScreen extends StatelessWidget {
  const AkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Akun"),
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
      ),
      body: const Center(child: Text("Halaman Bahasa")),
    );
  }
}
