import 'package:flutter/material.dart';
import 'package:arena_connect/laporan_keuangan/daily.dart'; // Pastikan path ini sudah benar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laporan Keuangan',
      theme: ThemeData(
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LaporanKeuanganScreen(),
    );
  }
}

class LaporanKeuanganScreen extends StatefulWidget {
  const LaporanKeuanganScreen({super.key});

  @override
  _LaporanKeuanganScreenState createState() => _LaporanKeuanganScreenState();
}

class _LaporanKeuanganScreenState extends State<LaporanKeuanganScreen> {
  final int pendapatanLapangan1 = 360000;
  final int pendapatanLapangan2 = 250000;
  final int pendapatanLapangan3 = 320000;

  String selectedPeriod = 'Hari'; // Variabel untuk mengatur pilihan periode

  @override
  Widget build(BuildContext context) {
    final int totalPendapatanHariIni =
        pendapatanLapangan1 + pendapatanLapangan2 + pendapatanLapangan3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF12215C),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
            onPressed: () {
              // Aksi saat tombol kembali ditekan
            },
          ),
        ),
        title: const Text(
          'LAPORAN KEUANGAN',
          style: TextStyle(
            color: Color(0XFFFFFFFF),
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 75.0,
      ),
      body: Column(
        children: [
          // Tanggal dengan ikon previous dan next
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF12215C)),
                  onPressed: () {
                    // Aksi saat previous ditekan
                  },
                ),
                const Spacer(),
                const Text(
                  'Selasa, 12 Oktober 2024',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF12215C),
                    letterSpacing: 1.0,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF12215C)),
                  onPressed: () {
                    // Aksi saat next ditekan
                  },
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 2,
            color: Color(0xFF12215C),
          ),
          // Widget untuk memilih tampilan berdasarkan hari, minggu, bulan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceChip(
                  label: const Text('Hari'),
                  selected: selectedPeriod == 'Hari',
                  selectedColor: const Color(0xFF12215C),
                  onSelected: (bool selected) {
                    setState(() {
                      selectedPeriod = 'Hari';
                    });
                  },
                  labelStyle: TextStyle(
                    color:
                        selectedPeriod == 'Hari' ? Colors.white : Colors.black,
                  ),
                ),
                ChoiceChip(
                  label: const Text('Minggu'),
                  selected: selectedPeriod == 'Minggu',
                  selectedColor: const Color(0xFF12215C),
                  onSelected: (bool selected) {
                    setState(() {
                      selectedPeriod = 'Minggu';
                    });
                  },
                  labelStyle: TextStyle(
                    color: selectedPeriod == 'Minggu'
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                ChoiceChip(
                  label: const Text('Bulan'),
                  selected: selectedPeriod == 'Bulan',
                  selectedColor: const Color(0xFF12215C),
                  onSelected: (bool selected) {
                    setState(() {
                      selectedPeriod = 'Bulan';
                    });
                  },
                  labelStyle: TextStyle(
                    color:
                        selectedPeriod == 'Bulan' ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Widget untuk menampilkan total pendapatan
          TotalPendapatanKerenCard(totalPendapatan: totalPendapatanHariIni),
          const SizedBox(height: 16),
          // ListView untuk menampilkan data lapangan
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: 'Lapangan 1',
                    transaksi: [
                      {
                        'jam': '08:00 - 09:00',
                        'metode': 'BNI',
                        'jumlah': 'Rp. 80.000'
                      },
                      {
                        'jam': '13:00 - 14:00',
                        'metode': 'BSI',
                        'jumlah': 'Rp. 80.000'
                      },
                      {
                        'jam': '20:00 - 21:00',
                        'metode': 'BRI',
                        'jumlah': 'Rp. 90.000'
                      },
                      {
                        'jam': '20:00 - 21:00',
                        'metode': 'BRI',
                        'jumlah': 'Rp. 110.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 360.000',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: 'Lapangan 2',
                    transaksi: [
                      {
                        'jam': '09:00 - 10:00',
                        'metode': 'BNI',
                        'jumlah': 'Rp. 70.000'
                      },
                      {
                        'jam': '14:00 - 15:00',
                        'metode': 'BSI',
                        'jumlah': 'Rp. 85.000'
                      },
                      {
                        'jam': '21:00 - 22:00',
                        'metode': 'BRI',
                        'jumlah': 'Rp. 95.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 250.000',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: 'Lapangan 3',
                    transaksi: [
                      {
                        'jam': '07:00 - 08:00',
                        'metode': 'BNI',
                        'jumlah': 'Rp. 50.000'
                      },
                      {
                        'jam': '16:00 - 17:00',
                        'metode': 'BSI',
                        'jumlah': 'Rp. 70.000'
                      },
                      {
                        'jam': '19:00 - 20:00',
                        'metode': 'BRI',
                        'jumlah': 'Rp.100.000'
                      },
                      {
                        'jam': '20:00 - 21:00',
                        'metode': 'BRI',
                        'jumlah': 'Rp.100.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 320.000',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(), // Pisah bottom navigation
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 3,
      //   selectedItemColor: const Color(0xFF0D2C76),
      //   unselectedItemColor: Colors.grey,
      //   showSelectedLabels: true,
      //   showUnselectedLabels: true,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Beranda',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list_alt),
      //       label: 'Pemesanan',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.payment),
      //       label: 'Pembayaran',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.bar_chart),
      //       label: 'Laporan',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profil',
      //     ),
      //   ],
      // ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
          vertical: 16), // Opsional untuk memberi padding di sekitar tombol
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              // Aksi ketika ikon Beranda diklik
              Navigator.pushNamed(context, '/home');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.home, color: Colors.grey),
                SizedBox(height: 4),
                Text("Beranda", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Aksi ketika ikon Pemesanan diklik
              ;
              Navigator.pushNamed(context, '/pemesanan');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.book, color: Colors.grey),
                SizedBox(height: 4),
                Text("Pemesanan", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Aksi ketika ikon Pembayaran diklik
              Navigator.pushNamed(context, '/pembayaran');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.payments_sharp, color: Colors.grey),
                SizedBox(height: 4),
                Text("Pembayaran", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Aksi ketika ikon Laporan diklik
              Navigator.pushNamed(context, '/laporan');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.bar_chart, color: Color(0xFF0D2C76)),
                SizedBox(height: 4),
                Text("Laporan", style: TextStyle(color: Color(0xFF0D2C76))),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Aksi ketika ikon Profil diklik
              Navigator.pushNamed(context, '/profil');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.person, color: Colors.grey),
                SizedBox(height: 4),
                Text("Profil", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TotalPendapatanKerenCard extends StatelessWidget {
  final int totalPendapatan;

  const TotalPendapatanKerenCard({required this.totalPendapatan, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Lebar penuh
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF12215C),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Total Pendapatan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Rp. ${totalPendapatan.toString()}',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
