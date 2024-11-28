import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:arena_connect/config/theme.dart';

// ignore: must_be_immutable
class KalenderScreen extends StatelessWidget {
  KalenderScreen({super.key});

  List<DateTime?> selectedDatesFromCalendar = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildCalendarMonths(context),
          Expanded(
            child: _buildDailySchedule(context),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0XFF12215C),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Kalender',
        style: notifikasiStyle.copyWith(
          color: Colors.white,
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _buildCalendarMonths(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarType: CalendarDatePicker2Type.multi,
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
          selectedDayHighlightColor: const Color(0XFFA8E911),
          firstDayOfWeek: 1,
          weekdayLabelTextStyle: const TextStyle(
            color: Color(0XFF333333),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          selectedDayTextStyle: const TextStyle(
            color: Color(0XFF333333),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          dayTextStyle: const TextStyle(
            color: Color(0XFFE0E0E0),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          disabledDayTextStyle: const TextStyle(
            color: Color(0XFFE0E0E0),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          weekdayLabels: const [
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
    );
  }

  Widget _buildDailySchedule(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: const Text(
            "Kamis, 19 September 2024",
            style: TextStyle(
              color: Color(0XFF000000),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: 3,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildScheduleItem(context),
            ),
          ),
        ),
        _buildViewDetailButton(context),
      ],
    );
  }

  Widget _buildScheduleItem(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0X0C000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: const Color(0XFF12215C),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "10:00 - 11.00",
                      style: TextStyle(
                        color: Color(0XFF000000),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0XFF12215C),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "Lapangan Badminton 1",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "Azizah Salsa",
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewDetailButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0XFF489DD6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/kalenderdetail');
        },
        child: const Text(
          "Lihat Detail",
          style: TextStyle(
            color: Color(0XFFFFFFFF),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
