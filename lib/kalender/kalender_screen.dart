import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:arena_connect/config/theme.dart';
// import 'package:intl/intl.dart';

// ignore_for_file: must_be_immutable
class KalenderScreen extends StatelessWidget {
  KalenderScreen({Key? key})
      : super(
          key: key,
        );

  List<DateTime?> selectedDatesFromCalendar = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 28),
                  _buildCalendarMonths(context),
                  SizedBox(height: 12),
                  _buildDailySchedule(context)
                ],
              ),
            ),
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
      backgroundColor: Color(0XFF12215C),
      automaticallyImplyLeading: false, // Menghindari ikon back default
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Kalender',
        style: notifikasiStyle.copyWith(
          color: Colors.white, // Warna teks putih untuk konsistensi
        ),
      ),
      centerTitle: true, // Agar judul berada di tengah
    );
  }

  /// Section Widget
  Widget _buildCalendarMonths(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          SizedBox(
            height: 280,
            width: 336,
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.multi,
                firstDate: DateTime(DateTime.now().year - 5),
                lastDate: DateTime(DateTime.now().year + 5),
                selectedDayHighlightColor: Color(0XFFA8E911),
                firstDayOfWeek: 1,
                weekdayLabelTextStyle: TextStyle(
                  color: Color(0XFF333333),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
                selectedDayTextStyle: TextStyle(
                  color: Color(0XFF333333),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
                dayTextStyle: TextStyle(
                  color: Color(0XFFE0E0E0),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
                disabledDayTextStyle: TextStyle(
                  color: Color(0XFFE0E0E0),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
                weekdayLabels: [
                  "Sun",
                  "Mon",
                  "Tue",
                  "Wed",
                  "Thu",
                  "Fri",
                  "Sat"
                ],
              ),
              value: selectedDatesFromCalendar,
              onValueChanged: (dates) {},
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDailySchedule(BuildContext context) {
    return Container(
      height: 362,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
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
              3,
            ),
          )
        ],
      ),
      // child: Column(
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     Align(
      //       alignment: Alignment.centerLeft,
      //       child: Padding(
      //         padding: EdgeInsets.only(left: 12),
      //         child: Text(
      //           // Menggunakan DateFormat untuk menampilkan tanggal real-time
      //           DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(
      //               DateTime.now()), // Format hari, tanggal, bulan, tahun
      //           style: TextStyle(
      //             color: Color(0XFF000000),
      //             fontSize: 14,
      //             fontFamily: 'Poppins',
      //             fontWeight: FontWeight.w500,
      //           ),
      //         ),
      //       ),
      //     ),
      //     SizedBox(height: 16),
      //     Padding(
      //       padding: EdgeInsets.only(left: 4),
      //       child: ListView.separated(
      //         physics: NeverScrollableScrollPhysics(),
      //         shrinkWrap: true,
      //         separatorBuilder: (context, index) {
      //           return SizedBox(
      //             height: 16,
      //           );
      //         },
      //         itemCount: 3,
      //         itemBuilder: (context, index) {
      //           return KalenderThreeItemWidget();
      //         },
      //       ),
      //     ),
      //   Sizedbox(height: 34),
      //   Container(
      //     width: double
      //         .infinity, // Menggunakan double.infinity untuk lebar maksimal
      //     height: 42,
      //     margin: EdgeInsets.symmetric(
      //         horizontal: 72), // Mengatur margin horizontal
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         elevation: 0,
      //         backgroundColor:
      //             const Color(0XFF489DD6), // Gunakan warna konstanta
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(12), // Border radius 12
      //         ),
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: 30,
      //           vertical: 10,
      //         ),
      //       ),
      //       onPressed: () {
      //         Navigator.pushNamed(
      //             context, '/kalenderdetail'); // Navigasi ke halaman detail
      //       },
      //       child: const Text(
      //         "Lihat Detail",
      //         style: TextStyle(
      //           color: Color(0XFFFFFFFF),
      //           fontSize: 16,
      //           fontFamily: 'Inter',
      //           fontWeight: FontWeight.w700,
      //         ),
      //       ),
      //     ),
      //   ),

      //   ],

      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 12),
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
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16,
                );
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return KalenderThreeItemWidget();
              },
            ),
          ),
          SizedBox(height: 34),
          Container(
            width: double.maxFinite,
            height: 42,
            margin: EdgeInsets.symmetric(horizontal: 72),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Color(0XFF489DD6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                visualDensity: const VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/kalenderdetail');
              },
              child: Text(
                "Lihat Detail",
                style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class KalenderThreeItemWidget extends StatelessWidget {
  const KalenderThreeItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10,
            width: 10,
            margin: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Color(0XFF12215C),
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "10:00 - 11.00",
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
          SizedBox(width: 10),
          Expanded(
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: Color(0XFF12215C),
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Lapangan Badminton 1",
                    maxLines: null,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0XFFFFFFFF),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
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
}
