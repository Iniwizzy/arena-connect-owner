import 'package:arena_connect/customer/config/theme.dart';
import 'package:flutter/material.dart';

class BuktiJoinSparring extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: AppBar(
          backgroundColor: primary,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Bukti Booking Lapangan',
                    style: superFont1.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bukti',
                              style: superFont2,
                            ),
                            Text(
                              '1 September 2024',
                              style: superFont2,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            int itemCount = (constraints.maxWidth / 10).floor();
                            return Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(itemCount, (index) {
                                  return Container(
                                    width: 8,
                                    height: 1,
                                    color: Colors.grey,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                  );
                                }),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order ID',
                              style: regulerFont2,
                            ),
                            Text(
                              'XXXXXX',
                              style: regulerFont2,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Rincian',
                          style: superFont1,
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.event, color: primary),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pelaksanaan',
                                      style: superFont3,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Lapangan 1',
                                      style: regulerFont1.copyWith(
                                          color: secondary),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Senin, 1 September 2024',
                                      style: regulerFont1.copyWith(
                                          color: secondary),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Sparring dimulai 07:00 - 08:00',
                                      style: regulerFont1.copyWith(
                                          color: secondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.accessibility_new, color: primary),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Posisi Main',
                                      style: superFont3,
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Pemain\nLapangan',
                                          style: regulerFont1.copyWith(
                                              color: secondary),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(width: 8),
                                        Container(
                                          width: 140,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            'Yuda12',
                                            style: regulerFont1.copyWith(
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
            SizedBox(height: 32),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Aksi ketika tombol ditekan
                  },
                  icon: Icon(Icons.download, color: Colors.white),
                  label: Text(
                    'Unduh Bukti Booking',
                    style: superFont3.copyWith(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                    backgroundColor: secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
