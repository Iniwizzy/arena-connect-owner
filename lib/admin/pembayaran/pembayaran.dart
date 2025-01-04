import 'package:arena_connect/admin/config/theme.dart';
// import 'package:arena_connect/laporan_keuangan/lap_hari.dart';
import 'package:flutter/material.dart';

class PembayaranPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          backgroundColor: primary,
          elevation: 0,
          leading: Icon(
            Icons.arrow_back,
            color: white,
          ),
          title: Text('PEMBAYARAN',
              style: TextStyle(color: white, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Cari nama pemesan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bukti Pembayaran',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Pembayaran terbaru',
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pemesan',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Tanggal',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Metode',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Expanded(
                          child: ListView(
                            children: [
                              PaymentItem(),
                              PaymentItem(),
                              PaymentItem(),
                              PaymentItem(),
                              PaymentItem(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar()
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         selectedItemColor: Color(0xFF0A1F44),
//         unselectedItemColor: Colors.grey,
//         currentIndex: 2,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Beranda',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.file_copy),
//             label: 'Pemesanan',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.payment),
//             label: 'Pembayaran',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart),
//             label: 'Laporan',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profil',
//           ),
//         ],
//       ),
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
                Icon(Icons.payments_sharp, color: Color(0xFF0D2C76)),
                SizedBox(height: 4),
                Text("Pembayaran", style: TextStyle(color: Color(0xFF0D2C76))),
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
                Icon(Icons.person, color: Colors.grey),
                SizedBox(height: 4),
                Text("Profil", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentItem extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF0A1F44),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://placehold.co/50x50'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ahmad', style: TextStyle(color: Colors.white)),
                  Text('aliamd@gmail.com',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text('10/01/2024', style: TextStyle(color: Colors.white)),
            ],
          ),
          Column(
            children: [
              Text('BNI', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
