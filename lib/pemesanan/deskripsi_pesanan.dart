import 'dart:ui';
import 'package:arena_connect/pembayaran/pembayaran.dart';
import 'package:arena_connect/transaksi/transaksi.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/laporan_keuangan/lap_hari.dart';
import 'package:arena_connect/pemesanan/pemesanan.dart';
import 'package:arena_connect/profile/profile.dart';
import 'package:arena_connect/beranda/home_page.dart';

class DeskripsiScreen extends StatelessWidget {
  const DeskripsiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF012D73),
      ),
      initialRoute: '/deskripsi-pesanan',
      routes: {
        '/home': (context) => const HomePage(),
        '/pesanan': (context) => const OrderListScreen(),
        '/pembayaran': (context) => const PaymentScreen(),
        '/laporankeuangan': (context) => const LaporanKeuanganScreen(),
        '/profil': (context) => const ProfilScreen(),
        '/deskripsi-pesanan': (context) => const DeskripsiPesanan(),
      },
      home: const DeskripsiPesanan(),
    );
  }
}

class DeskripsiPesanan extends StatelessWidget {
  const DeskripsiPesanan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF012D73),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/pesanan');
          },
        ),
        title: const Text(
          "Detail Informasi Pesanan",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://img.freepik.com/free-photo/badminton-court_74190-4733.jpg',
                    fit: BoxFit.cover,
                    height: 260,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 260,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 260,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF012D73),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nama Pemesan : Azizah Salsa",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Lapangan Badminton 1     Rp 60.000/sesi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Jl. Mulawarman Sel. Dalam I, Kramas, Tembalang",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Chip(
                          label: Text("Badminton"),
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 7),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Text(
                          "4.5",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Chip(
                          label: Text("TERSEDIA"),
                          backgroundColor: Colors.green,
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Deskripsi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Rehan Futsal Arena merupakan tempat yang cocok untuk bermain badminton. Lapangan yang bersih, rapi dan terawat dengan baik. Lapangan badminton ini memiliki ukuran 11 x 7 meter dan permukaan yang baik.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Tanggal",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Kamis, 19 Sep 2024",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Stack(
                                children: [
                                  BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  const OrderValidationDialog(),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: const Color(0xFF012D73),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "VALIDASI PESANAN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bottomNavItem(context, '/home', Icons.home, "Beranda", false),
          _bottomNavItem(context, '/pesanan', Icons.book, "Pesanan", true),
          _bottomNavItem(
              context, '/pembayaran', Icons.payments_sharp, "Transaksi", false),
          _bottomNavItem(
              context, '/laporankeuangan', Icons.bar_chart, "Laporan", false),
          _bottomNavItem(context, '/profil', Icons.person, "Profil", false),
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
          Icon(
            icon,
            color: isActive ? const Color(0xFF0D2C76) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: isActive ? const Color(0xFF0D2C76) : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

class OrderValidationDialog extends StatelessWidget {
  const OrderValidationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF0B1E41),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'VALIDASI PESANAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
            Divider(color: Colors.grey[400]),
            const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                'Azizah Salsa',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Lapangan Badminton 1',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Sesi Pemesanan',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Siang Hari', style: TextStyle(color: Colors.white)),
                      Text('Pukul 13.00 - 14.00 WIB',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Tanggal Pemesanan',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Kamis, 19 September 2024',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Silahkan konfirmasi pesanan dibawah ini",
              style: TextStyle(color: Colors.white70),
            ),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 50, color: Colors.grey),
                        Text(
                          'Bukti Transfer',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'TERIMA',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'TOLAK',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }
}
