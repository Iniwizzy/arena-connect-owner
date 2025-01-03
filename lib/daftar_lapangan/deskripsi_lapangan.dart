import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
// import 'package:arena_connect/config/owner_theme.dart';
import 'package:arena_connect/config/theme.dart';
import 'package:icons_plus/icons_plus.dart';

class FieldDescription extends StatelessWidget {
  FieldDescription({super.key});

  final List<Map<String, dynamic>> detailLapangan = [
    {
      'nama': 'Golden',
      'rating': '0 Rating',
      'lapang': ['Futsal', 'Badminton'],
      'lokasi':
          'Jl. Mulawarman Sel. Dalam I, Kramas, Kec. Tembalang, Kota Semarang',
      'harga': 'Rp. 60.000-80.000/jam',
      'gambar': 'images/lapangan.png',
      'description':
          'Lapangan Golden adalah lapangan Futsal dan Badminton yang memiliki 6 lapangan di kota Semarang.',
      'rule': 'Jangan nakal',
      'fasilitas': [
        'Toilet',
        'WiFi',
        'Parkir Mobil',
        'Parkir Motor',
        'Mushola'
      ],
    },
    {
      'nama': 'Sapphire',
      'rating': '0 Rating',
      'lapang': ['Basketball', 'Volley'],
      'lokasi': 'Jl. Banyuasin Utara I, Bulusan, Kec. Tembalang, Kota Semarang',
      'harga': 'Rp. 60.000-80-100.000/jam',
      'gambar': 'images/basketball.jpg',
      'description':
          'Lapangan Sapphire adalah lapangan Futsal dan Badminton yang memiliki 6 lapangan di kota Semarang.',
      'rule': 'Jangan nakal',
      'fasilitas': ['Toilet', 'WiFi', 'Parkir Motor', 'Mushola'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final lapangan = detailLapangan[0]; // Mengambil data pertama dari list

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.elliptical(300, 30),
                  bottomLeft: Radius.elliptical(300, 30)),
              child: Image.asset(
                lapangan['gambar'], // Menampilkan gambar dari data
                height: 250,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45, left: 12),
              child: Container(
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.15),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 180, left: 16, right: 16),
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 12, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lapangan['nama'], // Menampilkan nama dari data
                          style: lampiranStyle,
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit,
                              size: 18, color: Colors.grey),
                          style: IconButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            minimumSize: const Size(30, 30),
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                    Text(
                      lapangan['rating'], // Menampilkan rating dari data
                      style: regulerfont3,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: lapangan['lapang']
                          .map<Widget>((lapang) => Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    if (lapang == 'Futsal') ...[
                                      const Icon(Icons.sports_soccer, size: 10),
                                      const SizedBox(width: 5),
                                    ] else if (lapang == 'Badminton') ...[
                                      const Icon(MingCute.badminton_line,
                                          size: 10),
                                      const SizedBox(width: 5),
                                    ] else if (lapang == 'Volley') ...[
                                      const Icon(
                                          Icons.sports_volleyball_outlined,
                                          size: 10),
                                      const SizedBox(width: 5),
                                    ] else if (lapang == 'Basketball') ...[
                                      const Icon(
                                          Icons.sports_basketball_outlined,
                                          size: 10),
                                      const SizedBox(width: 5),
                                    ],
                                    Text(lapang,
                                        style: facilityStle,
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            lapangan['lokasi'], // Menampilkan lokasi dari data
                            style: regulerfont4,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 18,
                          ),
                          style: IconButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            minimumSize: const Size(30, 30),
                          ),
                          onPressed:
                              () {}, // Untuk menampilkan lokasi di google maps
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      lapangan['harga'], // Menampilkan harga dari data
                      style: lampiran3Style,
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        _descriptionSheet(context);
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize
                              .shrinkWrap), // Untuk menampilkan detail lapangan
                      child: const Text(
                        'Selengkapnya...',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 385, left: 12, right: 12, bottom: 10),
              child: Divider(
                thickness: 0.5,
                height: 0.2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 395, left: 12, right: 12, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Lapangan', style: lampiran3Style),
                      GestureDetector(
                        onTap: () {},
                        child:
                            const Icon(Icons.add, color: Colors.grey, size: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Image.asset(
                              'images/lapangan.png',
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Lapangan Futsal 1',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text('Futsal', style: facilityStle),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const DottedLine(
                    dashLength: 4,
                    dashColor: Colors.grey,
                    lineThickness: 0.28,
                    dashGapLength: 3,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _descriptionSheet(BuildContext context) {
    final lapangan = detailLapangan[0];
    return showModalBottomSheet(
        context: context,
        // isDismissible: false,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
        ),
        builder: (context) => Container(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 14),
              margin: EdgeInsets.zero,
              height: 300,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Deskripsi',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lapangan['description'],
                    style: facility2Stle,
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Aturan Lapangan',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lapangan['rule'],
                    style: facility2Stle,
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Fasilitas',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Wrap(
                    spacing: 8,
                    children: lapangan['fasilitas']
                        .map<Widget>((fasilitas) => Container(
                              margin: const EdgeInsets.only(right: 30),
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 6, bottom: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (fasilitas == 'Toilet') ...[
                                    const Icon(Icons.wc, size: 16),
                                    const SizedBox(width: 18),
                                  ] else if (fasilitas == 'WiFi') ...[
                                    const Icon(MingCute.wifi_fill, size: 16),
                                    const SizedBox(width: 18),
                                  ] else if (fasilitas == 'Parkir Mobil') ...[
                                    const Icon(Icons.drive_eta, size: 16),
                                    const SizedBox(width: 18),
                                  ] else if (fasilitas == 'Parkir Motor') ...[
                                    const Icon(Icons.two_wheeler, size: 16),
                                    const SizedBox(width: 18),
                                  ] else if (fasilitas == 'Mushola') ...[
                                    const Icon(Icons.mosque, size: 16),
                                    const SizedBox(width: 18),
                                  ],
                                  Text(fasilitas,
                                      style: facilityStle,
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ));
  }
}
