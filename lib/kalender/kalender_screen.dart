import 'package:arena_connect/api/api.dart';
import 'package:arena_connect/model/res_payments.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:arena_connect/config/theme.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class KalenderScreen extends StatefulWidget {
  KalenderScreen({super.key});

  @override
  State<KalenderScreen> createState() => _KalenderScreenState();
}

class _KalenderScreenState extends State<KalenderScreen> {
  bool isLoading = false;
  List<Payment> listBooking = [];
  List<Payment> filteredBooking = [];
  List<DateTime?> selectedDatesFromCalendar = [];

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
      List<Payment>? data = resFieldFromJson(res.body).data;
      setState(() {
        isLoading = false;
        listBooking = data ?? [];
        filteredBooking = listBooking;
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

  @override
  void initState() {
    super.initState();
    getField();
  }

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
    final List<Payment> filteredBookings = filteredBooking
        .where((payment) => payment.status.toLowerCase() == "selesai")
        .toList();
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
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Color(0x0D000000),
              //     blurRadius: 4,
              //     offset: Offset(0, 2),
              //   ),
              // ],
            ),
            // margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredBookings.length,
              itemBuilder: (context, index) {
                final pesanan = filteredBookings[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildScheduleItem(pesanan),
                );
              },
            ),
          ),
        ),
        // Expanded(
        //   child: ListView.builder(
        //       itemCount: filteredBookings.length,
        //       itemBuilder: (
        //         context,
        //         index,
        //       ) {
        //         final pesanan = filteredBookings[index];
        //         return Padding(
        //           padding: const EdgeInsets.only(bottom: 16),
        //           child: _buildScheduleItem(pesanan),
        //         );
        //       }),
        // ),
        // Expanded(
        //   child: filteredBooking.isEmpty
        //       ? const Center(
        //           child: Text(
        //             'Tidak ada data booking',
        //             style: TextStyle(
        //               fontFamily: 'Poppins',
        //               fontSize: 14,
        //             ),
        //           ),
        //         )
        //       : ListView(
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        //           children: [
        //             Container(
        //               margin: const EdgeInsets.only(bottom: 12),
        //               child: _buildScheduleItem(context),
        //             ),
        //           ],
        //         ),
        // ),
        _buildViewDetailButton(context),
      ],
    );
  }

  Widget _buildScheduleItem(Payment pesanan) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Dot indicator
          Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: const Color(0XFF12215C),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 12),

          // Time and Name - Use Expanded to prevent overflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${pesanan.booking?.bookingStart ?? '-'} - ${pesanan.booking?.bookingEnd ?? '-'}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pesanan.user?.name ?? 'Nama tidak tersedia',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Field name badge - with constrained width
          const SizedBox(width: 8),
          Container(
            constraints: const BoxConstraints(
                maxWidth: 120), // Adjust this value as needed
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0XFF12215C),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              pesanan.field?.name ?? 'Nama tidak tersedia',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 7,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    // return Container(
    //   padding: const EdgeInsets.all(16),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(8),
    //     boxShadow: const [
    //       BoxShadow(
    //         color: Color(0X0C000000),
    //         blurRadius: 4,
    //         offset: Offset(0, 2),
    //       ),
    //     ],
    //   ),
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Row(
    //         children: [
    //           Container(
    //             height: 12,
    //             width: 12,
    //             decoration: BoxDecoration(
    //               color: const Color(0XFF12215C),
    //               borderRadius: BorderRadius.circular(6),
    //             ),
    //           ),
    //           const SizedBox(width: 12),
    //         ],
    //       ),
    //       const SizedBox(height: 16),
    //       if (filteredBookingSelesai.isEmpty)
    //         const Text(
    //           'Tidak ada booking yang selesai',
    //           style: TextStyle(
    //             fontFamily: 'Poppins',
    //             fontSize: 14,
    //           ),
    //         )
    //       else
    //         SizedBox(
    //           height: MediaQuery.of(context).size.height *
    //               0.5, // Sesuaikan tinggi sesuai kebutuhan
    //           child: SingleChildScrollView(
    //             child: Column(
    //               children: List.generate(
    //                 filteredBookingSelesai.length,
    //                 (index) {
    //                   final pesanan = filteredBookingSelesai[index];
    //                   return Padding(
    //                     padding: EdgeInsets.only(
    //                       bottom: index != filteredBookingSelesai.length - 1
    //                           ? 16.0
    //                           : 0,
    //                     ),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Text(
    //                               '${pesanan.booking?.bookingStart ?? '-'} - ${pesanan.booking?.bookingEnd ?? '-'}',
    //                               style: const TextStyle(
    //                                 color: Color(0XFF000000),
    //                                 fontSize: 14,
    //                                 fontFamily: 'Poppins',
    //                                 fontWeight: FontWeight.w500,
    //                               ),
    //                             ),
    //                             Container(
    //                               padding: const EdgeInsets.symmetric(
    //                                 horizontal: 12,
    //                                 vertical: 4,
    //                               ),
    //                               decoration: BoxDecoration(
    //                                 color: const Color(0XFF12215C),
    //                                 borderRadius: BorderRadius.circular(4),
    //                               ),
    //                               child: Text(
    //                                 pesanan.field?.name ??
    //                                     'Nama tidak tersedia',
    //                                 style: const TextStyle(
    //                                   color: Colors.white,
    //                                   fontSize: 12,
    //                                   fontFamily: 'Poppins',
    //                                   fontWeight: FontWeight.w400,
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         const SizedBox(height: 4),
    //                         Text(
    //                           pesanan.user?.name ?? 'Nama tidak tersedia',
    //                           style: const TextStyle(
    //                             color: Color(0XFF000000),
    //                             fontSize: 14,
    //                             fontFamily: 'Poppins',
    //                             fontWeight: FontWeight.w400,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //           ),
    //         ),
    //     ],
    //   ),
    // );
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
