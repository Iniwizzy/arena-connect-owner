import 'package:flutter/material.dart';

class PembayaranScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PembayaranPage(),
    );
  }
}

class PembayaranPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1F44),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A1F44),
        elevation: 0,
        leading: Icon(Icons.arrow_back),
        title:
            Text('PEMBAYARAN', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Cari nama pemesan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bukti Pembayaran',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Pembayaran terbaru',
                          style: TextStyle(fontSize: 14)),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Pemesan',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Tanggal',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Metode',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: ListView(
                          children: [
                            PaymentItem(),
                            PaymentItem(),
                            PaymentItem(),
                            PaymentItem(),
                            PaymentItem(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF0A1F44),
        unselectedItemColor: Colors.grey,
        currentIndex: 2,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'Pemesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pembayaran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class PaymentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF0A1F44),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://placehold.co/50x50'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ahmad', style: TextStyle(color: Colors.white)),
                  Text('aliamd@gmail.com',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text('10/01/2024', style: TextStyle(color: Colors.white)),
            ],
          ),
          Column(
            children: [
              Text('BNI', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
