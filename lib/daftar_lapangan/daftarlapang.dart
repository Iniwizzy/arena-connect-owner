import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';

class DaftarLapang extends StatelessWidget {
  const DaftarLapang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header dengan tombol kembali dan judul
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
                Text('Daftar Lapangan', style: notifikasiStyle),
              ],
            ),
          ),
          // Daftar kosong atau pencarian
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // Pencarian
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      height: 30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Cari lapangan yang dikelola',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Gambar dan informasi lapangan kosong
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 130, right: 20, left: 20),
                      child: Column(children: [
                        Center(
                          child: Image.asset('images/Add_File.png'),
                        ),
                        const SizedBox(height: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Belum ada lapangan',
                              style: lampiranStyle,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              textAlign: TextAlign.center,
                              'Lapangan yang kamu daftarkan\n akan muncul disini',
                              style: dec2TextStyle,
                            ),
                            const SizedBox(height: 14),
                            // Tombol tambah lapangan
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                minimumSize: const Size(10, 4),
                                backgroundColor:
                                    const Color.fromRGBO(18, 33, 92, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/tambahlapangan');
                              },
                              child: Text(
                                '+ Lapangan',
                                style: dec3TextStyle,
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
