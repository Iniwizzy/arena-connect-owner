import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arena_connect/config/theme.dart';
import 'editprofil.dart'; // Import halaman edit profil

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
      theme: ThemeData(
        textTheme:
            GoogleFonts.poppinsTextTheme(), // Mengatur font menjadi Poppins
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          ProfileHeader(), // Menggunakan widget terpisah untuk bagian profil
          Expanded(
            child: Container(
              color: Colors.white, // Memberikan warna latar belakang putih
              // height: 72,
              child:
                  ProfileMenuList(), // Menggunakan widget terpisah untuk daftar
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(), // Pisah bottom navigation
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Profil",
        style: GoogleFonts.poppins(
          color: Colors.white.withOpacity(0.9),
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Color(0xFF12215C),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF12215C), //padding bawah brian
      padding: EdgeInsets.all(20.0),
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
                style: superFont2.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                'Brian',
                style: superFont2.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileMenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10.0),
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
                    MaterialPageRoute(builder: (context) => AkunScreen()),
                  );
                },
              ),
              _buildListTile(
                icon: Icons.lock,
                title: "Ubah Kata Sandi",
                onTap: () {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BahasaScreen()),
                  );
                },
              ),
              _buildListTile(
                icon: Icons.notifications,
                title: "Notifikasi",
                onTap: () {
                  Navigator.pushNamed(context, '/notifikasi');
                },
              ),
              _buildListTile(
                icon: Icons.exit_to_app,
                title: "Keluar",
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Lainnya",
          style: superFont2.copyWith(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 10),
        Card(
          elevation: 2,
          child: _buildListTile(
            icon: Icons.privacy_tip,
            title: "Kebijakan Privasi",
            onTap: () {},
          ),
        ),
      ],
    );
  }

  ListTile _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF12215C)),
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
      leading: Icon(icon, color: Color(0xFF12215C)),
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
}

class AkunScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akun"),
        backgroundColor: Color(0xFF12215C),
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
        backgroundColor: Color(0xFF12215C),
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
        backgroundColor: Color(0xFF12215C),
      ),
      body: Center(child: Text("Halaman Bahasa")),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
          vertical: 16), // Opsional untuk memberi padding di sekitar tombol
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              // Aksi ketika ikon Beranda diklik
              Navigator.pushNamed(context, '/home');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.home, color: Colors.grey),
                SizedBox(height: 4),
                Text("Beranda", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Aksi ketika ikon Pemesanan diklik
              ;
              Navigator.pushNamed(context, '/pemesanan');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.book, color: Colors.grey),
                SizedBox(height: 4),
                Text("Pemesanan", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Aksi ketika ikon Pembayaran diklik
              Navigator.pushNamed(context, '/pembayaran');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.payments_sharp, color: Colors.grey),
                SizedBox(height: 4),
                Text("Pembayaran", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Aksi ketika ikon Laporan diklik
              Navigator.pushNamed(context, '/laporankeuangan');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.bar_chart, color: Colors.grey),
                SizedBox(height: 4),
                Text("Laporan", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Aksi ketika ikon Profil diklik
              Navigator.pushNamed(context, '/profil');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.person, color: Color(0xFF0D2C76)),
                SizedBox(height: 4),
                Text("Profil", style: TextStyle(color: Color(0xFF0D2C76))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
