import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OrderListScreen(),
    );
  }
}

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  int _selectedIndex = 1;

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

  Widget _bottomNavItem(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {
        // Handle navigation here
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12215C),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
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
                padding:
                    const EdgeInsets.only(top: 20, left: 16.0, right: 16.0),
                child: ListView.separated(
                  itemCount: orders.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16.0),
                  itemBuilder: (context, index) {
                    Order order = orders[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF12215C),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.person,
                            color: Colors.grey[600],
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
      bottomNavigationBar: _BottomNavigation(context),
    );
  }
}

Widget _BottomNavigation(BuildContext context) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 10), // Padding vertikal
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _bottomNavItem(context, '/home', Icons.home, "Beranda", false),
        _bottomNavItem(context, '/pesanan', Icons.book, "Pesanan", true),
        _bottomNavItem(
            context, '/pembayaran', Icons.payments_sharp, "Transaksi", false),
        _bottomNavItem(
            context, '/laporankeuangan', Icons.bar_chart, "Laporan", false),
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
        Icon(icon, color: isActive ? const Color(0xFF0D2C76) : Colors.grey),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins', // Mengatur font menjadi Poppins
            fontSize: 12,
            color: isActive ? const Color(0xFF0D2C76) : Colors.grey,
          ),
        )
      ],
    ),
  );
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
