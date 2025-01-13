import 'dart:convert';

import 'package:arena_connect/api/api.dart';
import 'package:arena_connect/customer/config/theme.dart';
import 'package:arena_connect/customer/models/res_field_centres.dart';
import 'package:arena_connect/customer/screens/field-search/select_schedule.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FieldCenterDetails extends StatefulWidget {
  final int fieldCentreId;
  const FieldCenterDetails({super.key, required this.fieldCentreId});

  @override
  FieldCenterState createState() => FieldCenterState();
}

Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

class FieldCenterState extends State<FieldCenterDetails> {
  bool isLoading = false;
  FieldCentre? fieldCentre;

  @override
  void initState() {
    super.initState();
    getFieldCentreDetails();
  }

  Future<void> getFieldCentreDetails() async {
    try {
      setState(() {
        isLoading = true;
      });
      String? token = await ApiService().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      http.Response res = await http.get(
        Uri.parse("$baseUrl/field-centres/${widget.fieldCentreId}"),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (res.statusCode == 200) {
        setState(() {
          fieldCentre = FieldCentre.fromJson(jsonDecode(res.body)['data']);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load field centre details');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
  }

  final List<String> imgList = [
    'images/badminton4.jpg',
    'images/badminton2.jpg',
    'images/futsal1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        // title: Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(
                bottom: 10.0), //Tambahkan Margin bawah untuk BoxShadow
            child: Stack(
              children: [
                // Container untuk bayangan
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 10.0), // Margin agar bayangan tidak terpotong
                  // Carousel untuk gambar lapangan
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    items: fieldCentre?.images != null
                        ? fieldCentre!.images!.map((item) {
                            return isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors
                                                  .black26, // Warna bayangan
                                              offset: Offset(
                                                  0, 1), // Posisi bayangan
                                              blurRadius:
                                                  0.5, // Jarak blur bayangan
                                              spreadRadius:
                                                  0.25, // Jarak sebar bayangan
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: NetworkImage(item),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      //Background putih dengan Informasi di atasnya
                                      Positioned(
                                        bottom: 0.55,
                                        left: 0.1,
                                        right: 0.1,
                                        child: Container(
                                          height: 85.0,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7.75),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors
                                                    .black26, // Warna bayangan
                                                offset: Offset(
                                                    0, 1), // Posisi bayangan
                                                blurRadius:
                                                    0.5, // Jarak blur bayangan
                                                spreadRadius:
                                                    0.25, // Jarak sebar bayangan
                                              ),
                                            ],
                                          ),

                                          //Informasi Lapangan
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          fieldCentre
                                                                  ?.address ??
                                                              '',
                                                          style: TextStyle(
                                                              color: secondary,
                                                              fontSize: 8),
                                                        ),
                                                        const SizedBox(
                                                            height: 2),
                                                        isLoading
                                                            ? const Center(
                                                                child: SizedBox(
                                                                  width: 10,
                                                                  height: 10,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2,
                                                                  ),
                                                                ),
                                                              )
                                                            : Text(
                                                                fieldCentre
                                                                        ?.name ??
                                                                    '',
                                                                style:
                                                                    superFont3),
                                                        const SizedBox(
                                                            height: 4),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .orangeAccent,
                                                                size: 22),
                                                            const SizedBox(
                                                                width: 6),
                                                            Text(
                                                                fieldCentre
                                                                        ?.rating
                                                                        .toString() ??
                                                                    '0.0',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            _buildChip(
                                                                'Badminton',
                                                                Icons
                                                                    .sports_tennis),
                                                            const SizedBox(
                                                                width: 8),
                                                            _buildChip(
                                                                'Futsal',
                                                                Icons
                                                                    .sports_soccer),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Mulai',
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color:
                                                                      secondary),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            width: 6),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Rp${fieldCentre?.priceFrom.toString()}',
                                                              style: const TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                          }).toList()
                        : [],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 30, left: 30),
            decoration: BoxDecoration(
              color: Colors.white, // Background putih
              borderRadius: BorderRadius.circular(8), // Tepi rounded
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7), // Warna bayangan
                  spreadRadius: 1, // Sebaran bayangan
                  blurRadius: 2, // Jarak blur
                  offset: const Offset(-0.5, 4), // Perpindahan bayangan (x,y)
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 0.0, left: 25, right: 0),
              child: Row(
                children: [
                  //Kolom Pertama
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            if (fieldCentre?.maps != null &&
                                fieldCentre!.maps.isNotEmpty) {
                              _launchURL(fieldCentre!.maps);
                            }
                          },
                          child: Text(
                            fieldCentre?.maps ?? '',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Kolom Kedua
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 55,
                          height: 45,
                          child: Image.asset(
                            'images/mapreham.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          //ATURAN LAPANGAN
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: 0, bottom: 20, left: 16, right: 16),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 0, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Informasi Kontak",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Daftar aturan dengan bullet poin
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  isLoading
                                      ? const Center(
                                          child: SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        )
                                      : // Bullet point
                                      Expanded(
                                          child: Text(
                                              "Telepon: ${fieldCentre?.phoneNumber ?? ''}, Pemilik: ${fieldCentre?.user?.name ?? ''}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: secondary)),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Alamat Lapangan",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Daftar aturan dengan bullet poin
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  isLoading
                                      ? const Center(
                                          child: SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        )
                                      : // Bullet point
                                      Expanded(
                                          child: Text(
                                              fieldCentre?.address ?? '',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: secondary)),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Deskripsi Lapangan",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Daftar aturan dengan bullet poin
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  isLoading
                                      ? const Center(
                                          child: SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        )
                                      : // Bullet point
                                      Expanded(
                                          child: Text(
                                            fieldCentre?.descriptions ?? '',
                                            style: TextStyle(
                                                fontSize: 12, color: secondary),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Aturan Lapangan",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Daftar aturan dengan bullet poin
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  isLoading
                                      ? const Center(
                                          child: SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        )
                                      : // Bullet point
                                      Expanded(
                                          child: Text(fieldCentre?.rules ?? '',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: secondary)),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //FASILITAS LAPANGAN
                  Container(
                    margin: const EdgeInsets.only(
                        top: 0, bottom: 20, left: 16, right: 16),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 0, left: 16, right: 16),
                    // padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Fasilitas',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Daftar Fasilitas Lapangan dengan Ikon
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //Kolom Pertama dengan Expanded
                                    Flexible(
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        alignment: WrapAlignment.start,
                                        spacing: 22,
                                        runSpacing: 10,
                                        children: [
                                          for (var facility
                                              in fieldCentre?.facilities ?? [])
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize
                                                    .min, // Membatasi ukuran Row
                                                children: [
                                                  Icon(
                                                      facility.name == 'Toilet'
                                                          ? Icons.wc
                                                          : facility.name ==
                                                                  'WiFi'
                                                              ? Icons.wifi
                                                              : facility.name ==
                                                                      'Cafe & Resto'
                                                                  ? Icons
                                                                      .coffee_maker
                                                                  : facility.name ==
                                                                          'Musholla'
                                                                      ? Icons
                                                                          .mosque
                                                                      : facility.name ==
                                                                              'Parkir Mobil'
                                                                          ? Icons
                                                                              .car_rental
                                                                          : facility.name == 'Parkir Motor'
                                                                              ? Icons.motorcycle
                                                                              : facility.name == 'Ruang Ganti'
                                                                                  ? Icons.meeting_room
                                                                                  : facility.name == 'Tribun'
                                                                                      ? Icons.sports_soccer
                                                                                      : facility.name == 'Jual Makanan'
                                                                                          ? Icons.food_bank
                                                                                          : facility.name == 'Jual Minuman'
                                                                                              ? Icons.local_drink_rounded
                                                                                              : Icons.circle,
                                                      color: secondary,
                                                      size: 22),
                                                  const SizedBox(width: 8),
                                                  Text(facility.name,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black)),
                                                ],
                                              ),
                                            ),
                                          // Tambahkan padding atau children tambahan sesuai kebutuhan
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // const Spacer(),
          Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26, // Warna bayangan
                  offset: Offset(4.5, 0), // Posisi bayangan
                  blurRadius: 4.0, // Jarak blur bayangan
                  spreadRadius: 3.5, // Jarak sebar bayangan
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Membuat jarak antara dua elemen
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin:
                        const EdgeInsets.only(top: 12, bottom: 10, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mulai dari',
                          style: TextStyle(
                            fontSize: 10, // Ukuran font yang lebih kecil
                            color: Colors.grey, // Warna teks abu-abu
                          ),
                        ),
                        Text(
                          "Rp${fieldCentre?.priceFrom.toString() ?? ''}",
                          style: superFont2,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        // Aksi ketika tombol ditekan
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectSchedule(
                              // Mengirimkan ID Lapangan ke halaman berikutnya
                              fieldCentreId: widget.fieldCentreId,
                            ),
                          ),
                        );
                      },
                      style: shortButton2,
                      child: Text(
                        'Pilih Lapangan',
                        style: buttonFont4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk kategori chip (misalnya Badminton dan Futsal)
  Widget _buildChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Ukuran Chip hanya sebesar konten
        children: [
          Icon(
            icon,
            size: 12, // Ukuran ikon
            color: Colors.white,
          ),
          const SizedBox(width: 7), // Jarak antara ikon dan teks
          Text(
            label,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.white,
            ), // Ukuran teks
          ),
        ],
      ),
    );
  }
}
