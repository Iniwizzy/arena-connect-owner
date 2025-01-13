import 'package:arena_connect/customer/config/theme.dart';
import 'package:arena_connect/customer/screens/field-search/select_schedule.dart';
import 'package:arena_connect/customer/screens/history/history.dart';
import 'package:arena_connect/customer/screens/homepage/home.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/api/api.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class BuktiBookingLapangan extends StatefulWidget {
  final int paymentId;

  const BuktiBookingLapangan({super.key, required this.paymentId});

  @override
  _BuktiBookingLapanganState createState() => _BuktiBookingLapanganState();
}

class _BuktiBookingLapanganState extends State<BuktiBookingLapangan> {
  Map<String, dynamic>? paymentData;
  bool isLoading = true;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    fetchPaymentDetails();
  }

  Future<void> fetchPaymentDetails() async {
    try {
      final response = await ApiService().getPaymentDetails(widget.paymentId);
      if (response['success']) {
        setState(() {
          paymentData = response['data'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load payment details');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> downloadScreenshot() async {
    try {
      if (Platform.isAndroid) {
        var status = await Permission.manageExternalStorage.status;
        if (status.isDenied) {
          status = await Permission.manageExternalStorage.request();
          if (status.isDenied) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Silakan berikan izin penyimpanan di pengaturan aplikasi'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
            await Permission.manageExternalStorage.request();
            return;
          }
        }
      }

      Uint8List? image = await screenshotController.capture();
      if (image == null) throw 'Failed to capture screenshot';

      final now = DateFormat('ddMMyyyy_HHmmss').format(DateTime.now());
      final orderId = paymentData?['order_id'] ?? 'unknown';
      final directory = Directory('/storage/emulated/0/DCIM/Downloads');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      final filePath = '${directory.path}/bukti_booking_${orderId}_$now.png';
      await File(filePath).writeAsBytes(image);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bukti booking berhasil diunduh'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengunduh bukti booking: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
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
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 40),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/homepage');
                            },
                            icon: const Icon(Icons.arrow_back),
                            color: white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 46),
                          child: Text('Bukti Booking Lapangan',
                              style: superFont1.copyWith(color: white)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Screenshot(
                            controller: screenshotController,
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Bukti',
                                              style: superFont2,
                                            ),
                                            Text(
                                              DateFormat('EEEE, d MMMM yyyy',
                                                          'id_ID')
                                                      .format(DateTime.parse(
                                                          "${paymentData?['booking']['date']}")) ??
                                                  "",
                                              style: superFont3,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        CustomPaint(
                                          painter: DashedLinePainter(
                                              color: Colors.grey.shade400),
                                          size: Size(
                                              MediaQuery.of(context).size.width,
                                              0.5),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Order ID:',
                                              style: regulerFont1,
                                            ),
                                            Text(
                                              paymentData?['order_id'] ?? '',
                                              style: regulerFont1,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Metode Pembayaran:',
                                              style: regulerFont1,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${paymentData?['bank']['bank_name'] ?? ''} - ${paymentData?['bank']['account_number'] ?? ''}',
                                              style: regulerFont1,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Rincian:',
                                          style: superFont2,
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.event, color: primary),
                                            const SizedBox(width: 8),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Pelaksanaan',
                                                  style: superFont3,
                                                ),
                                                const SizedBox(height: 18),
                                                Text(
                                                  'Nama GOR: ${paymentData?['field']['field_centre']['name'] ?? ''}',
                                                  style: regulerFont1.copyWith(
                                                      color: secondary),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  'Lapangan: ${paymentData?['field']['name'] ?? ''}',
                                                  style: regulerFont1.copyWith(
                                                      color: secondary),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  'Tanggal: ${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(paymentData?['booking']['date'])) ?? ''}',
                                                  style: regulerFont1.copyWith(
                                                      color: secondary),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  'Booking dimulai: ${paymentData?['booking']['booking_start'].substring(0, 5)} - ${paymentData?['booking']['booking_end'].substring(0, 5)}',
                                                  style: regulerFont1.copyWith(
                                                      color: secondary),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  'Booking atas nama: ${paymentData?['user']['name']}',
                                                  style: regulerFont1.copyWith(
                                                      color: secondary),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                style: shortButton2,
                                onPressed: downloadScreenshot,
                                icon: const Icon(
                                  Icons.file_download_outlined,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Unduh Bukti Booking',
                                  style: buttonFont4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
