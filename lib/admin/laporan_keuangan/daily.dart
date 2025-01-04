// lib/widgets/lapangan_expansion_tile.dart

import 'package:flutter/material.dart';

class LapanganExpansionTile extends StatelessWidget {
  final String lapanganName;
  final List<Map<String, String>> transaksi;
  final String totalPendapatan;

  const LapanganExpansionTile({
    Key? key,
    required this.lapanganName,
    required this.transaksi,
    required this.totalPendapatan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF12215C), // Warna latar belakang
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ExpansionTile(
          initiallyExpanded: false, // Tetap ditutup pada awalnya
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lapanganName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  '$totalPendapatan',
                  textAlign: TextAlign.center, // Menempatkan teks di tengah
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          iconColor: Colors.white, // Ikon putih saat dibuka
          collapsedIconColor: Colors.white, // Ikon tetap putih saat ditutup
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1.5),
              },
              children: transaksi.map((transaksiItem) {
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        transaksiItem['jam']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        transaksiItem['metode']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        transaksiItem['jumlah']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
