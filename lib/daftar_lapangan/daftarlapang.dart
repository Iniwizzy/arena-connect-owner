import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';

class Daftarlapang extends StatelessWidget {
  const Daftarlapang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, left: 15),
            height: 100,
            width: 600,
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
                  'Daftar Lapangan',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
              ],
            ),
          ),
          daftarkosong(context), // Pass the context to use Navigator
        ],
      ),
    );
  }

  Widget daftarkosong(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 30,
                width: 350,
                child: Column(
                  children: [
                    Expanded(
                      child: TextField(
                        textAlignVertical: const TextAlignVertical(y: -0.3),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search,
                              color: Colors.grey, size: 20),
                          hintText: 'Cari lapangan yang dikelola',
                          hintStyle: cariStyle,
                          filled: true,
                          fillColor: const Color(0xffFFFFFF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 149, 149, 149),
                              width: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              tambahlapang(context), // Pass the context to use Navigator
            ],
          ),
        ],
      ),
    );
  }

  Widget tambahlapang(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 130, right: 20, left: 20),
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
            TextButton(
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                minimumSize: const Size(10, 4),
                backgroundColor: const Color.fromRGBO(18, 33, 92, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                // Navigasi ke halaman tambah lapangan
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
    );
  }
}
