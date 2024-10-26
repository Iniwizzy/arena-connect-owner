import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Column(
        children: [
          // Bagian Biru Atas 
          SizedBox(height: 26,),
          SizedBox(
            height: 26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Image.asset(
                    "images/img_logopng2_1.png",
                    height: 26,
                    width: 70,
                  ),
                ),
                
                Row(
                  children: [
                    SizedBox(
                      height: 20,
                      child: Image.asset(
                        "images/search.png"
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      height: 20,
                      child: Image.asset(
                        "images/img_notif.png",
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 45),
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
                          style: superFont2.copyWith(color: white, fontSize: 26, fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: "Brian",
                          style: superFont2.copyWith(color: white, fontSize: 26)
                        )
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Selamat datang",
                    style: superFont2.copyWith(color: white, fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  SizedBox(width: 22)
                ],
              ),
            )
          ),
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
                  SizedBox(height: 30),
                  _listBar(context),
                  SizedBox(height: 30),
                  _ringkasan(context),
                  SizedBox(height: 30),
                  _pemesanan(context),
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _listBar(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur jarak antar item
    children: [
      Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
              height: 46,
              width: 46, 
              child: SvgPicture.asset(
                "images/lapangan_icon.svg",
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Lapangan",
            // overflow: TextOverflow.ellipsis,
            style: superFont2.copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12)
          ),
        ],
      ),
      Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
              height: 46,
              width: 46,
              child: SvgPicture.asset(
                "images/calendar_icon.svg",
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Kalender",
            // overflow: TextOverflow.ellipsis,
            style: superFont2.copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12)
          ),
        ],
      ),
      Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
              height: 46,
              width: 46,
              child: SvgPicture.asset(
                "images/kompetisi_icon.svg",
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Kompetisi",
            // overflow: TextOverflow.ellipsis,
            style: superFont2.copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12)
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
              style: superFont2.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text( 
              "Aktivitas penyewaan 30 hari terakhir",
              style: superFont2.copyWith(color: tertiary, fontSize: 12, fontWeight: FontWeight.w400),
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
      )
    )
  );
}

Widget _ringkasanTransaksi(
    BuildContext context, {
    required String transactionMessage,
    required String transactionAmount,}) {

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
          offset: Offset(0, 4,),
        )
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          transactionMessage,
          style: superFont4.copyWith(color: Colors.black, fontWeight: FontWeight.w400)
        ),
        Text(
          transactionAmount,
          style: superFont2.copyWith(color: Colors.black, fontSize: 15),
        ),
        SizedBox(height: 14)
      ],
    ),
  );
}

Widget _pemesanan(BuildContext context){
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
            style: superFont2.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Text(
            "Lihat Semua",
            style: superFont2.copyWith(color: Colors.black, fontSize: 11, fontWeight: FontWeight.w400),
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