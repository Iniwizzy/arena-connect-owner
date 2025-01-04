import 'package:arena_connect/admin/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final Color darkBlue = Color.fromRGBO(18, 33, 92, 1);
  final Color lightBlue = Color(0xFF4285F4);
  final Color greyColor = Color(0xFFA7ADC3);

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

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
              'Ubah Kata Sandi',
              style: GoogleFonts.poppins(
                color: white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pastikan kata sandi berbeda dengan sebelumnya!',
              style: GoogleFonts.poppins(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),
            _buildPasswordField('Password', 'Masukkan Password Baru', true),
            SizedBox(height: 16),
            _buildPasswordField('Konfirmasi Password Baru',
                'Masukkan Kembali Password Baru', false),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika pembaruan password di sini
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
                minimumSize: Size(double.infinity, 0),
              ),
              child: Text(
                'Perbarui Password',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildPasswordField(String label, String hint, bool isPasswordField) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          obscureText: isPasswordField
              ? _isPasswordObscured
              : _isConfirmPasswordObscured,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: greyColor, fontSize: 14),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordField
                    ? (_isPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility)
                    : (_isConfirmPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility),
                color: greyColor,
              ),
              onPressed: () {
                setState(() {
                  if (isPasswordField) {
                    _isPasswordObscured = !_isPasswordObscured;
                  } else {
                    _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
