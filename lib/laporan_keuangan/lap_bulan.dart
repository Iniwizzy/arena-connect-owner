import 'package:arena_connect/beranda/home_page.dart';
import 'package:arena_connect/pesanan/pesanan.dart';
import 'package:arena_connect/transaksi/transaksi.dart';
import 'package:arena_connect/profile/profil1.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/laporan_keuangan/daily.dart'; // Pastikan path ini sudah benar
import 'package:intl/date_symbol_data_local.dart'; // Perbaikan untuk intl
import 'package:intl/intl.dart';
import 'lap_minggu.dart';
import 'lap_hari.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(
      'id_ID', null); // Inisialisasi untuk format lokal ID

  runApp(const LapBulan());
}

class LapBulan extends StatelessWidget {
  const LapBulan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laporan Keuangan',
      theme: ThemeData(
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/laporankeuangan',
      routes: {
        '/home': (context) => const HomePage(),
        '/pesanan': (context) => OrderListScreen(),
        '/pembayaran': (context) => const PaymentScreen(),
        '/laporankeuangan': (context) => const LaporanKeuanganScreen(),
        '/profil': (context) => const ProfileScreen(),
      },
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
  final int pendapatanLapangan1 = 2800000;
  final int pendapatanLapangan2 = 2800000;
  final int pendapatanLapangan3 = 2800000;
  final int pendapatanLapangan4 = 2800000;

  String selectedPeriod = 'Bulan';
  DateTime currentDate =
      DateTime.now(); // Variabel untuk menyimpan tanggal saat ini

  // Fungsi untuk mengubah nama hari dan bulan menjadi bahasa Indonesia
  String formatMonth(DateTime date) {
    // Cari tanggal awal minggu (Senin)
    DateTime startOfWeek =
        date.subtract(Duration(days: date.weekday - 1)); // Senin

    // Format bulan dan tahun untuk tanggal awal minggu
    final formatter = DateFormat('MMMM yyyy', 'id_ID');
    String startMonth = formatter.format(startOfWeek);

    // Mengembalikan bulan dan tahun yang diformat
    return startMonth; // Hanya menampilkan satu bulan
  }

  @override
  Widget build(BuildContext context) {
    final int totalPendapatanHariIni = pendapatanLapangan1 +
        pendapatanLapangan2 +
        pendapatanLapangan3 +
        pendapatanLapangan4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF12215C),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
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
                    setState(() {
                      currentDate = currentDate =
                          DateTime(currentDate.year, currentDate.month - 1, 1);
                    });
                  },
                ),
                const Spacer(),
                Text(
                  formatMonth(currentDate),
                  style: const TextStyle(
                    fontSize: 20,
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
                    setState(() {
                      currentDate =
                          DateTime(currentDate.year, currentDate.month + 1, 1);
                    });
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
                    if (selected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LapHari()), // Halaman tujuan
                      );
                    }
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
                    if (selected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LapMinggu()), // Halaman tujuan
                      );
                    }
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
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: '01 Oktober - 07 Oktober',
                    transaksi: [
                      {
                        'jam': 'Senin',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Selasa',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {'jam': 'Rabu', 'metode': '20X', 'jumlah': 'Rp. 400.000'},
                      {
                        'jam': 'Kamis',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Jumat',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Sabtu',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Minggu',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 2.800.000',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: '08 Oktober - 14 Oktober',
                    transaksi: [
                      {
                        'jam': 'Senin',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Selasa',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {'jam': 'Rabu', 'metode': '20X', 'jumlah': 'Rp. 400.000'},
                      {
                        'jam': 'Kamis',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Jumat',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Sabtu',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Minggu',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 2.800.000',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: '14 Oktober - 21 Oktober',
                    transaksi: [
                      {
                        'jam': 'Senin',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Selasa',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {'jam': 'Rabu', 'metode': '20X', 'jumlah': 'Rp. 400.000'},
                      {
                        'jam': 'Kamis',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Jumat',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Sabtu',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Minggu',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 2.800.000',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: '22 Oktober - 28 Oktober',
                    transaksi: [
                      {
                        'jam': 'Senin',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Selasa',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {'jam': 'Rabu', 'metode': '20X', 'jumlah': 'Rp. 400.000'},
                      {
                        'jam': 'Kamis',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Jumat',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Sabtu',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                      {
                        'jam': 'Minggu',
                        'metode': '20X',
                        'jumlah': 'Rp. 400.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 2.800.000',
                  ),
                ),
              ],
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
          _bottomNavItem(context, '/pesanan', Icons.book, "Pesanan", false),
          _bottomNavItem(
              context, '/pembayaran', Icons.payments_sharp, "Transaksi", false),
          _bottomNavItem(
              context, '/laporankeuangan', Icons.bar_chart, "Laporan", true),
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
            'Total Pendapatan Bulan Ini',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
