import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/theme.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'Indonesia';
  final Color darkBlue = Color.fromRGBO(18, 33, 92, 1);
  final Color lightBlue = Color(0xFF4285F4);
  final Color greyColor = Color(0xFFA7ADC3);

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
              'Bahasa',
              style: GoogleFonts.poppins(
                color: white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ), // Sesuaikan warna dengan tampilan
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text('Disarankan', style: superFont2),
          SizedBox(height: 10),
          _buildLanguageOption('Indonesia'),
          _buildLanguageOption('Inggris (US)'),
          Divider(thickness: 1.0, color: Colors.white),
          SizedBox(height: 10),
          Text('Lainnya', style: superFont2),
          SizedBox(height: 10),
          _buildLanguageOption('Mandarin'),
          _buildLanguageOption('Hindi'),
          _buildLanguageOption('Spanyol'),
          _buildLanguageOption('Prancis'),
          _buildLanguageOption('Arab'),
          _buildLanguageOption('Rusia'),
          _buildLanguageOption('Indonesia'),
          _buildLanguageOption('Vietnam'),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 4,
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Color(0xFF1A237E),
      //   unselectedItemColor: Colors.white,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Beranda',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.bookmark),
      //       label: 'Pemesanan',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications),
      //       label: 'Pemberitahuan',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.help),
      //       label: 'Bantuan',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profil',
      //     ),
      // ],
    );
  }

  Widget _buildLanguageOption(String language) {
    return ListTile(
      title: Text(language),
      trailing: Radio<String>(
        value: language,
        groupValue: selectedLanguage,
        onChanged: (value) {
          setState(() {
            selectedLanguage = value!;
          });
        },
        activeColor: Color(0xFF1A237E), // Sesuaikan warna dengan tampilan
      ),
    );
  }
}
