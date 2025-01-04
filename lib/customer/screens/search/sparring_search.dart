import 'package:arena_connect/customer/config/theme.dart';
import 'package:flutter/material.dart';

class SparringSearch extends StatefulWidget {
  const SparringSearch({Key? key}) : super(key: key);

  @override
  State<SparringSearch> createState() => _SparringSearchState();
}

class _SparringSearchState extends State<SparringSearch>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/homepage");
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          labelStyle: superFont3,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: "Sparing"),
            Tab(text: "Kompetisi"),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                hintText: 'Cari...',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                SparingTab(),
                KompetisiTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SparingTab extends StatelessWidget {
  const SparingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('images/futsal.jpg'),
          ),
          title: Text('Lapangan Arena', style: superFont4),
          subtitle: Text('Futsal', style: regulerFont7),
        ),
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('images/futsal.jpg'),
          ),
          title: Text('Lapangan Arena', style: superFont4),
          subtitle: Text('Futsal', style: regulerFont7),
        ),
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('images/badminton.jpg'),
          ),
          title: Text('Lapangan Arena', style: superFont4),
          subtitle: Text('Badminton', style: regulerFont7),
        ),
      ],
    );
  }
}

class KompetisiTab extends StatelessWidget {
  const KompetisiTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // First card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      'images/futsal1.jpg',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kota Semarang',
                          style: regulerFont7,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'SEMARANG CUP',
                          style: superFont1,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      color: Colors.white, size: 18),
                                  const SizedBox(width: 5),
                                  Text(
                                    '6 Desember 2024',
                                    style: buttonFont4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.sports_soccer,
                                      color: Colors.white, size: 18),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Futsal',
                                    style: buttonFont4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Second card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      'images/footballcup1.jpg',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kota Semarang',
                          style: regulerFont7,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'SEMARANG CUP',
                          style: superFont1,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      color: Colors.white, size: 18),
                                  const SizedBox(width: 5),
                                  Text(
                                    '6 Desember 2024',
                                    style: buttonFont4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.sports_soccer,
                                      color: Colors.white, size: 18),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Futsal',
                                    style: buttonFont4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Third card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      'images/badmintoncup.jpg',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kota Semarang',
                          style: regulerFont7,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'SEMARANG CUP',
                          style: superFont1,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      color: Colors.white, size: 18),
                                  const SizedBox(width: 5),
                                  Text(
                                    '6 Desember 2024',
                                    style: buttonFont4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.sports_tennis,
                                      color: Colors.white, size: 18),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Badminton',
                                    style: buttonFont4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
