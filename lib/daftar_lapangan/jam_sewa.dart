import 'package:arena_connect/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JamSewaPage extends StatefulWidget {
  const JamSewaPage({super.key});

  @override
  _JamSewaPageState createState() => _JamSewaPageState();
}

class _JamSewaPageState extends State<JamSewaPage> {
  final Map<String, List<String>> sesiJam = {
    'Jam Pagi': [
      '07.00 — 08.00',
      '08.00 — 09.00',
      '09.00 — 10.00',
      '10.00 — 11.00'
    ],
    'Jam Siang': ['11.00 — 12.00', '12.00 — 13.00', '13.00 — 14.00'],
    'Jam Sore': [
      '14.00 — 15.00',
      '15.00 — 16.00',
      '16.00 — 17.00',
      '17.00 — 18.00'
    ],
    'Jam Malam': [
      '18.00 — 19.00',
      '19.00 — 20.00',
      '20.00 — 21.00',
      '21.00 — 22.00'
    ],
  };

  final Map<String, Set<String>> selectedJam = {};
  final Map<String, TextEditingController> hargaControllers = {};

  @override
  void initState() {
    super.initState();
    for (var key in sesiJam.keys) {
      selectedJam[key] = {};
      hargaControllers[key] = TextEditingController();
    }
  }

  bool get isAnySelected {
    for (var jams in selectedJam.values) {
      if (jams.isNotEmpty) return true;
    }
    return false;
  }

  bool get allPriceFilled {
    for (var controller in hargaControllers.values) {
      if (controller.text.isEmpty) return false;
    }
    return true;
  }

  bool get canSubmit => isAnySelected && allPriceFilled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Jam Sewa lapangan',
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
              children: sesiJam.keys.map((kategori) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.sunny, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              kategori,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.zero,
                          width: 100,
                          height: 30,
                          child: TextField(
                            controller: hargaControllers[kategori],
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            textAlignVertical: const TextAlignVertical(y: -0.3),
                            decoration: InputDecoration(
                              hintText: 'Harga per jam',
                              hintStyle: ket2Style.copyWith(fontSize: 10),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Daftar sesi
                    Column(
                      children: sesiJam[kategori]!.map((jam) {
                        bool isSelected = selectedJam[kategori]!.contains(jam);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedJam[kategori]!.remove(jam);
                              } else {
                                selectedJam[kategori]!.add(jam);
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color.fromRGBO(18, 33, 92, 1)
                                  : Colors.white,
                              border: Border.all(
                                color: const Color.fromRGBO(18, 33, 92, 1),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  jam,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              }).toList(),
            ),
          ),
          Container(
            // margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(301, 37),
                backgroundColor:
                    isAnySelected ? const Color(0xFF489DD6) : Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: canSubmit ? () {} : null,
              child: Text(
                'Simpan',
                style:
                    regulerFontSelected1.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
