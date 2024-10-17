import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KalenderDetailJadwalScreen extends StatelessWidget {
  const KalenderDetailJadwalScreen({Key? key})
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
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildAppBar(context),
              _buildCourtSelection(context),
              SizedBox(height: 12),
              Expanded(
                child: Container(
                  width: 332,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Text(
                          "Kamis, 19 September 2024",
                          style: TextStyle(
                            color: Color(0XFF000000),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 14),
                      _buildScheduleList(context)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 74,
      backgroundColor: Colors.blue[900],
      automaticallyImplyLeading: false,
      leadingWidth: 29,
      leading: Padding(
        padding: EdgeInsets.only(left: 21),
        child: SizedBox(
          height: 16,
          width: 8,
          child: SvgPicture.asset(
            "assets/images/img_arrow_left.svg",
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 26),
        child: Text(
          "Detail Jadwal",
          style: TextStyle(
            color: Color(0XFFFFFFFF),
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCourtSelection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(
        left: 20,
        top: 16,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0X0C000000),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              3,
            ),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            height: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Color(0XFF12215C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                ),
                visualDensity: const VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                padding: EdgeInsets.only(left: 10),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Lapangan badminton 1",
                    style: TextStyle(
                      color: Color(0XFFFFFFFF),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: SvgPicture.asset(
                      "assets/images/img_mynauiarrowupdown.svg",
                      height: 16,
                      width: 16,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildScheduleList(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 14,
          );
        },
        itemCount: 14,
        itemBuilder: (context, index) {
          return SchedulelistItemWidget();
        },
      ),
    );
  }
}

class SchedulelistItemWidget extends StatelessWidget {
  const SchedulelistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  width: 10,
                  margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: Color(0XFFEB0707),
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "07:00 - 08.00",
                            style: TextStyle(
                              color: Color(0XFF000000),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "Azizah Salsa",
                            style: TextStyle(
                              color: Color(0XFF000000),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Color(0XFF12215C),
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          child: Text(
            "Lapangan Badminton 1",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0XFFFFFFFF),
              fontSize: 11,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}
