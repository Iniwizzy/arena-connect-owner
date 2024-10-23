import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF),
        // decoration:BoxDecoration(borderRadius: BorderRadius.circular(30));
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildHeaderSection(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(
                      left: 32,
                      top: 34,
                      right: 32,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0XFFFFFFFF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNavigationList(context),
                        const SizedBox(height: 38),
                        _buildActivitySummary(context),
                        const SizedBox(height: 38),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 74,
                            width: 233,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF12215C),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Tanggal",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontSize: 15,
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Kamis, 19 Sep 2024",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontSize: 11,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 96)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0XFF12215C),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Image.asset(
                    "images/img_logopng2_1.png",
                    height: 26,
                    width: 70,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(
                          height: 21,
                          width: 57,
                          child: Image.asset(
                            "images/img_search.png",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 19,
                          right: 22,
                        ),
                        child: SizedBox(
                          height: 20,
                          width: 1,
                          child: SvgPicture.asset(
                            "images/img_vector.svg",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.only(left: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Hi",
                        style: TextStyle(
                          color: Color(0XFFFFFFFF),
                          fontSize: 26,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: ", Brian",
                        style: TextStyle(
                          color: Color(0XFFFFFFFF),
                          fontSize: 26,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  "Selamat datang",
                  style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  /// Section Widget
  // Widget _buildNavigationList(BuildContext context) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 22),
  //     width: double.maxFinite,
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Wrap(
  //         direction: Axis.horizontal,
  //         spacing: 36,
  //         children: List.generate(
  //           1,
  //           (index) {
  //             return const NavigationlistItemWidget();
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildActivitySummary(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ringkasan Aktivitas",
            style: TextStyle(
              color: Color(0XFF000000),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            "Aktivitas penyewaan 30 hari terakhir",
            style: TextStyle(
              color: Color(0XFFA7ADC3),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: _buildTransactionSummary(
                    context,
                    transactionMessage: "Pendapatan",
                    transactionAmount: "0",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTransactionSummary(
                    context,
                    transactionMessage: "Transaksi Berhasil",
                    transactionAmount: "0",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Riwayat Pemesanan",
                    style: TextStyle(
                      color: Color(0XFF000000),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  "Lihat Semua",
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 4),
                  child: SizedBox(
                    height: 12,
                    width: 8,
                    child: SvgPicture.asset(
                      "images/img_vector_12x6.svg",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom Navigation Bar
  Widget _buildBottomNavigation(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue[900],
      unselectedItemColor: Colors.grey,
      currentIndex: 0, // Mengatur tab Profil yang terpilih

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Beranda",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: "Pemesanan",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payments_sharp),
          label: "Pembayaran",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: "Laporan",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profil",
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildTransactionSummary(
    BuildContext context, {
    required String transactionMessage,
    required String transactionAmount,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: const Color(0XFFFFFFFF),
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color(0X11000000),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transactionMessage,
            style: const TextStyle(
              color: Color(0XFF000000),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            transactionAmount,
            style: const TextStyle(
              color: Color(0XFF000000),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}

Widget _buildNavigationList(BuildContext context) {
  TextStyle superFont2 = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  return Row(
    mainAxisAlignment:
        MainAxisAlignment.spaceEvenly, // Mengatur jarak antar item
    children: [
      Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/daftarlapang');
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
                  style: superFont2.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
      // Column(
      //   children: [
      //     TextButton(
      //       onPressed: () {
      //         Navigator.pushNamed(context, '/daftarlapang');
      //       },
      //       style: TextButton.styleFrom(
      //         padding: EdgeInsets
      //             .zero, // Menghilangkan padding default pada TextButton
      //         minimumSize: const Size(40, 40), // Mengatur ukuran minimal button
      //       ),
      //       child: Column(
      //         children: [
      //           SvgPicture.asset(
      //             "images/lapangan_icon.svg",
      //             height: 46,
      //             width: 46,
      //           ),
      //           const SizedBox(height: 6),
      //           Text(
      //             "Lapangan",
      //             style: superFont2.copyWith(color: Colors.black),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
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
                  style: superFont2.copyWith(color: Colors.black),
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
                  style: superFont2.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
