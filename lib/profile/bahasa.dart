import 'dart:ui';

import 'package:flutter/material.dart';

import '../config/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LanguageSelectionScreen(),
    );
  }
}

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bahasa',
          style: superFont1.copyWith(color: white),
        ),
        backgroundColor:
            const Color(0XFF12215C), // Sesuaikan warna dengan tampilan
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
