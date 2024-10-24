import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';

class SampleContainer extends StatelessWidget {
  const SampleContainer({super.key});

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
                Text('Notifikasi', style: notifikasiStyle),
              ],
            ),
          ),
          const SizedBox(height: 12),
          filter(),
        ],
      ),
    );
  }

  Widget filter() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xffffffff),
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  minimumSize: const Size(13, 2),
                ),
                child: const Text(
                  'Belum Dibaca',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(18, 33, 92, 1),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xffffffff),
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  minimumSize: const Size(13, 2),
                ),
                child: const Text(
                  'Sudah Dibaca',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(18, 33, 92, 1),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
