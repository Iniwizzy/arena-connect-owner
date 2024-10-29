import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

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
      appBar: AppBar(
        title: Text('Daftar Pesanan'),
        backgroundColor: Color(0xFF12215C),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: orders.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.0),
          itemBuilder: (context, index) {
            Order order = orders[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF12215C),
                  child: Text(
                    order.name[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  order.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF12215C),
                    fontSize: 16.0,
                  ),
                ),
                subtitle: Text(
                  '${order.activity} - ${order.date}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.0,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Handle "Lihat Detail" button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF12215C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                  child: Text(
                    'Lihat Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
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