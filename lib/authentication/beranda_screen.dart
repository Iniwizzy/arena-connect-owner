import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BerandaScreen extends StatelessWidget {
  const BerandaScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildHeaderSection(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(
                      left: 32,
                      top: 34,
                      right: 32,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNavigationList(context),
                        SizedBox(height: 38),
                        _buildActivitySummary(context),
                        SizedBox(height: 38),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 74,
                            width: 233,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF12215C),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
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
                        SizedBox(height: 96)
                      ],
                    ),
                  ),
                ),
              )
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
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
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
                  padding: EdgeInsets.only(left: 14),
                  child: Image.asset(
                    "images/img_logopng2_1.png",
                    height: 26,
                    width: 70,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 22),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: SizedBox(
                          height: 21,
                          width: 57,
                          child: Image.asset(
                            "images/img_search.png",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
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
          SizedBox(height: 36),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 32),
            padding: EdgeInsets.only(left: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
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
                Text(
                  "Selamat datang",
                  style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildNavigationList(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22),
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 36,
          children: List.generate(
            1,
            (index) {
              return NavigationlistItemWidget();
            },
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildActivitySummary(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ringkasan Aktivitas",
            style: TextStyle(
              color: Color(0XFF000000),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Aktivitas penyewaan 30 hari terakhir",
            style: TextStyle(
              color: Color(0XFFA7ADC3),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4),
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
                SizedBox(width: 16),
                Expanded(
                  child: _buildTransactionSummary(
                    context,
                    transactionMessage: "Transaksi Berhasil",
                    transactionAmount: "0",
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
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
                Spacer(),
                Text(
                  "Lihat Semua",
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 6,
                    top: 4,
                  ),
                  child: SizedBox(
                    height: 12,
                    width: 8,
                    child: SvgPicture.asset(
                      "images/img_vector_12x6.svg",
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigation(BuildContext context) {
    return SizedBox(
      height: 64,
      width: double.maxFinite,
      child: SizedBox(),
    );
  }

  /// Common widget
  Widget _buildTransactionSummary(
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
        borderRadius: BorderRadius.circular(
          6,
        ),
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
          Text(
            transactionMessage,
            style: TextStyle(
              color: Color(0XFF000000),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            transactionAmount,
            style: TextStyle(
              color: Color(0XFF000000),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14)
        ],
      ),
    );
  }
}

class NavigationlistItemWidget extends StatelessWidget {
  const NavigationlistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: SizedBox(
              height: 46,
              width: double.maxFinite,
              child: SvgPicture.asset(
                "images/img_daftar_lapangan.svg",
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Lapangan",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0XFF000000),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
