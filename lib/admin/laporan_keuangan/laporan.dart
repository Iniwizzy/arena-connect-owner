import 'dart:convert';

import 'package:arena_connect/api/api.dart';
import 'package:arena_connect/admin/model/res_payments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class FinancialReportScreen extends StatefulWidget {
  const FinancialReportScreen({Key? key}) : super(key: key);

  @override
  State<FinancialReportScreen> createState() => _FinancialReportScreenState();
}

class _FinancialReportScreenState extends State<FinancialReportScreen> {
  bool isLoading = false;
  List<Payment> listLaporan = [];
  List<Payment> filteredLaporan = [];
  int totalPendapatan = 0;
  int totalTransaksi = 0;
  String selectedMonth = '';

  Future<void> getField() async {
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
        listLaporan = payments;
        filteredLaporan = payments;
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

  // Future<void> getTotalRevenue() async {
  //   try {
  //     final response = await http.get(Uri.parse("$baseUrl/total-revenue"));

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       setState(() {
  //         totalPendapatan = data['total_revenue'];
  //         totalTransaksi = data['total_transaksi'];
  //       });
  //     } else {
  //       throw Exception('Failed to load total revenue');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    selectedMonth = DateFormat('MMMM yyyy', 'id_ID').format(DateTime.now());
    getField();
    // getTotalRevenue();
  }

  Map<String, List<Payment>> groupTransactionsByMonth(
      List<Payment> transactions) {
    Map<String, List<Payment>> grouped = {};
    for (var transaction in transactions) {
      String monthYear = DateFormat('MMMM yyyy', 'id_ID').format(
        DateTime.parse(transaction.booking.date.toString()),
      );
      if (!grouped.containsKey(monthYear)) {
        grouped[monthYear] = [];
      }
      grouped[monthYear]!.add(transaction);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);

    List<Payment> filteredLaporanSelesai = filteredLaporan
        .where((payment) => payment.status.toLowerCase() == "selesai")
        .toList()
      ..sort((a, b) => DateTime.parse(b.booking.date.toString())
          .compareTo(DateTime.parse(a.booking.date.toString())));

    Map<String, List<Payment>> groupedTransactions =
        groupTransactionsByMonth(filteredLaporanSelesai);

    return Scaffold(
      backgroundColor: const Color(0xFF12215C),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 22,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Laporan Keuangan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF8F9FF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Revenue Card
                  Container(
                    margin: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1a237e), Color(0xFF283593)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1a237e).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Total Pendapatan',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          formatCurrency1(totalPendapatan),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$totalTransaksi Transaksi',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Month Selection
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Riwayat Transaksi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1a237e),
                          ),
                        ),
                        PopupMenuButton<String>(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1a237e).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: Color(0xFF1a237e),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  selectedMonth,
                                  style: const TextStyle(
                                    color: Color(0xFF1a237e),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          itemBuilder: (context) => groupedTransactions.keys
                              .map((month) => PopupMenuItem(
                                    value: month,
                                    child: Text(month),
                                  ))
                              .toList(),
                          onSelected: (String month) {
                            setState(() {
                              selectedMonth = month;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Transactions List
                  Expanded(
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF1a237e),
                            ),
                          )
                        : groupedTransactions[selectedMonth]?.isEmpty ?? true
                            ? Center(
                                child: Text(
                                  'Tidak ada transaksi untuk bulan ini',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                itemCount: groupedTransactions[selectedMonth]
                                        ?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  final transaction = groupedTransactions[
                                      selectedMonth]![index];
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1a237e)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: const Icon(
                                            Icons.receipt_long,
                                            color: Color(0xFF1a237e),
                                            size: 24,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                transaction.user.name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF1a237e),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                DateFormat('EEEE, d MMMM yyyy',
                                                        'id_ID')
                                                    .format(
                                                  DateTime.parse(transaction
                                                      .booking.date
                                                      .toString()),
                                                ),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Rp ${formatCurrency(transaction.totalPayment)}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1a237e),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF4CAF50)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Text(
                                                'Selesai',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF4CAF50),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
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

// Fungsi format currency
String formatCurrency1(int? amount) {
  if (amount == null) return 'Rp 0';

  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return formatter.format(amount);
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
