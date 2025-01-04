import 'package:arena_connect/customer/config/theme.dart';
import 'package:arena_connect/customer/screens/history/history_detail.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  buildSimpleCard(
                    context: context,
                    title: "GOR DIPONEGORO ",
                    icon: Icons.sports_soccer,
                    level: "Futsal",
                    dateTime: "Min, 23 Sep 2024, 08.00-09.00",
                    location: "Lapangan Badminton 2A Diponegoro",
                  ),
                  const SizedBox(height: 16),
                  buildSimpleCard(
                    context: context,
                    title: "GOR LOMBA TRI JUANG ",
                    icon: Icons.sports_tennis,
                    level: "Badminton",
                    dateTime: "Jum, 5 Dec 2024, 09.00-10.00",
                    location: "Lapangan Lomba Tri juang 2A",
                    navigateToDetails: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSimpleCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String level,
    required String dateTime,
    required String location,
    bool navigateToDetails = false,
  }) {
    return InkWell(
      onTap: navigateToDetails
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryDetail(),
                ),
              );
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(20),
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
                    title,
                    style: superFont3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 20),
                Icon(icon, size: 18, color: const Color(0xFF12215C)),
                const SizedBox(width: 6),
                Text(level, style: superFont4),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 20),
                const Icon(Icons.calendar_today,
                    size: 18, color: Color(0xFF12215C)),
                const SizedBox(width: 6),
                Text(dateTime, style: superFont4),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 20),
                const Icon(Icons.location_on_outlined,
                    size: 18, color: Color(0xFF12215C)),
                const SizedBox(width: 6),
                Text(location, style: superFont4),
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
