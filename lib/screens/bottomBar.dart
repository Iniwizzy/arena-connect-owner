import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:arena_connect/config/theme.dart';

class Nav extends StatelessWidget {
  const Nav({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF),
        body: Container(
          width: double.infinity,
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              _buildIconRow(),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildIconRow() {
    return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur jarak antar item
    children: [
      Column(
        children: [
          SizedBox(
              height: 18,
              width: 20, 
              child: SvgPicture.asset(
                "images/home_icon.svg",
              ),
          ),
          SizedBox(height: 3),
          Text(
            "Beranda",
            style: superFont2.copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 9)
          ),
        ],
      ),
      Column(
        children: [
          SizedBox(
              height: 18,
              width: 18,
              child: SvgPicture.asset(
                "images/pemesanan_icon.svg",
              ),
          ),
          SizedBox(height: 3),
          Text(
            "Pemesanan",
            // overflow: TextOverflow.ellipsis,
            style: superFont2.copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 9)
          ),
        ],
      ),
      Column(
        children: [
          SizedBox(
              height: 18,
              width: 20,
              child: SvgPicture.asset(
                "images/pembayaran_icon.svg",
              ),
          ),
          SizedBox(height: 6),
          Text(
            "Pembayaran",
            // overflow: TextOverflow.ellipsis,
            style: superFont2.copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 9)
          ),
        ],
      ),
      Column(
        children: [
          SizedBox(
              height: 18,
              width: 20,
              child: SvgPicture.asset(
                "images/laporan_icon.svg",
              ),
          ),
          SizedBox(height: 3),
          Text(
            "Laporan",
            // overflow: TextOverflow.ellipsis,
            style: superFont2.copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 9)
          ),
        ],
      ),
      Column(
        children: [
          SizedBox(
              height: 18,
              width: 20,
              child: SvgPicture.asset(
                "images/profil_icon.svg",
              ),
          ),
          SizedBox(height: 3),
          Text(
            "Profil",
            // overflow: TextOverflow.ellipsis,
            style: superFont2.copyWith(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 9)
          ),
        ],
      ),
    ],
  );
  }
}
  
