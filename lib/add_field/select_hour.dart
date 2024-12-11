import 'package:arena_connect/add_field/status_fields.dart';
import 'package:arena_connect/config/owner_theme.dart';
import 'package:arena_connect/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JamSewaPage extends StatefulWidget {
  const JamSewaPage({super.key});

  @override
  _JamSewaPageState createState() => _JamSewaPageState();
}

class _JamSewaPageState extends State<JamSewaPage> {
  final Map<String, Map<String, TextEditingController>> jamControllers = {
    'Sesi Pagi': {'start': TextEditingController(), 'end': TextEditingController()},
    'Sesi Siang': {'start': TextEditingController(), 'end': TextEditingController()},
    'Sesi Sore': {'start': TextEditingController(), 'end': TextEditingController()},
    'Sesi Malam': {'start': TextEditingController(), 'end': TextEditingController()},
  };

  Map<String, Map<String, dynamic>> getJamSewaData() {
    final Map<String, Map<String, dynamic>> jamSewaData = {};

    jamControllers.forEach((kategori, controllers) {
      final String start = controllers['start']!.text.trim();
      final String end = controllers['end']!.text.trim();
      final String harga = hargaControllers[kategori]!.text.trim();

      if (start.isNotEmpty && end.isNotEmpty && harga.isNotEmpty) {
        jamSewaData[kategori] = {
          'start': start,
          'end': end,
          'harga': int.tryParse(harga) ?? 0,
        };
      }
    });

    return jamSewaData;
  }


  final Map<String, IconData> kategoriIcons = {
    'Sesi Pagi': Icons.wb_sunny_outlined, 
    'Sesi Siang': Icons.sunny, 
    'Sesi Sore': Icons.sunny_snowing, 
    'Sesi Malam': Icons.nightlight_outlined, 
  };

  final Map<String, TextEditingController> hargaControllers = {
    'Sesi Pagi': TextEditingController(),
    'Sesi Siang': TextEditingController(),
    'Sesi Sore': TextEditingController(),
    'Sesi Malam': TextEditingController(),
  };

  bool get anyFieldFilled {
    for (var kategori in jamControllers.keys) {
    final start = jamControllers[kategori]!['start']!.text.trim();
    final end = jamControllers[kategori]!['end']!.text.trim();
    final harga = hargaControllers[kategori]!.text.trim();
    // for (var controllers in jamControllers.values) 
    
      // if (controllers['start']!.text.trim().isNotEmpty && controllers['end']!.text.trim().isNotEmpty)
      if (start.isNotEmpty && end.isNotEmpty && harga.isNotEmpty) {
        return true;
      }
    }
    for (var controller in hargaControllers.values) {
      if (controller.text.trim().isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  void debugInputs() {
  jamControllers.forEach((kategori, controllers) {
    print('$kategori - Start: ${controllers['start']!.text}, End: ${controllers['end']!.text}');
  });
  hargaControllers.forEach((kategori, controller) {
    print('$kategori - Harga: ${controller.text}');
  });
  print('anyFieldFilled: $anyFieldFilled');
}


  // void checkFields() {
  //   print("Jam Controllers:");
  //   jamControllers.forEach((kategori, controllers) {
  //     print("$kategori Start: ${controllers['start']!.text}, End: ${controllers['end']!.text}");
  //   });

  //   print("Harga Controllers:");
  //   hargaControllers.forEach((kategori, controller) {
  //     print("$kategori Harga: ${controller.text}");
  //   });

  //   print("Any Field Filled: $anyFieldFilled");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.97),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, left: 15),
            height: 100,
            color: const Color.fromRGBO(18, 33, 92, 1),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  'Jam Sewa Lapangan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: jamControllers.keys.map((kategori) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              kategoriIcons[kategori], 
                              size: 24
                            ),
                            const SizedBox(width: 8),
                            Text(
                              kategori,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 100,
                          height: 28,
                          child: TextField(
                            textAlignVertical: const TextAlignVertical(y: -0.25),
                            controller: hargaControllers[kategori],
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: 'Harga per jam',
                              hintStyle: ket2Style.copyWith(fontSize: 10),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 120,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tentukan $kategori',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              SizedBox(
                                child: TextField(
                                  textAlignVertical: const TextAlignVertical(y: 0.4),
                                  controller: jamControllers[kategori]!['start'],
                                  onChanged: (value) {
                                    setState(() {
                                      
                                    });
                                  },
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    hintText: 'Mulai',
                                    hintStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                    ),
                                    constraints: const BoxConstraints(
                                      // minHeight: 30,
                                      // minWidth: 60,
                                      maxHeight: 40,
                                      maxWidth: 100,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text('—', style: TextStyle(fontSize: 16)),
                              const SizedBox(width: 8),
                              SizedBox(
                                child: TextField(
                                  textAlignVertical: const TextAlignVertical(y: 0.4),
                                  // onChanged: (value) {
                                  //     setState(() {});
                                  //     checkFields();
                                  // },
                                  controller: jamControllers[kategori]!['end'],
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    hintText: 'Selesai',
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                      ),
                                      constraints: const BoxConstraints(
                                      // minHeight: 30,
                                      // minWidth: 60,
                                      maxHeight: 40,
                                      maxWidth: 100,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                );
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(301, 37),
                backgroundColor: anyFieldFilled ? const Color(0xFF489DD6) : Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: anyFieldFilled ? () {
                final jamSewaData = getJamSewaData();
                print("Data Jam Sewa: $jamSewaData");
                Navigator.push(context, MaterialPageRoute(builder: (context) => LihatStatusLapanganPage(jamSewaData: jamSewaData)));
              } : null,
              child: Text(
                'Simpan',
                style: regulerFontSelected1.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
