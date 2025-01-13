import 'package:flutter/material.dart';
import 'package:arena_connect/customer/config/theme.dart';
import 'package:intl/intl.dart';

class HistoryDetail extends StatefulWidget {
  final dynamic payment;
  const HistoryDetail({super.key, required this.payment});

  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  int _rating = 0;
  int _currentIndex = 1;

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Terima Kasih!',
            style: superFont2,
          ),
          content: Text(
            'Terima kasih atas rating Anda!',
            style: superFont4,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Tutup',
                style: superFont4.copyWith(color: primary),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStar(int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          _rating = index;
        });
        _showThankYouDialog();
      },
      icon: Icon(
        index <= _rating ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 40,
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final payment = widget.payment;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History Pembayaran',
          style: superFont1.copyWith(color: Colors.white),
        ),
        backgroundColor: primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    payment['field']['field_centre']['name'],
                    style: superFont1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    payment['field']['name'],
                    style: superFont3.copyWith(color: primary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 8),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   children: [
                          //     Icon(Icons.scoreboard_outlined, color: primary),
                          //     const SizedBox(width: 10),
                          //     Text(
                          //       payment['field']['name'],
                          //       style: superFont3,
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.receipt_long_outlined, color: primary),
                              const SizedBox(width: 10),
                              Text(
                                'Order ID: ${payment['order_id']}',
                                style: superFont3,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.calendar_month_outlined,
                                  color: primary),
                              const SizedBox(width: 10),
                              Text(
                                '${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(payment['booking']['date']))}\n' +
                                    payment['booking']['booking_start']
                                        .substring(0, 5) +
                                    ' - ' +
                                    payment['booking']['booking_end']
                                        .substring(0, 5),
                                style: superFont4,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: primary),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  payment['field']['field_centre']['address'],
                                  style: superFont4,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.monetization_on_outlined,
                                  color: primary),
                              const SizedBox(width: 10),
                              Text(
                                'Biaya: Rp${NumberFormat.decimalPattern('id').format(double.parse(payment['total_payment']))}',
                                style: superFont4,
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.loop, color: primary),
                              const SizedBox(width: 10),
                              Text(
                                'Status: ${payment['status']}',
                                style: superFont4,
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.account_circle_outlined,
                                  color: primary),
                              const SizedBox(width: 10),
                              Text(
                                'Dibooking oleh: ${payment['user']['name']}',
                                style: superFont4,
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.account_balance_wallet_outlined,
                                  color: primary),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Metode Pembayaran: ${payment['bank']['bank_name']} - ${payment['bank']['account_number']}',
                                  style: superFont4,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Bagaimana Pengalamanmu?',
                    style: superFont1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        List.generate(5, (index) => _buildStar(index + 1)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
