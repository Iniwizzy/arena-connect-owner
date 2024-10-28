import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';

class ProfilePage extends StatelessWidget {
  // Fungsi untuk menampilkan dialog keluar akun
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: white, // Mengubah background rectangle menjadi warna putih
          title: Center(
            child: Column(
              children: [
                Text(
                  'Keluar Akun',
                  style: superFont1.copyWith(color: primary),
                ),
                SizedBox(height: 20), // Reduce the gap between title and the content
                Text(
                  'Apakah kamu yakin ingin keluar akun kamu saat ini?',
                  textAlign: TextAlign.center,
                  style: regulerFont1.copyWith(color: primary),
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.all(20), // Adjusted padding for more space
          content: Container(
            height: 80, // Set height to maintain a balanced shape
            child: Column(
              mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran dialog
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              children: [
                const SizedBox(height: 30), // Jarak antara teks dan tombol
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary, // Warna tombol "Kembali"
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Kembali',
                          style: buttonFont2,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Menutup dialog
                        },
                      ),
                    ),
                    SizedBox(width: 20), // Tambahkan jarak antara dua tombol
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondary, // Warna tombol "Keluar"
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Keluar',
                          style: buttonFont2,
                        ),
                        onPressed: () {
                          // Logika keluar
                          Navigator.of(context).pop(); // Menutup dialog
                          // Tambahkan logika untuk keluar di sini, misalnya pindah ke halaman login
                        },
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Profile', style: superFont1.copyWith(color: white)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: tertiary,
              child: Icon(
                Icons.person,
                size: 50,
                color: white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Thora`s Times',
              style: superFont1,
            ),
            const SizedBox(height: 5),
            Text(
              'thoraatime@gmail.com',
              style: regulerFont1,
            ),
            const SizedBox(height: 20),
            ProfileOption(
              icon: Icons.person,
              text: 'Ubah Profile',
              selectedItemColor: primary,
              onTap: () {
                // Add your profile editing logic here
              },
              color: primary,
            ),
            ProfileOption(
              icon: Icons.lock,
              text: 'Ubah Password',
              onTap: () {
                // Add password changing logic here
              },
              color: primary,
              selectedItemColor: primary,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Ketika tombol "KELUAR" ditekan, tampilkan pop-up dialog
                _showLogoutDialog(context);
              },
              style: longButton1,
              child: Text(
                'KELUAR',
                style: buttonFont1,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Set to Profile page index
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primary,
        unselectedItemColor: tertiary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color color;

  ProfileOption({
    required this.icon,
    required this.text,
    required this.onTap,
    required this.color, required Color selectedItemColor,
  });

  @override
  _ProfileOptionState createState() => _ProfileOptionState();
}

class _ProfileOptionState extends State<ProfileOption> {
  Color arrowColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            arrowColor = primary;
          });
        },
        onExit: (event) {
          setState(() {
            arrowColor = Colors.grey;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: tertiary),
          ),
          child: Row(
            children: <Widget>[
              Icon(widget.icon, color: primary),
              const SizedBox(width: 10),
              Text(
                widget.text,
                style: superFont2,
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios, size: 16, color: arrowColor),
            ],
          ),
        ),
      ),
    );
  }
}