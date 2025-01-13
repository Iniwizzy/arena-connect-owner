import 'package:arena_connect/api/api.dart';
import 'package:arena_connect/customer/models/booking.dart';
import 'package:arena_connect/customer/models/res_bank.dart';
import 'package:arena_connect/customer/screens/booking/booking_page.dart';
import 'package:arena_connect/customer/screens/booking/detail_pembayaran.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/customer/config/theme.dart';
import 'package:arena_connect/customer/screens/field-search/select_schedule.dart';

class Pembayaran extends StatefulWidget {
  final int paymentId;
  final int totalPayment;
  final BookingData bookingData;
  final String orderId;

  const Pembayaran({
    super.key,
    required this.paymentId,
    required this.totalPayment,
    required this.bookingData,
    required this.orderId,
  });

  @override
  State<Pembayaran> createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  String? bayar;
  List<Bank> banks = [];
  int? selectedBankId;

  @override
  void initState() {
    super.initState();
    fetchBanks();
  }

  Future<void> fetchBanks() async {
    final response = await ApiService()
        .getBanksByFieldCentreId(widget.bookingData.field!.fieldCentreId);
    if (response['success']) {
      setState(() {
        banks = (response['data'] as List)
            .map((bank) => Bank.fromJson(bank))
            .toList();
      });

      debugPrint(response['data'].toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load banks: ${response['errors']}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Metode Pembayaran: $bayar"),
      duration: const Duration(seconds: 1),
    ));
  }

  void _onBankSelected(int bankId) {
    setState(() {
      selectedBankId = bankId;
      debugPrint('Metode pembayaran dipilih: $selectedBankId');
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BookingPage(bookingId: widget.bookingData.id),
                        ),
                      );
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
                            Icons.calendar_month_outlined, "Pilih Jadwal"),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Pembayaran",
                        style: regulerFont7,
                      ),
                      Text(
                        "Rp${widget.totalPayment}",
                        style: superFont2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 303,
            left: 45,
            child: Row(
              children: [
                Text(
                  "Metode Pembayaran",
                  style: superFont4,
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Positioned(
            top: 300,
            left: 8,
            right: 8,
            child: FractionallySizedBox(
              widthFactor: 0.95,
              child: Container(
                height: 200,
                child: ListView.builder(
                  itemCount: banks.length,
                  itemBuilder: (context, index) {
                    final bank = banks[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                const SizedBox(width: 18),
                                // Replace with dynamic image if available
                                // Image.asset(
                                //   'images/${bank.bankName.toLowerCase()}.png',
                                //   width: 48,
                                //   height: 48,
                                // ),
                                const SizedBox(width: 23),
                                Text(
                                  '${bank.bankName} - ${bank.accountNumber}',
                                  style: superFont3,
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Radio<int>(
                                value: bank.id,
                                groupValue: selectedBankId,
                                activeColor: const Color(0xFF12215c),
                                onChanged: (int? value) {
                                  if (value != null) {
                                    _onBankSelected(value);
                                  }
                                  bayar = bank.bankName;
                                  showSnackbar();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 257,
                      height: 34,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (selectedBankId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Pilih metode pembayaran dulu, dong 😅'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 1),
                              ),
                            );
                            return;
                          }

                          debugPrint(
                              'ID Pembayaran yang Dipilih: ${selectedBankId!.toInt()}');

                          var response = await ApiService().updatePayment(
                            paymentId: widget.paymentId,
                            userId: widget.bookingData.userId,
                            bookingId: widget.bookingData.id,
                            totalPayment: widget.totalPayment.toString(),
                            status: 'Proses',
                            orderId: widget.orderId,
                            bankId: selectedBankId!.toInt(),
                          );

                          if (response['success']) {
                            debugPrint(
                                'Pembayaran berhasil diperbarui!! ${response['data']}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pembayaran berhasil diperbarui'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  paymentId: widget.paymentId,
                                  totalPayment: widget.totalPayment,
                                  bookingData: widget.bookingData,
                                  orderId: widget.orderId,
                                  bankId: selectedBankId!,
                                  banks: banks,
                                ),
                              ),
                            );
                          } else {
                            debugPrint(
                                'Gagal memperbarui pembayaran :( ${response['errors']}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Gagal memperbarui pembayaran: ${response['errors']}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: longButton1,
                        child: Text(
                          "Bayar",
                          style: buttonFont3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
