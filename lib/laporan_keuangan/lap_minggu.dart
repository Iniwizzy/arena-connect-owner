import 'package:arena_connect/pembayaran/pembayaran.dart';
import 'package:arena_connect/pemesanan/pemesanan.dart';
import 'package:arena_connect/profile/profile.dart';
import 'package:arena_connect/screens/homepage/home.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/laporan_keuangan/daily.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'lap_hari.dart';
import 'lap_bulan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(
      'id_ID', null); // Inisialisasi untuk format lokal ID

  runApp(const LapMinggu());
}

class LapMinggu extends StatelessWidget {
  const LapMinggu({super.key});

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
      initialRoute: '/laporankeuangan',
      routes: {
        '/home': (context) => const HomePage(),
        '/pesanan': (context) => const OrderListScreen(),
        '/pembayaran': (context) => const PaymentScreen(),
        '/laporankeuangan': (context) => const LaporanKeuanganScreen(),
        '/profil': (context) => const ProfilScreen(),
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
  final int pendapatanLapangan1 = 400000;
  final int pendapatanLapangan2 = 400000;
  final int pendapatanLapangan3 = 400000;
  final int pendapatanLapangan4 = 400000;
  final int pendapatanLapangan5 = 400000;
  final int pendapatanLapangan6 = 400000;
  final int pendapatanLapangan7 = 400000;

  String selectedPeriod = 'Minggu';
  DateTime currentDate = DateTime.now();
  // Fungsi untuk mengubah nama hari dan bulan menjadi bahasa Indonesia dengan format satu minggu
  String formatWeekRange(DateTime date) {
    // Cari tanggal awal minggu (Senin) dan akhir minggu (Minggu)
    DateTime startOfWeek =
        date.subtract(Duration(days: date.weekday - 1)); // Senin
    DateTime endOfWeek = date.add(Duration(days: 7 - date.weekday)); // Minggu

    // Format tanggal awal dan akhir minggu
    final formatter = DateFormat('dd MMM yyyy', 'id_ID');
    String start = formatter.format(startOfWeek);
    String end = formatter.format(endOfWeek);

    return '$start - $end'; // Format "dd MMMM yyyy - dd MMMM yyyy"
  }

  @override
  Widget build(BuildContext context) {
    final int totalPendapatanHariIni = pendapatanLapangan1 +
        pendapatanLapangan2 +
        pendapatanLapangan3 +
        pendapatanLapangan4 +
        pendapatanLapangan5 +
        pendapatanLapangan6 +
        pendapatanLapangan7;

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
                    setState(() {
                      currentDate =
                          currentDate.subtract(const Duration(days: 7));
                    });
                    // Aksi saat previous ditekan
                  },
                ),
                const Spacer(),
                Text(
                  formatWeekRange(currentDate),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF12215C),
                    letterSpacing: 0.0,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF12215C)),
                  onPressed: () {
                    setState(() {
                      currentDate = currentDate.add(const Duration(days: 7));
                      // Aksi saat next ditekan
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
                    if (selected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LapBulan()), // Halaman tujuan
                      );
                    }
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
          TotalPendapatanBox(totalPendapatan: totalPendapatanHariIni),
          const SizedBox(height: 16),
          // ListView untuk menampilkan data lapangan
          Expanded(
            child: ListView(
              shrinkWrap: false,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: 'Senin',
                    transaksi: [
                      {
                        'jam': 'Lapangan 1',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 2',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 3',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 4',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 400.000',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: 'Selasa',
                    transaksi: [
                      {
                        'jam': 'Lapangan 1',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 2',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 3',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 4',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 400.000',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: 'Rabu',
                    transaksi: [
                      {
                        'jam': 'Lapangan 1',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 2',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 3',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 4',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 400.000',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: 'Kamis',
                    transaksi: [
                      {
                        'jam': 'Lapangan 1',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 2',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 3',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 4',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 400.000',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: 'Jumat',
                    transaksi: [
                      {
                        'jam': 'Lapangan 1',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 2',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 3',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 4',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 400.000',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: 'Sabtu',
                    transaksi: [
                      {
                        'jam': 'Lapangan 1',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 2',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 3',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 4',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 400.000',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LapanganExpansionTile(
                    lapanganName: 'Minggu',
                    transaksi: [
                      {
                        'jam': 'Lapangan 1',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 2',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 3',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                      {
                        'jam': 'Lapangan 4',
                        'metode': '5X',
                        'jumlah': 'Rp. 100.000'
                      },
                    ],
                    totalPendapatan: 'Rp. 400.000',
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
          _bottomNavItem(context, '/pembayaran', Icons.payments_sharp, "Transaksi", false),
          _bottomNavItem(context, '/laporankeuangan', Icons.bar_chart, "Laporan", true),
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


class TotalPendapatanBox extends StatelessWidget {
  final int totalPendapatan;

  const TotalPendapatanBox({required this.totalPendapatan, Key? key})
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
            'Total Pendapatan Minggu Ini',
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
