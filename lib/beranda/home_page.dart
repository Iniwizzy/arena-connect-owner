import 'package:arena_connect/api/api.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  String userEmail = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUser();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
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
                        _ringkasan(context),
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

Widget _ringkasan(BuildContext context) {
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
                          transactionAmount: "0",
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _ringkasanTransaksi(
                          context,
                          transactionMessage: "Transaksi Berhasil",
                          transactionAmount: "0",
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )));
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
  return SizedBox(
    child: Container(
      padding: const EdgeInsets.only(left: 34, right: 34),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Riwayat Pemesanan",
              style: superFont2.copyWith(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Text(
              "Lihat Semua",
              style: superFont2.copyWith(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 3,
                left: 8,
              ),
              child: SizedBox(
                height: 12,
                width: 8,
                child: SvgPicture.asset(
                  "images/img_vector_12x6.svg",
                ),
              ),
            ),
            const SizedBox(height: 8),
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
