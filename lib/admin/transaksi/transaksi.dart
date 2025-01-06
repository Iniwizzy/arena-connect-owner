import 'dart:io';

import 'package:arena_connect/api/api.dart';
import 'package:arena_connect/admin/model/res_payments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// class Pembayaran extends StatelessWidget {
//   const Pembayaran({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color(0xFF1a237e),
//         scaffoldBackgroundColor: const Color(0xFF1a237e),
//       ),
//       home: const PaymentScreen(),
//     );
//   }
// }

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isLoading = false;
  List<Payment> listPayment = [];
  List<Payment> filteredPayment = [];
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
        listPayment = data ?? [];
        filteredPayment = listPayment;
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

  // Widget _bottomNavItem(IconData icon, String label, bool isActive) {
  //   return InkWell(
  //     onTap: () {
  //       setState(() {
  //         _selectedIndex = ['home', 'orders', 'payments', 'reports', 'profile']
  //             .indexOf(label.toLowerCase());
  //       });
  //     },
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(
  //           icon,
  //           color: isActive ? const Color(0xFF0D2C76) : Colors.grey,
  //         ),
  //         const SizedBox(height: 4),
  //         Text(
  //           label,
  //           style: TextStyle(
  //             fontFamily: 'Poppins',
  //             fontSize: 12,
  //             color: isActive ? const Color(0xFF0D2C76) : Colors.grey,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    getField();
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredPayment = listPayment
          .where((payment) => payment.user.name
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  Widget build(BuildContext context) {
    List<dynamic> filteredPaymentBelum = filteredPayment
        .where((payment) => payment.status.toLowerCase() == "selesai")
        .toList();
    return Scaffold(
      body: Stack(
        children: [
          // Blue curved background
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              color: Color(0xFF12215C),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  title: const Text(
                    'PEMBAYARAN',
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
                // App Bar
                // const Padding(
                //   padding: EdgeInsets.all(16.0),
                //   child: Row(
                //     children: [
                //       Icon(Icons.arrow_back_ios, color: Colors.white),
                //       Text(
                //         'PEMBAYARAN',
                //         style: TextStyle(

                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 20,
                //         ),

                //       ),

                //     ],
                //   ),
                // ),

                // Search Bar
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        onChanged: updateSearchQuery,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Cari nama pemesan',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey[400]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ),
                  ],
                ),

                // Payment Details Section
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0c1445),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bukti Pembayaran',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Pembayaran terbaru',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: filteredPaymentBelum.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 16.0,
                            ),
                            itemBuilder: (context, index) {
                              final pesanan = filteredPaymentBelum[index];
                              final screenshotController =
                                  ScreenshotController();
                              return _buildPaymentCard(
                                  pesanan, screenshotController, context);
                              // return _buildPaymentItem();
                              //             return Container(
                              //               margin: const EdgeInsets.only(bottom: 16),
                              //               decoration: BoxDecoration(
                              //                 color: Colors.white.withOpacity(0.1),
                              //                 borderRadius: BorderRadius.circular(15),
                              //               ),
                              //               child: Column(
                              //                 children: [
                              //                   // Header with profile and basic info
                              //                   Padding(
                              //                     padding: EdgeInsets.all(16.0),
                              //                     child: Row(
                              //                       children: [
                              //                         const CircleAvatar(
                              //                           backgroundImage: NetworkImage(
                              //                               'https://picsum.photos/200'),
                              //                           radius: 25,
                              //                         ),
                              //                         SizedBox(width: 12),
                              //                         Expanded(
                              //                           child: Column(
                              //                             crossAxisAlignment:
                              //                                 CrossAxisAlignment.start,
                              //                             children: [
                              //                               Text(
                              //                                 filteredPaymentBelum[index]
                              //                                     .user
                              //                                     .name,
                              //                                 style: const TextStyle(
                              //                                   color: Colors.white,
                              //                                   fontWeight: FontWeight.bold,
                              //                                   fontSize: 16,
                              //                                 ),
                              //                               ),
                              //                               Text(
                              //                                 filteredPaymentBelum[index]
                              //                                     .user
                              //                                     .email,
                              //                                 style: TextStyle(
                              //                                   color: Colors.white70,
                              //                                   fontSize: 14,
                              //                                 ),
                              //                               ),
                              //                             ],
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),

                              //                   // Divider
                              //                   Container(
                              //                     height: 1,
                              //                     color: Colors.white.withOpacity(0.1),
                              //                   ),

                              //                   // Payment details
                              //                   Padding(
                              //                     padding: const EdgeInsets.all(16.0),
                              //                     child: Column(
                              //                       children: [
                              //                         _buildDetailRow(
                              //                             'Nomor Invoice', pesanan.orderId),
                              //                         const SizedBox(height: 8),
                              //                         _buildDetailRow(
                              //                             'Tanggal', pesanan.booking.date),
                              //                         const SizedBox(height: 8),
                              //                         _buildDetailRow('Metode Pembayaran',
                              //                             pesanan.paymentMethod),
                              //                         const SizedBox(height: 8),
                              //                         _buildDetailRow(
                              //                             'Status', pesanan.status),
                              //                         const SizedBox(height: 8),
                              //                         _buildDetailRow('Total Pembayaran',
                              //                             pesanan.totalPayment),
                              //                       ],
                              //                     ),
                              //                   ),

                              //                   // Action buttons
                              //                   Padding(
                              //                     padding: const EdgeInsets.all(16.0),
                              //                     child: Row(
                              //                       children: [
                              //                         Expanded(
                              //                           child: ElevatedButton.icon(
                              //                             onPressed: () {},
                              //                             icon: const Icon(Icons.download),
                              //                             label: const Text('Unduh'),
                              //                             style: ElevatedButton.styleFrom(
                              //                               backgroundColor: Colors.green,
                              //                               foregroundColor: Colors.white,
                              //                               padding:
                              //                                   const EdgeInsets.symmetric(
                              //                                       vertical: 12),
                              //                               shape: RoundedRectangleBorder(
                              //                                 borderRadius:
                              //                                     BorderRadius.circular(8),
                              //                               ),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                         const SizedBox(width: 12),
                              //                         Expanded(
                              //                           child: OutlinedButton.icon(
                              //                             onPressed: () {},
                              //                             icon: const Icon(Icons.share),
                              //                             label: const Text('Bagikan'),
                              //                             style: OutlinedButton.styleFrom(
                              //                               foregroundColor: Colors.white,
                              //                               side: const BorderSide(
                              //                                   color: Colors.white),
                              //                               padding:
                              //                                   const EdgeInsets.symmetric(
                              //                                       vertical: 12),
                              //                               shape: RoundedRectangleBorder(
                              //                                 borderRadius:
                              //                                     BorderRadius.circular(8),
                              //                               ),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomNavigation(context),
    );
  }
}

// Bungkus konten yang ingin di-screenshot dengan widget Screenshot
Widget _buildPaymentCard(dynamic pesanan,
    ScreenshotController screenshotController, BuildContext context) {
  return Column(
    children: [
      // Bagian Screenshot
      Screenshot(
        controller: screenshotController,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              // Header with profile and basic info
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://picsum.photos/200'),
                      radius: 25,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pesanan.user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            pesanan.user.email,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Payment details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDetailRow('Nomor Invoice', pesanan.orderId),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                        'Tanggal',
                        DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(
                            DateTime.parse(pesanan.booking.date.toString()))),
                    const SizedBox(height: 8),
                    _buildDetailRow('Metode Pembayaran', pesanan.bank.bankName),
                    const SizedBox(height: 8),
                    _buildDetailRow('Status', pesanan.status),
                    const SizedBox(height: 8),
                    _buildDetailRow('Total Pembayaran',
                        formatCurrency(pesanan.totalPayment)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bagian Tombol (Unduh dan Bagikan)
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    // Capture screenshot
                    final image = await screenshotController.capture();
                    if (image == null) return;

                    // Get directory
                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath =
                        '${directory.path}/invoice_${pesanan.orderId}_${DateTime.now().millisecondsSinceEpoch}.jpg';

                    // Save image
                    final imageFile = File(imagePath);
                    await imageFile.writeAsBytes(image);

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invoice berhasil diunduh di $imagePath'),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gagal mengunduh invoice')),
                    );
                  }
                },
                icon: const Icon(Icons.download),
                label: const Text('Unduh'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
                  try {
                    final image = await screenshotController.capture();
                    if (image == null) return;

                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath =
                        '${directory.path}/invoice_${pesanan.orderId}_${DateTime.now().millisecondsSinceEpoch}.png';

                    final imageFile = File(imagePath);
                    await imageFile.writeAsBytes(image);

                    // Buat XFile dari path
                    final xFile = XFile(imagePath);

                    // Gunakan XFile dalam shareXFiles
                    await Share.shareXFiles([xFile],
                        text: 'Invoice ${pesanan.orderId}');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gagal membagikan invoice')),
                    );
                  }
                },
                icon: const Icon(Icons.share),
                label: const Text('Bagikan'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
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
            context, '/pembayaran', Icons.payments_sharp, "Transaksi", true),
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

Widget _buildDetailRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    ],
  );
}
