import 'dart:convert';

import 'package:arena_connect/api/api.dart';
import 'package:arena_connect/admin/model/res_payments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FinancialReportScreen extends StatefulWidget {
  const FinancialReportScreen({Key? key}) : super(key: key);

  @override
  State<FinancialReportScreen> createState() => _FinancialReportScreenState();
}

class _FinancialReportScreenState extends State<FinancialReportScreen> {
  bool isLoading = false;
  List<Payment> listBooking = [];
  List<Payment> filteredBooking = [];
  String totalPendapatan = '';
  int totalTransaksi = 0;

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
      List<Payment>? data = resFieldFromJson(res.body).data;
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
  void initState() {
    super.initState();
    getField();
    getTotalRevenue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12215C),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'LAPORAN KEUANGAN',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20), // Added missing comma
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    // Added padding widget
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'TOTAL PENDAPATAN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 12,
                        //     vertical: 4,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.grey),
                        //     borderRadius: BorderRadius.circular(16),
                        //   ),
                        //   child: const Text('Terbaru'),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    // Added padding widget
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1a237e),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jumlah: ',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                formatCurrency(totalPendapatan),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.white24),
                          ListView.builder(
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(), // Changed ScrollPhysics
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: const Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Tanggal',
                                            style: TextStyle(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          Text(
                                            '17 September 2024',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Banyak Sewa',
                                            style: TextStyle(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          Text(
                                            '7 Sewa',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Jumlah',
                                            style: TextStyle(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          Text(
                                            'Rp. 450.000',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
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

String formatCurrency(String value) {
  double doubleValue = double.tryParse(value) ?? 0.0;

  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: '', // Tidak menampilkan simbol mata uang
    decimalDigits: 0,
  );

  String formatted = formatter.format(doubleValue);

  // Hapus trailing ".00" jika ada
  if (formatted.endsWith('.00')) {
    formatted = formatted.replaceAll('.00', '');
  }

  return formatted.trim();
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
            context, '/laporankeuangan', Icons.bar_chart, "Laporan", true),
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
