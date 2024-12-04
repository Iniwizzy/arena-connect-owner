// import 'package:arena_connect/config/owner_theme.dart';
// import 'package:arena_connect/config/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class JamSewaPage extends StatefulWidget {
//   const JamSewaPage({super.key});

//   @override
//   _JamSewaPageState createState() => _JamSewaPageState();
// }

// class _JamSewaPageState extends State<JamSewaPage> {
//   final Map<String, List<String>> sesiJam = {
//     'Jam Pagi': ['07.00 — 08.00', '08.00 — 09.00', '09.00 — 10.00', '10.00 — 11.00'],
//     'Jam Siang': ['11.00 — 12.00', '12.00 — 13.00', '13.00 — 14.00'],
//     'Jam Sore': ['14.00 — 15.00', '15.00 — 16.00', '16.00 — 17.00', '17.00 — 18.00'],
//     'Jam Malam': ['18.00 — 19.00', '19.00 — 20.00', '20.00 — 21.00', '21.00 — 22.00'],
//   };

//   final Map<String, Set<String>> selectedJam = {};
//   final Map<String, TextEditingController> hargaControllers = {};

//   @override
//   void initState() {
//     super.initState();
//     for (var key in sesiJam.keys) {
//       selectedJam[key] = {};
//       hargaControllers[key] = TextEditingController();
//     }
//   }

//   bool get isAnySelected {
//     for (var jams in selectedJam.values) {
//       if (jams.isNotEmpty) return true;
//     }
//     return false;
//   }
//   bool get allPriceFilled {
//     for (var controller in hargaControllers.values) {
//       if (controller.text.isEmpty) return false;
//     }
//     return true;
//   }

//   bool get canSubmit => isAnySelected && allPriceFilled;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.only(top: 30, left: 15),
//             height: 100,
//             color: const Color.fromRGBO(18, 33, 92, 1),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'Jam Sewa lapangan',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(16),
//               children: sesiJam.keys.map((kategori) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             const Icon(Icons.sunny, size: 24),
//                             const SizedBox(width: 8),
//                             Text(
//                               kategori, 
//                               style: const TextStyle(
//                                 fontSize: 18, 
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           padding: EdgeInsets.zero,
//                           width: 100,
//                           height: 30,
//                           child: TextField(
//                             controller: hargaControllers[kategori],
//                             keyboardType: TextInputType.number,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                             ],
//                             textAlignVertical: const TextAlignVertical(y: -0.3),
//                             decoration: InputDecoration(
//                               hintText: 'Harga per jam',
//                               hintStyle: ket2Style.copyWith(fontSize: 10),
//                               border: OutlineInputBorder(
//                                 borderSide: const BorderSide(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             onChanged: (value) {
//                               setState(() {
                                
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     // Daftar sesi
//                     Column(
//                       children: sesiJam[kategori]!.map((jam) {
//                         bool isSelected = selectedJam[kategori]!.contains(jam);
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               if (isSelected) {
//                                 selectedJam[kategori]!.remove(jam);
//                               } else {
//                                 selectedJam[kategori]!.add(jam);
//                               }
//                             });
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(vertical: 4),
//                             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                             decoration: BoxDecoration(
//                               color: isSelected ? const Color.fromRGBO(18, 33, 92, 1) : Colors.white,
//                               border: Border.all(
//                                 color: const Color.fromRGBO(18, 33, 92, 1),
//                                 width: 1.5,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   jam,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontSize: 14,
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                     const SizedBox(height: 24),
//                   ],
//                 );
//               }).toList(),
//             ),
//           ),
//           Container(
//             // margin: const EdgeInsets.only(top: 15),
//             padding: const EdgeInsets.only(top: 15, bottom: 20),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(301, 37),
//                 backgroundColor: isAnySelected
//                 ? const Color(0xFF489DD6)
//                 : Colors.grey[300],
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//               onPressed: canSubmit
//               ? (){

//               }
//               : null,
//               child: Text(
//                 'Simpan',
//                 style: regulerFontSelected1.copyWith(fontWeight: FontWeight.w600),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class JamSewaPage extends StatefulWidget {
//   const JamSewaPage({super.key});

//   @override
//   _JamSewaPageState createState() => _JamSewaPageState();
// }

// class _JamSewaPageState extends State<JamSewaPage> {
//   final List<Map<String, TextEditingController>> sesiControllers = [];
//   final TextEditingController hargaController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     addNewSesi();
//   }

//   void addNewSesi() {
//     setState(() {
//       sesiControllers.add({
//         'mulai': TextEditingController(),
//         'selesai': TextEditingController(),
//       });
//     });
//   }

//   void removeSesi(int index) {
//     setState(() {
//       sesiControllers.removeAt(index);
//     });
//   }

//   bool get allFieldsFilled {
//     if (hargaController.text.isEmpty) return false;
//     for (var controllers in sesiControllers) {
//       if (controllers['mulai']!.text.isEmpty || controllers['selesai']!.text.isEmpty) {
//         return false;
//       }
//     }
//     return true;
//   }

//   bool get canSubmit => allFieldsFilled;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.only(top: 30, left: 15),
//             height: 100,
//             color: const Color.fromRGBO(18, 33, 92, 1),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'Jam Sewa Lapangan',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(16),
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Harga per Jam:',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                     ),
//                     Container(
//                       padding: EdgeInsets.zero,
//                       width: 100,
//                       height: 30,
//                       child: TextField(
//                         controller: hargaController,
//                         keyboardType: TextInputType.number,
//                         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                         textAlignVertical: const TextAlignVertical(y: -0.3),
//                         decoration: InputDecoration(
//                           hintText: 'Harga',
//                           hintStyle: const TextStyle(fontSize: 12),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         onChanged: (value) {
//                           setState(() {});
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Atur Jam Sewa:',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 8),
//                 ...sesiControllers.asMap().entries.map((entry) {
//                   int index = entry.key;
//                   var controllers = entry.value;
//                   return Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               controller: controllers['mulai'],
//                               keyboardType: TextInputType.datetime,
//                               decoration: InputDecoration(
//                                 hintText: 'Mulai',
//                                 border: OutlineInputBorder(
//                                   borderSide: const BorderSide(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           const Text('—'),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: TextField(
//                               controller: controllers['selesai'],
//                               keyboardType: TextInputType.datetime,
//                               decoration: InputDecoration(
//                                 hintText: 'Selesai',
//                                 border: OutlineInputBorder(
//                                   borderSide: const BorderSide(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           IconButton(
//                             icon: const Icon(Icons.remove_circle, color: Colors.red),
//                             onPressed: () {
//                               removeSesi(index);
//                             },
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                     ],
//                   );
//                 }).toList(),
//                 TextButton(
//                   onPressed: addNewSesi,
//                   child: const Text('Tambah Jam Sewa'),
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.only(top: 15, bottom: 20),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(301, 37),
//                 backgroundColor: canSubmit ? const Color(0xFF489DD6) : Colors.grey[300],
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//               onPressed: canSubmit ? () {} : null,
//               child: Text(
//                 'Simpan',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class JamSewaPage extends StatefulWidget {
//   const JamSewaPage({super.key});

//   @override
//   _JamSewaPageState createState() => _JamSewaPageState();
// }

// class _JamSewaPageState extends State<JamSewaPage> {
//   final TextEditingController hargaPagiController = TextEditingController();
//   final TextEditingController mulaiPagiController = TextEditingController();
//   final TextEditingController selesaiPagiController = TextEditingController();

//   final TextEditingController hargaSiangController = TextEditingController();
//   final TextEditingController mulaiSiangController = TextEditingController();
//   final TextEditingController selesaiSiangController = TextEditingController();

//   final TextEditingController hargaSoreController = TextEditingController();
//   final TextEditingController mulaiSoreController = TextEditingController();
//   final TextEditingController selesaiSoreController = TextEditingController();

//   final TextEditingController hargaMalamController = TextEditingController();
//   final TextEditingController mulaiMalamController = TextEditingController();
//   final TextEditingController selesaiMalamController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.only(top: 30, left: 15),
//             height: 100,
//             color: const Color.fromRGBO(18, 33, 92, 1),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'Jam Sewa Lapangan',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(16),
//               children: [
//                 _buildSesi(
//                   context,
//                   'Jam Pagi',
//                   'images/pagi.png',
//                   // 'assets/icons/morning.png', 
//                   hargaPagiController,
//                   mulaiPagiController,
//                   selesaiPagiController,
//                 ),
//                 _buildSesi(
//                   context,
//                   'Jam Siang',
//                   'images/clear_day.png', 
//                   hargaSiangController,
//                   mulaiSiangController,
//                   selesaiSiangController,
//                 ),
//                 _buildSesi(
//                   context,
//                   'Jam Sore',
//                   'images/sore.png', 
//                   hargaSoreController,
//                   mulaiSoreController,
//                   selesaiSoreController,
//                 ),
//                 _buildSesi(
//                   context,
//                   'Jam Malam',
//                   'images/malam.png', 
//                   hargaMalamController,
//                   mulaiMalamController,
//                   selesaiMalamController,
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.only(top: 15, bottom: 20),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(301, 37),
//                 backgroundColor: const Color(0xFF489DD6),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//               onPressed: () {},
//               child: const Text(
//                 'Simpan',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSesi(
//     BuildContext context,
//     String title,
//     String iconPath,
//     TextEditingController hargaController,
//     TextEditingController mulaiController,
//     TextEditingController selesaiController,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Image.asset(iconPath, height: 24), // Pastikan ikon tersedia di folder aset
//             const SizedBox(width: 8),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const Spacer(),
//             Container(
//               padding: EdgeInsets.zero,
//               width: 100,
//               height: 30,
//               child: TextField(
//                 controller: hargaController,
//                 keyboardType: TextInputType.number,
//                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                 // textAlignVertical: const TextAlignVertical(y: -0.3),
//                 decoration: InputDecoration(
//                   hintText: 'Harga per jam',
//                   hintStyle: const TextStyle(fontSize: 12),
//                   border: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Text(
//           'Tentukan $title',
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: mulaiController,
//                 keyboardType: TextInputType.datetime,
//                 decoration: InputDecoration(
//                   hintText: 'Mulai',
//                   border: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             const Text('—'),
//             const SizedBox(width: 8),
//             Expanded(
//               child: TextField(
//                 controller: selesaiController,
//                 keyboardType: TextInputType.datetime,
//                 decoration: InputDecoration(
//                   hintText: 'Selesai',
//                   border: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

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

  final Map<String, IconData> kategoriIcons = {
  'Sesi Pagi': Icons.wb_sunny_outlined, // Ikon untuk pagi
  'Sesi Siang': Icons.sunny, // Ikon untuk siang
  'Sesi Sore': Icons.sunny_snowing, // Ikon untuk sore
  'Sesi Malam': Icons.nightlight_outlined, // Ikon untuk malam
};


  final Map<String, TextEditingController> hargaControllers = {
    'Sesi Pagi': TextEditingController(),
    'Sesi Siang': TextEditingController(),
    'Sesi Sore': TextEditingController(),
    'Sesi Malam': TextEditingController(),
  };

  bool get allFieldsFilled {
    for (var controllers in jamControllers.values) {
      if (controllers['start']!.text.trim().isEmpty || controllers['end']!.text.trim().isEmpty) return false;
    }
    for (var controller in hargaControllers.values) {
      if (controller.text.trim().isEmpty) return false;
    }
    return true;
  }

  void checkFields() {
    print("Jam Controllers:");
    jamControllers.forEach((kategori, controllers) {
      print("$kategori Start: ${controllers['start']!.text}, End: ${controllers['end']!.text}");
    });

    print("Harga Controllers:");
    hargaControllers.forEach((kategori, controller) {
      print("$kategori Harga: ${controller.text}");
    });

    print("All Fields Filled: $allFieldsFilled");
  }

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
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 100,
                          height: 30,
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
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: jamControllers[kategori]!['start'],
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    hintText: 'Mulai',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text('—', style: TextStyle(fontSize: 16)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                      setState(() {});
                                      checkFields();
                                  },
                                  controller: jamControllers[kategori]!['end'],
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    hintText: 'Selesai',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                backgroundColor: allFieldsFilled ? const Color(0xFF489DD6) : Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: allFieldsFilled ? () {} : null,
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
