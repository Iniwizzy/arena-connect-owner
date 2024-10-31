import 'package:arena_connect/laporan_keuangan/lap_hari.dart';
import 'package:arena_connect/pembayaran/pembayaran.dart';
import 'package:arena_connect/profile/profile.dart';
import 'package:arena_connect/screens/homepage/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF12215C),
        scaffoldBackgroundColor: const Color(0xFF12215C),
      ),
      initialRoute: '/pesanan',
      routes: {
        '/home': (context) => const HomePage(),
        '/pesanan': (context) => const OrderListScreen(),
        '/pembayaran': (context) => const PaymentScreen(),
        '/laporankeuangan': (context) => const LaporanKeuanganScreen(),
        '/profil': (context) => const ProfilScreen(),
      },
      home: const OrderListScreen(),
    );
  }
}

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  List<Order> orders = [
    Order(
      name: 'Azizah Salsa',
      activity: 'Lapangan Badminton 1',
      date: '19/09/2024',
    ),
    Order(
      name: 'Budiman',
      activity: 'Lapangan Futsal 1',
      date: '19/09/2024',
    ),
    Order(
      name: 'Anggun Sri',
      activity: 'Lapangan Futsal 1',
      date: '19/09/2024',
    ),
    Order(
      name: 'Nurul hidayah',
      activity: 'Lapangan Badminton 1',
      date: '19/09/2024',
    ),
    Order(
      name: 'Kevin Sanjaya',
      activity: 'Lapangan Badminton 1',
      date: '18/09/2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12215C),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        title: const Text(
          'DAFTAR PESANAN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 16.0, right: 16.0),
                child: ListView.separated(
                  itemCount: orders.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16.0),
                  itemBuilder: (context, index) {
                    Order order = orders[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF12215C),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFE0E0E0),
                          child: Icon(
                            Icons.person,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                        title: Text(
                          order.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.activity,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                            Text(
                              order.date,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // Handle "Lihat Detail" button press
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                          ),
                          child: const Text(
                            'LIHAT DETAIL',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bottomNavItem(context, '/home', Icons.home, "Beranda", false),
          _bottomNavItem(context, '/pesanan', Icons.book, "Pesanan", true),
          _bottomNavItem(context, '/pembayaran', Icons.payments_sharp, "Transaksi", false),
          _bottomNavItem(context, '/laporankeuangan', Icons.bar_chart, "Laporan", false),
          _bottomNavItem(context, '/profil', Icons.person, "Profil", false),
        ],
      ),
    );
  }

  Widget _bottomNavItem(BuildContext context, String route, IconData icon,
      String label, bool isActive) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF0D2C76) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: isActive ? const Color(0xFF0D2C76) : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

class Order {
  final String name;
  final String activity;
  final String date;

  Order({
    required this.name,
    required this.activity,
    required this.date,
  });
}