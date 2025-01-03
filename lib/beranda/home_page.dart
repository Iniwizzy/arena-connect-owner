import 'dart:convert';

import 'package:arena_connect/api/api.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  String userEmail = '';
  String totalPendapatan = '';
  int totalTransaksi = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getUser();
    getTotalRevenue();
  }

  Future<void> _getUser() async {
    final token = await ApiService().getToken();
    if (token != null) {
      final response = await ApiService().getUser(token);
      if (response['success']) {
        setState(() {
          userName = response['data']['name'];
          userEmail = response['data']['email'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> getTotalRevenue() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/total-revenue"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          totalPendapatan = data['total_revenue'];
          totalTransaksi = data['total_transaksi'];
        });
      } else {
        throw Exception('Failed to load total revenue');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset(
                    "images/img_logopng2_1.png",
                    height: 26,
                    width: 70,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/search');
                      },
                      borderRadius: BorderRadius.circular(50),
                      highlightColor: Colors.white.withOpacity(0.2),
                      splashColor: Colors.white.withOpacity(0.2),
                      child: const SizedBox(
                        height: 45,
                        width: 45,
                        child:
                            Icon(Icons.search, size: 25, color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/notifikasi');
                      },
                      borderRadius: BorderRadius.circular(50),
                      highlightColor: Colors.white.withOpacity(0.2),
                      splashColor: Colors.white.withOpacity(0.2),
                      child: const SizedBox(
                        height: 45,
                        width: 45,
                        child: Icon(Icons.notifications,
                            size: 25, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 25),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.only(left: 47),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Hi, ",
                                style: superFont2.copyWith(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: userName,
                                style: superFont2.copyWith(
                                  color: Colors.white,
                                  fontSize: 26,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Selamat datang",
                          style: superFont2.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 22),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        _listBar(context),
                        const SizedBox(height: 30),
                        _ringkasan(
                          context,
                          totalPendapatan: totalPendapatan,
                          totalTransaksi: totalTransaksi,
                        ),
                        const SizedBox(height: 30),
                        _pemesanan(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: _BottomNavigation(context),
    );
  }
}

Widget _listBar(BuildContext context) {
  return Row(
    mainAxisAlignment:
        MainAxisAlignment.spaceEvenly, // Mengatur jarak antar item
    children: [
      Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/listlapang');
            },
            child: Column(
              children: [
                SizedBox(
                  height: 46,
                  width: 46,
                  child: SvgPicture.asset(
                    "images/lapangan_icon.svg",
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Lapangan",
                  style: superFont2.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/kalender');
            },
            child: Column(
              children: [
                SizedBox(
                  height: 46,
                  width: 46,
                  child: SvgPicture.asset(
                    "images/calendar_icon.svg",
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Kalender",
                  style: superFont2.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/kompetisi');
            },
            child: Column(
              children: [
                SizedBox(
                  height: 46,
                  width: 46,
                  child: SvgPicture.asset(
                    "images/kompetisi_icon.svg",
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Kompetisi",
                  style: superFont2.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _ringkasan(BuildContext context,
    {required String totalPendapatan, required int totalTransaksi}) {
  return SizedBox(
      child: Padding(
          // color: Colors.red,
          padding: const EdgeInsets.only(left: 34, right: 34),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ringkasan Aktivitas",
                  style: superFont2.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Aktivitas penyewaan 30 hari terakhir",
                  style: superFont2.copyWith(
                      color: tertiary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                        child: _ringkasanTransaksi(
                          context,
                          transactionMessage: "Pendapatan",
                          transactionAmount: formatCurrency(totalPendapatan),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _ringkasanTransaksi(
                          context,
                          transactionMessage: "Transaksi Berhasil",
                          transactionAmount: totalTransaksi.toString(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )));
}

String formatCurrency(String value) {
  double doubleValue = double.tryParse(value) ?? 0.0;

  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: '', // Tidak menampilkan simbol mata uang
    decimalDigits: 2, // Tampilkan maksimal 2 desimal
  );

  String formatted = formatter.format(doubleValue);

  // Hapus trailing ".00" jika ada
  if (formatted.endsWith('.00')) {
    formatted = formatted.replaceAll('.00', '');
  }

  return formatted.trim();
}

Widget _ringkasanTransaksi(
  BuildContext context, {
  required String transactionMessage,
  required String transactionAmount,
}) {
  return Container(
    padding: const EdgeInsets.only(
      left: 8,
      top: 4,
      bottom: 4,
    ),
    decoration: BoxDecoration(
      color: const Color(0XFFFFFFFF),
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(
          color: Color(0X11000000),
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(
            0,
            4,
          ),
        )
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(transactionMessage,
            style: superFont4.copyWith(
                color: Colors.black, fontWeight: FontWeight.w400)),
        Text(
          transactionAmount,
          style: superFont2.copyWith(color: Colors.black, fontSize: 15),
        ),
        const SizedBox(height: 14)
      ],
    ),
  );
}

Widget _pemesanan(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 34),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Riwayat Pemesanan",
              style: superFont2.copyWith(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    // Navigasi ke halaman daftar pesanan
                    Navigator.pushNamed(context, '/pesanan');
                  },
                  child: Text(
                    "Lihat Semua",
                    style: superFont2.copyWith(
                      color: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 12,
                  width: 8,
                  child: SvgPicture.asset(
                    "images/img_vector_12x6.svg",
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // List of Pesanan
        _riwayatpesanan(context),
      ],
    ),
  );
}

Widget _riwayatpesanan(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFF12215C), // Dark blue background
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),

          // Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmad Badawi',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Kudus',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '31-12-2024',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          // Detail Button
          ElevatedButton(
            onPressed: () {
              // Aksi untuk tombol "Lihat Detail"
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF64B5F6), // Light blue
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Lihat Detail',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _BottomNavigation(BuildContext context) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 10), // Padding vertikal
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _bottomNavItem(context, '/home', Icons.home, "Beranda", true),
        _bottomNavItem(context, '/pesanan', Icons.book, "Pesanan", false),
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
