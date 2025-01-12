import 'dart:convert';
import 'dart:ui';
import 'package:arena_connect/admin/model/res_payments.dart';
import 'package:arena_connect/api/api.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/admin/config/theme.dart';
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
  int totalPendapatan = 0;
  int totalTransaksi = 0;
  bool isLoading = false;
  List<Payment> listBooking = [];
  List<Payment> filteredBooking = [];

  @override
  void initState() {
    super.initState();
    _getUser();
    getPesanan();
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

  Future<void> getPesanan() async {
    try {
      setState(() {
        isLoading = true;
      });

      // Ambil token dan userId
      String? token = await ApiService().getToken();
      String? userId = await ApiService().getUserId();

      if (token == null || userId == null) {
        throw Exception('Token or UserId not found');
      }

      // Lakukan request
      final response = await http.get(
        Uri.parse("$baseUrl/payment/user/$userId"),
        headers: {'Authorization': 'Bearer $token'},
      );

      // Parse response
      final jsonResponse = json.decode(response.body);

      if (!jsonResponse['success']) {
        throw Exception(jsonResponse['message'] ?? 'Failed to load data');
      }

      // Parse data payments
      List<Payment> payments = (jsonResponse['data'] as List)
          .map((item) => Payment.fromJson(item))
          .toList();

      setState(() {
        isLoading = false;
        listBooking = payments ?? [];
        filteredBooking = listBooking;
        totalPendapatan = jsonResponse['total_revenue'] ?? 0.0;
        totalTransaksi = jsonResponse['total_transaksi'] ?? 0;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red, // Ubah ke merah untuk error
            duration: const Duration(seconds: 3),
          ),
        );
      }
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
                        Navigator.pushNamed(context, '');
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
                        _pemesanan(context, filteredBooking),
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
    {required int totalPendapatan, required int totalTransaksi}) {
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

// Fungsi format currency
String formatCurrency(int? amount) {
  if (amount == null) return 'Rp 0';

  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return formatter.format(amount);
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

Widget _pemesanan(BuildContext context, List<Payment> filteredBooking) {
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
        _riwayatpesanan(context, filteredBooking),
      ],
    ),
  );
}

Widget _riwayatpesanan(BuildContext context, List<Payment> filteredBooking) {
  // Filter dan limit data
  // Filter untuk satu pesanan terbaru
  List<dynamic> filteredBookingBelum = filteredBooking
      .where((payment) => payment.status.toLowerCase() == "proses")
      .toList()
    ..sort((a, b) => DateTime.parse(b.booking.date.toString())
        .compareTo(DateTime.parse(a.booking.date.toString())));

  // Ambil satu data terbaru
  filteredBookingBelum = filteredBookingBelum.take(1).toList();

  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.2, // Set specific height
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: filteredBookingBelum.isEmpty
                  ? const Center(
                      child: Text(
                        'Tidak ada pesanan dalam proses',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredBookingBelum.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16.0),
                      itemBuilder: (context, index) {
                        final pesanan = filteredBookingBelum[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF12215C),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            leading: const CircleAvatar(
                              backgroundImage:
                                  NetworkImage('https://picsum.photos/200'),
                              radius: 25,
                            ),
                            title: Text(
                              pesanan.user.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  pesanan.field.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  DateFormat('EEEE, d MMMM yyyy', 'id_ID')
                                      .format(
                                    DateTime.parse(
                                        pesanan.booking.date.toString()),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
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
