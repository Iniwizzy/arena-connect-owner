import 'package:arena_connect/customer/config/theme.dart';
import 'package:arena_connect/customer/screens/history/history_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:arena_connect/api/api.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<dynamic> payments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPayments();
    initializeDateFormatting('id_ID', null);
  }

  Future<void> fetchPayments() async {
    final response = await ApiService().getPaymentsByUser();
    if (response['success']) {
      setState(() {
        payments = response['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle error
      print(response['errors']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: const Color(0xFF12215C),
        title: Padding(
          padding: const EdgeInsets.only(top: 35, left: 15),
          child: Text('History Pembayaran',
              style: superFont1.copyWith(color: Colors.white)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : payments.isEmpty
              ? Center(
                  child:
                      Text('Belum ada history pembayaran', style: superFont3),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemCount: payments.length,
                    itemBuilder: (context, index) {
                      final payment = payments[index];
                      return buildPaymentCard(context, payment);
                    },
                  ),
                ),
    );
  }

  Widget buildPaymentCard(BuildContext context, dynamic payment) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoryDetail(payment: payment),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF12215C), width: 2.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFF12215C),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    payment['field']['field_centre']['name'],
                    style: superFont3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 20),
                const Icon(Icons.sports_soccer,
                    size: 18, color: Color(0xFF12215C)),
                const SizedBox(width: 6),
                Text(payment['field']['name'], style: superFont4),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 20),
                const Icon(Icons.receipt_long_outlined,
                    size: 18, color: Color(0xFF12215C)),
                const SizedBox(width: 6),
                Text(payment['order_id'], style: superFont4),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 20),
                const Icon(Icons.calendar_today,
                    size: 18, color: Color(0xFF12215C)),
                const SizedBox(width: 6),
                Text(
                    DateFormat('EEEE, d MMMM yyyy', 'id_ID')
                        .format(DateTime.parse(payment['booking']['date'])),
                    style: superFont4),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Color(0xFF12215C),
                ),
                const SizedBox(width: 6),
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
            const SizedBox(height: 2),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.arrow_forward_ios,
                    size: 15, color: Color(0xFF12215C)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
