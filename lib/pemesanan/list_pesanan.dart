import 'package:flutter/material.dart';

class ListPesanan extends StatefulWidget {
  const ListPesanan({super.key});

  @override
  _ListPesananState createState() => _ListPesananState();
}

class _ListPesananState extends State<ListPesanan> {
  int _selectedIndex = 1; // Set default tab to Pemesanan (index 1)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 33, 92, 1),
      body: Column(
        children: [
          // AppBar
          Container(
            padding: const EdgeInsets.only(top: 30, left: 15),
            height: 100,
            width: double.infinity,
            color: const Color.fromRGBO(18, 33, 92, 1),
            child: Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                const SizedBox(width: 8),
                const Text(
                  'Daftar Pesanan',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
              ],
            ),
          ),

          // Expanded untuk ListView
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    buildPesananItem(
                        'Azizah Salsa', 'Lapangan Badminton 1', '19/09/2024'),
                    buildPesananItem(
                        'Budiman', 'Lapangan Futsal 1', '19/09/2024'),
                    buildPesananItem(
                        'Anggun Sri', 'Lapangan Futsal 1', '19/09/2024'),
                    buildPesananItem(
                        'Nurul Hidayah', 'Lapangan Badminton 1', '19/09/2024'),
                    buildPesananItem(
                        'Kevin Sanjaya', 'Lapangan Badminton 1', '18/09/2024'),
                    buildPesananItem(
                        'Shofia Anggi', 'Lapangan Futsal 2', '19/09/2024'),
                    buildPesananItem(
                        'Afifah Atohiroh', 'Lapangan Futsal 2', '18/09/2024'),
                    buildPesananItem(
                        'Ratna Anjalie', 'Lapangan Badminton 1', '20/09/2024'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(18, 33, 92, 1),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Pemesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pembayaran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
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

  // Function untuk membangun setiap item pesanan
  Widget buildPesananItem(String name, String lapangan, String date) {
    return SizedBox(
      width: 200,
      height: 90,
      child: Card(
        color: const Color.fromRGBO(18, 33, 92, 1),
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.grey[700]),
          ),
          title: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            lapangan,
            style: const TextStyle(color: Colors.white70),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/deskpesanan'); // Aksi untuk melihat detail
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(10, 35),
                  backgroundColor: Colors.blue,
                  foregroundColor: const Color.fromRGBO(18, 33, 92, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Lihat Detail',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
