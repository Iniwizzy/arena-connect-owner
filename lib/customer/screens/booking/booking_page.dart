import 'package:arena_connect/api/api.dart';
import 'package:arena_connect/customer/models/booking.dart';
import 'package:arena_connect/customer/screens/booking/pembayaran.dart';
import 'package:arena_connect/customer/screens/homepage/home.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/customer/config/theme.dart';
import 'package:arena_connect/customer/screens/field-search/select_schedule.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  final int bookingId;
  const BookingPage({super.key, required this.bookingId});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late Future<Booking> booking;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    booking = ApiService().getBooking(widget.bookingId);
  }

  Widget buildCircleIcon(IconData icon, String label,
      {Color? backgroundColor, Color? iconColor = Colors.white}) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? const Color(0xFF12215c),
        ),
        child: Icon(
          icon,
          color: iconColor ?? Colors.white,
          size: 28,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: buttonFont6,
      ),
    ]);
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  void _showConfirmationModal(BuildContext context, BookingData bookingData) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Konfirmasi Pembayaran', style: superFont2),
          content: Text(
            'Apakah Anda yakin ingin melakukan pembayaran ini?',
            style: regulerFont2,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              style: shortButton2,
              child: Text('Batal', style: buttonFont4),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                String orderId =
                    DateTime.now().millisecondsSinceEpoch.toString() +
                        bookingData.userId.toString();
                var response = await ApiService().createPayment(
                  userId: bookingData.userId,
                  bookingId: bookingData.id,
                  totalPayment: bookingData.cost,
                  status: 'Belum',
                  orderId: orderId,
                );

                debugPrint('Response: $response');
                debugPrint('response success: ${response['success']}');

                if (response['success']) {
                  debugPrint('Payment created: ${response['data']}');
                  debugPrint('Payment ID: ${response['data']['id']}');

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pembayaran(
                        paymentId: response['data']['id'],
                        totalPayment:
                            int.parse(response['data']['total_payment']),
                        bookingData: bookingData,
                        orderId: orderId,
                      ),
                    ),
                  );
                } else {
                  debugPrint(
                    'Failed to create payment: ${response['errors']}',
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Gagal melakukan pembayaran: ${response['errors']}',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: shortButtonPrimary2,
              child: Text('Konfirmasi', style: buttonFont4),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Booking>(
        future: booking,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          } else {
            final bookingData = snapshot.data!.data;
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'images/top-wave-cropped.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => SelectSchedule(
                            //       fieldCentreId:
                            //           bookingData.field?.fieldCentre?.id ?? 1,
                            //     ),
                            //   ),
                            // );
                          },
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 40),
                              child: buildCircleIcon(
                                  Icons.calendar_month_outlined,
                                  "Pilih Jadwal"),
                            ),
                          ],
                        ),
                        Expanded(
                          child: CustomPaint(
                            painter: DashedLinePainter(),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(0),
                              child: buildCircleIcon(
                                Icons.list_alt_rounded,
                                "Detail Booking",
                                backgroundColor: Colors.white,
                                iconColor: const Color(0xFF12215c),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: CustomPaint(
                            painter: DashedLinePainter(),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 40),
                              child: buildCircleIcon(
                                  Icons.payments_outlined, "Pembayaran"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Positioned(
                  top: 200,
                  left: 8,
                  right: 8,
                  child: FractionallySizedBox(
                    widthFactor: 0.95,
                    child: Container(
                      height: 78,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bookingData.field?.fieldCentre?.name ??
                                  'Pusat Lapangan',
                              style: superFont2.copyWith(
                                color: const Color(0xFF12215c),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color(0xFFFFD233),
                                  size: 20,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  bookingData.field?.fieldCentre?.rating
                                          .toString() ??
                                      '4.5',
                                  style: superFont3,
                                ),
                                const SizedBox(width: 7),
                                Container(
                                  width: 3,
                                  height: 3,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF12215c),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  bookingData.field?.fieldCentre?.address ??
                                      'Alamat Pusat Lapangan',
                                  style: regulerFont4,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 295,
                  left: 8,
                  right: 8,
                  child: FractionallySizedBox(
                    widthFactor: 0.95,
                    child: Container(
                      height: 145,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Jadwal Booking",
                                  style: superFont2,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      bookingData.field?.name ??
                                          'Nama Lapangan',
                                      style: superFont6,
                                    ),
                                    const SizedBox(width: 7),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Container(
                                        width: 3,
                                        height: 3,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF12215c),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 7),
                                    Text(
                                      bookingData.field?.type ??
                                          'Tipe Lapangan',
                                      style: superFont6,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      DateFormat('EEEE, d MMMM yyyy', 'id_ID')
                                          .format(
                                              DateTime.parse(bookingData.date)),
                                      style: regulerFont4,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xFF12215c),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 95,
                            left: 40,
                            child: Text(
                              "${bookingData.bookingStart} - ${bookingData.bookingEnd}",
                              style: regulerFont3,
                            ),
                          ),
                          Positioned(
                            top: 95,
                            right: 40,
                            child: Text(
                              "Rp${bookingData.cost}",
                              style: regulerFont3,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 460,
                  left: 8,
                  right: 8,
                  child: FractionallySizedBox(
                    widthFactor: 0.95,
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Detail Pemesanan",
                              style: superFont2,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: List.generate(
                                40,
                                (index) {
                                  return Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 4,
                                          height: 1,
                                          color: const Color(0xFFA7ADC3),
                                        ),
                                        const SizedBox(width: 2),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Biaya Sewa",
                                  style: regulerFont1,
                                ),
                                Text(
                                  "Rp${bookingData.cost}",
                                  style: regulerFont1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 1,
                              color: const Color(0xFFA7ADC3),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: superFont4,
                                ),
                                Text(
                                  "Rp${bookingData.cost}",
                                  style: superFont4,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: (4.0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mulai",
                                style: regulerFont9,
                              ),
                              Text(
                                "Rp${bookingData.cost}",
                                style: superFont2,
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showConfirmationModal(context, bookingData);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF489DD6),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              "Pilih Pembayaran",
                              style: buttonFont3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
