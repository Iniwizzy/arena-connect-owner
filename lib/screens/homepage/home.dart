import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(80), // Atur ukuran tinggi sesuai kebutuhan
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Padding(
            padding:
                const EdgeInsets.only(top: 45.0), // Memberikan padding atas
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
                      child: SizedBox(
                        height: 25,
                        child: Icon(Icons.search, size: 25, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 25),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/notifikasi');
                      },
                      child: SizedBox(
                        height: 25,
                        child: Icon(Icons.notifications, size: 25, color: Colors.white),
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
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(left: 47),
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
                                color: white,
                                fontSize: 26,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                              text: "Brian",
                              style: superFont2.copyWith(
                                  color: white, fontSize: 26))
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Selamat datang",
                      style: superFont2.copyWith(
                          color: white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    SizedBox(width: 22)
                  ],
                ),
              )),
          SizedBox(height: 25),

          // Bagian Putih bawah
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0), // Lengkungan di kiri atas
                  topRight: Radius.circular(30.0), // Lengkungan di kanan atas
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 38),
                  _listBar(context),
                  SizedBox(height: 38),
                  _ringkasan(context),
                  SizedBox(height: 38),
                  _pemesanan(context),
                  // SizedBox(height: 150),
                  // _BottomNavigation(context),
                ],
              ),
            ),
          )
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
          padding: EdgeInsets.only(left: 34, right: 34),
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
                SizedBox(height: 8),
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
                      SizedBox(width: 16),
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
    padding: EdgeInsets.only(
      left: 8,
      top: 4,
      bottom: 4,
    ),
    decoration: BoxDecoration(
      color: Color(0XFFFFFFFF),
      borderRadius: BorderRadius.circular(6),
      boxShadow: [
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
        SizedBox(height: 14)
      ],
    ),
  );
}

Widget _pemesanan(BuildContext context) {
  return SizedBox(
    child: Container(
      padding: EdgeInsets.only(left: 34, right: 34),
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
            Spacer(),
            Text(
              "Lihat Semua",
              style: superFont2.copyWith(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: EdgeInsets.only(
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
            SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}

Widget _BottomNavigation(BuildContext context) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 10), // Padding vertikal
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _bottomNavItem(context, '/home', Icons.home, "Beranda", true),
        _bottomNavItem(context, '/pesanan', Icons.book, "Pemesanan", false),
        _bottomNavItem(
            context, '/pembayaran', Icons.payments_sharp, "Pembayaran", false),
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
        Icon(icon, color: isActive ? Color(0xFF0D2C76) : Colors.grey),
        SizedBox(height: 4),
        Text(label,
            style:
                TextStyle(color: isActive ? Color(0xFF0D2C76) : Colors.grey)),
      ],
    ),
  );
}

// Widget _BottomNavigation(BuildContext context) {
//   return Container(
//     color: Colors.white,
//     padding: const EdgeInsets.symmetric(
//         vertical: 10), // Opsional untuk memberi padding di sekitar tombol
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         InkWell(
//           onTap: () {
//             // Aksi ketika ikon Beranda diklik
//             Navigator.pushNamed(context, '/home');
//           },
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Icon(Icons.home, color: Color(0xFF0D2C76)),
//               SizedBox(height: 4),
//               Text("Beranda", style: TextStyle(color: Color(0xFF0D2C76))),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             // Aksi ketika ikon Pemesanan diklik
//             ;
//             Navigator.pushNamed(context, '/pemesanan');
//           },
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Icon(Icons.book, color: Colors.grey),
//               SizedBox(height: 4),
//               Text("Pemesanan", style: TextStyle(color: Colors.grey)),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             // Aksi ketika ikon Pembayaran diklik
//             Navigator.pushNamed(context, '/pembayaran');
//           },
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Icon(Icons.payments_sharp, color: Colors.grey),
//               SizedBox(height: 4),
//               Text("Pembayaran", style: TextStyle(color: Colors.grey)),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             // Aksi ketika ikon Laporan diklik
//             Navigator.pushNamed(context, '/laporankeuangan');
//           },
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Icon(Icons.bar_chart, color: Colors.grey),
//               SizedBox(height: 4),
//               Text("Laporan", style: TextStyle(color: Colors.grey)),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             // Aksi ketika ikon Profil diklik
//             Navigator.pushNamed(context, '/profil');
//           },
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Icon(Icons.person, color: Colors.grey),
//               SizedBox(height: 4),
//               Text("Profil", style: TextStyle(color: Colors.grey)),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }