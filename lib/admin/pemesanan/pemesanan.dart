import 'dart:convert';
import 'dart:ui';
import 'package:arena_connect/api/api.dart';
// import 'package:arena_connect/laporan_keuangan/lap_hari.dart';
import 'package:arena_connect/admin/laporan_keuangan/laporan.dart';
// import 'package:arena_connect/model/res_bookings.dart';
// import 'package:arena_connect/customer/model/res_payments.dart';
import 'package:arena_connect/admin/pembayaran/pembayaran.dart';
import 'package:arena_connect/admin/profile/profil.dart';
import 'package:arena_connect/admin/beranda/home_page.dart';
import 'package:arena_connect/admin/transaksi/transaksi.dart';
import 'package:arena_connect/admin/model/res_payments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Pemesanan extends StatelessWidget {
  const Pemesanan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF12215C),
        scaffoldBackgroundColor: const Color(0xFF12215C),
      ),
      initialRoute: '/pesanan',
      routes: {
        '/home': (context) => const HomePage(),
        '/pesanan': (context) => const OrderListScreen(),
        '/pembayaran': (context) => const PaymentScreen(),
        '/laporankeuangan': (context) => const FinancialReportScreen(),
        '/profil': (context) => const ProfilPage(),
      },
      home: const OrderListScreen(),
    );
  }
}

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  bool isLoading = false;
  List<Payment> listBooking = [];
  List<Payment> filteredBooking = [];
  // List<FieldCentre> listFieldCentre = [];
  // List<FieldCentre> filteredFieldCentre = [];
  String searchQuery = '';

  Future<void> getField() async {
    try {
      setState(() {
        isLoading = true;
      });
      String? token = await ApiService().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      http.Response res = await http.get(
        Uri.parse("$baseUrl/payments"),
        headers: {'Authorization': 'Bearer $token'},
      );
      List<Payment>? data = resPaymentFromJson(res.body).data;
      setState(() {
        isLoading = false;
        listBooking = data ?? [];
        filteredBooking = listBooking;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
  }

  Future<void> updateStatus(
      BuildContext context, String status, String id) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/payment-status/$id"),
        body: json.encode({"status": status}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Status berhasil diubah ke $status.'),
          backgroundColor: Colors.green,
        ));
        getField(); // Refresh list
        debugPrint(response.body);
      } else {
        debugPrint(response.body);
        throw Exception('Gagal mengubah status: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // get index => null;

  @override
  void initState() {
    super.initState();
    getField();
  }

  @override
  Widget build(BuildContext context) {
    // Filter orders with "Belum" status
    List<dynamic> filteredBookingBelum = filteredBooking
        .where((payment) => payment.status.toLowerCase() == "proses")
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF12215C),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        title: const Text(
          'DAFTAR PESANAN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 20, left: 16.0, right: 16.0),
                child: ListView.separated(
                  itemCount: filteredBookingBelum.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16.0),
                  itemBuilder: (context, index) {
                    final pesanan = filteredBookingBelum[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF12215C),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://picsum.photos/200'),
                          radius: 25,
                        ),
                        title: Text(
                          filteredBookingBelum[index].user.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filteredBookingBelum[index].field.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                            Text(
                              DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(
                                  DateTime.parse(filteredBookingBelum[index]
                                      .booking
                                      .date
                                      .toString())),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            )
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Stack(
                                  children: [
                                    BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                    DetailPesanan(
                                      pesanan: pesanan,
                                      updateStatus: updateStatus,
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                          ),
                          child: const Text(
                            'VALIDASI',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
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

class DetailPesanan extends StatelessWidget {
  final Payment pesanan;
  final Future<void> Function(BuildContext, String, String) updateStatus;

  const DetailPesanan({required this.pesanan, required this.updateStatus});

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
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://picsum.photos/200'),
                radius: 25,
              ),
              title: Text(
                pesanan.user.name,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                pesanan.field.name,
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Sesi Sewa',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${pesanan.booking.bookingStart} - ${pesanan.booking.bookingEnd}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Tanggal Bayar',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(
                        DateTime.parse(pesanan.booking.date.toString())),
                    style: TextStyle(color: Colors.white),
                  ),
                )
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
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage('$imageUrl${pesanan.receipt}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
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
                  onPressed: () async {
                    await updateStatus(
                        context, "Selesai", pesanan.id.toString());
                    // Add delay for 2 seconds
                    await Future.delayed(const Duration(seconds: 1));
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'TERIMA',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await updateStatus(
                        context, "Ditolak", pesanan.id.toString());
                    // Add delay for 2 seconds
                    await Future.delayed(const Duration(seconds: 1));
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
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
    );
  }
}
