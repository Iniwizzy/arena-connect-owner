import 'package:arena_connect/admin/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  final Color darkBlue = Color.fromRGBO(18, 33, 92, 1);
  bool isNotifUmum = true;
  bool isVibrate = false;
  bool isSound = true;
  bool isProductUpdate = false;
  bool isCustomer = true;
  bool isPayment = false;
  bool isPromotion = true;
  bool isSparing = false;
  bool isTips = false;
  bool isNewService = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBlue,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Notifikasi',
              style: GoogleFonts.poppins(
                color: white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        toolbarHeight: 50,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Umum'),
          _buildSwitchOption('Notifikasi Umum', isNotifUmum, (value) {
            setState(() {
              isNotifUmum = value;
            });
          }),
          _buildSwitchOption('Bergetar', isVibrate, (value) {
            setState(() {
              isVibrate = value;
            });
          }),
          _buildSwitchOption('Suara', isSound, (value) {
            setState(() {
              isSound = value;
            });
          }),
          Divider(thickness: 1.0, color: Colors.grey[300]),
          _buildSectionTitle('Pembaruan System & Layanan'),
          _buildSwitchOption('Product Update', isProductUpdate, (value) {
            setState(() {
              isProductUpdate = value;
            });
          }),
          _buildSwitchOption('Customer', isCustomer, (value) {
            setState(() {
              isCustomer = value;
            });
          }),
          _buildSwitchOption('Pelunasan Pembayaran', isPayment, (value) {
            setState(() {
              isPayment = value;
            });
          }),
          _buildSwitchOption('Promosi', isPromotion, (value) {
            setState(() {
              isPromotion = value;
            });
          }),
          _buildSwitchOption('Sparing', isSparing, (value) {
            setState(() {
              isSparing = value;
            });
          }),
          Divider(thickness: 1.0, color: Colors.grey[300]),
          _buildSectionTitle('Lainnya'),
          _buildSwitchOption('Tips Baru', isTips, (value) {
            setState(() {
              isTips = value;
            });
          }),
          _buildSwitchOption('Layanan Baru', isNewService, (value) {
            setState(() {
              isNewService = value;
            });
          }),
        ],
      ),
      bottomNavigationBar: _BottomNavigation(context),
    );
  }

  Widget _BottomNavigation(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10), // Padding vertikal
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bottomNavItem(context, '/home', Icons.home, "Beranda", false),
          _bottomNavItem(context, '/pesanan', Icons.book, "Pesanan", false),
          _bottomNavItem(
              context, '/pembayaran', Icons.payments_sharp, "Transaksi", false),
          _bottomNavItem(
              context, '/laporankeuangan', Icons.bar_chart, "Laporan", false),
          _bottomNavItem(context, '/profil', Icons.person, "Profil", true),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildSwitchOption(
      String title, bool value, Function(bool) onChanged) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: darkBlue,
      ),
    );
  }
}
