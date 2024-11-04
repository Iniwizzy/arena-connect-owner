// import 'package:flutter/material.dart';
// import 'package:arena_connect/config/owner_theme.dart';
// import 'package:arena_connect/config/theme.dart';

// class ListFullLapang extends StatelessWidget {
//   const ListFullLapang({super.key});

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
//                     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     }),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'Daftar Lapangan', 
//                   style: TextStyle(
//                     color: Colors.white, 
//                     fontSize: 20, 
//                     fontWeight: FontWeight.w500, 
//                     fontFamily: 'Poppins')),
//               ],
//             ),
//           ),
//           daftarkosong(),
//         ],
//       ),
//     );
//   }

//   Widget daftarkosong() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             children: [
//               SizedBox(
                
//                 // mae: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                 height: 30,
//                 // width: 350,
//                 // decoration: BoxDecoration(
//                 //   color: Colors.white,
//                 //   border: Border.all(
//                 //     color: Colors.grey,
//                 //     width: 0,
//                 //   ),
//                 //   borderRadius: BorderRadius.circular(10),
//                 // ),
//                 child: Column(
//                   children: [
//                     // const Icon(
//                     //   Icons.search,
//                     //   color: Colors.grey,
//                     //   size: 20,
//                     // ),
//                     // const SizedBox(width: 10),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             width: 300,
//                             child: TextField(
//                               textAlignVertical: const TextAlignVertical(y: -0.3),
//                               decoration: InputDecoration(
//                                 prefixIcon:
//                                     const Icon(Icons.search, color: Colors.grey, size: 20),
//                                 hintText: 'Cari lapangan yang dikelola',
//                                 hintStyle: cariStyle,
//                                 filled: true,
//                                 fillColor: const Color(0xffFFFFFF),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide:  const BorderSide(
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: const BorderSide(
//                                     color: Color.fromARGB(255, 149, 149, 149),
//                                     width: 0.8,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Container(
//                             height: 30,
//                             width: 30,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: Colors.grey,
//                                 width: 0.8,
//                               )
//                             ),
//                             child: Center(
//                               child: IconButton(
//                                 onPressed: (){

//                                 },
//                                 icon: const Icon(
//                                   Icons.add, 
//                                   color: Colors.grey,
//                                 ),
//                                 iconSize: 24,
//                                 padding: EdgeInsets.zero,
//                               ),
//                             )
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               lapangtersedia(),
//             ],
//           ),
//         ],
//       ),
//       // children: [
//       //   Container(
//       //     height: 210,
//       //     width: 310,
//       //     color: Colors.amber,
//       //     child: Column(
//       //       mainAxisAlignment: MainAxisAlignment.end,
//       //       children: [
//       //         Center(
//       //           child:
//       //             Image.asset('assets/images/Add File.png'),

//       //         )
//       //       ],
//       //     )
//       //   )
//       // ]
//     );
//   }

//   Widget lapangtersedia() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 30),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2), // Warna bayangan
//               spreadRadius: 2,                    // Radius penyebaran bayangan
//               blurRadius: 3,                      // Radius blur bayangan
//               offset: const Offset(0, 2),         // Posisi offset (x, y)
//             ),
//           ],
//         ),
//         height: 310,
//         // width: 410,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               height: 150,
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topRight: Radius.circular(8),
//                     topLeft: Radius.circular(8),),
//                   child: Image.asset(
//                     'images/lapangan.png',
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Golden',
//                     style: lampiranStyle,
//                     textAlign: TextAlign.left,
//                   ),
//                   Text(
//                     'Kota Semarang',
//                     style: ketStyle,
//                     textAlign: TextAlign.left,
//                   ),
//                   const SizedBox(height: 3),
//                   Container(
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             height: 18,
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Colors.grey.withOpacity(0.15),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(
//                                   Icons.sports_soccer,
//                                   size: 10,
//                                 ),
//                                 const SizedBox(width: 6),
//                                 Text(
//                                   'Futsal',
//                                   style: facilityStle,
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 8), // Jarak antar kotak
//                           Container(
//                             height: 18,
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Colors.grey.withOpacity(0.15),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(
//                                   Icons.sports_soccer,
//                                   size: 10,
//                                 ),
//                                 const SizedBox(width: 6),
//                                 Text(
//                                   'Badminton',
//                                   style: facilityStle,
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Container(
//                     color: Colors.white,
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Rp. 60.000-80.000/jam',
//                               style: regularFont3,
//                               textAlign: TextAlign.left,
//                             ),
//                             IconButton(
//                               onPressed: (){
                            
//                             },
//                             icon: Icon(
//                               Icons.edit,
//                               color: Colors.grey.withOpacity(0.8),
//                               size: 18,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         ElevatedButton(onPressed: (){

//                         },
//                         style: shortButton3,
//                         child: Text(
//                           'Lihat Status Lapangan',
//                           style: buttonTextStyle,
//                           ),
//                         ),
//                       ],     
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:arena_connect/config/owner_theme.dart';
import 'package:arena_connect/config/theme.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:arena_connect/add_field/models/model_lapang.dart'; // Import model data

class ListFullLapang extends StatelessWidget {
  const ListFullLapang({super.key});

  @override
  Widget build(BuildContext context) {
    // Data lapangan
    final List<Lapangan> lapanganList = [
      Lapangan(
        name: 'Golden',
        location: 'Kota Semarang',
        price: 'Rp. 60.000-80.000/jam',
        imageURL: 'images/lapangan.png',
        facilities: ['Futsal', 'Badminton'],
      ),
      Lapangan(
        name: 'Sapphire',
        location: 'Kota Bandung',
        price: 'Rp. 70.000-90.000/jam',
        imageURL: 'images/basketball.jpg',
        facilities: ['Basketball', 'Volley'],
      ),
      Lapangan(
        name: 'Gondang',
        location: 'Kota  Surabaya',
        price: 'Rp. 70.000-100.000/jam',
        imageURL: 'images/volley.jpg',
        facilities: ['Futsal', 'Volley'],
      ),
      // Tambahkan data lapangan lainnya di sini
    ];

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
                  'Daftar Lapangan',
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
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Column(
              children: [
                searchBar(),
                const SizedBox(height: 3),
              ],
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                itemCount: lapanganList.length,
                itemBuilder: (context, index) {
                  return lapangtersedia(lapanganList[index], context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20,),
                hintText: 'Cari lapangan yang dikelola',
                hintStyle: cariStyle,
                filled: true,
                fillColor: Colors.white,
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
          const SizedBox(width: 12),
          Container(
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 0.8),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.grey),
              padding: EdgeInsets.zero,
              onPressed: () {

              },
            ),
          ),
          // const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget lapangtersedia(Lapangan lapangan, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        height: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.asset(
                  lapangan.imageURL,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lapangan.name,
                    style: lampiranStyle,
                  ),
                  Text(
                    lapangan.location,
                    style: ketStyle,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: lapangan.facilities.map((facility) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            if (facility == 'Futsal') ...[
                              const Icon(Icons.sports_soccer, size: 10),
                              const SizedBox(width: 5),
                            ]
                            else  if (facility == 'Badminton') ...[
                              const Icon(MingCute.badminton_line, size: 10),
                              const SizedBox(width: 5),
                            ]
                            else  if (facility == 'Volley') ...[
                              const Icon(Icons.sports_volleyball_outlined, size: 10),
                              const SizedBox(width: 5),
                            ]
                            else  if (facility == 'Basketball') ...[
                              const Icon(Icons.sports_basketball_outlined, size: 10),
                              const SizedBox(width: 5),
                            ],
                            Text(facility, style:facilityStle, textAlign: TextAlign.center),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lapangan.price,
                        style: regularFont3,
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.grey, size: 18),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Center(              
                    child: SizedBox(
                      width: 200,
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                        
                          },
                          style: shortButton3,
                          child: Text('Lihat Status Lapangan', style: buttonTextStyle, textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class ListFullLapang extends StatelessWidget {
//   const ListFullLapang({super.key});

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
//                     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     }),
//                 const SizedBox(width: 8),
//                 const Text(
//                   'Daftar Lapangan',
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
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 15),
//                     searchField(), // Field pencarian
//                     const SizedBox(height: 15),
//                     // Menampilkan beberapa widget lapangtersedia dalam bentuk list
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 10),
//                       child: Column(
//                         children: List.generate(
//                           3, // Ganti dengan jumlah lapangan yang ingin ditampilkan
//                           (index) => lapangtersedia(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget searchField() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           width: 300,
//           height: 30,
//           child: TextField(
//             textAlignVertical: const TextAlignVertical(y: -0.3),
//             decoration: InputDecoration(
//               prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
//               hintText: 'Cari lapangan yang dikelola',
//               hintStyle: cariStyle,
//               filled: true,
//               fillColor: const Color(0xffFFFFFF),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(
//                   color: Colors.grey,
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(
//                   color: Color.fromARGB(255, 149, 149, 149),
//                   width: 0.8,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Container(
//           height: 30,
//           width: 30,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: Colors.grey,
//               width: 0.8,
//             ),
//           ),
//           child: Center(
//             child: IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.add,
//                 color: Colors.grey,
//               ),
//               iconSize: 24,
//               padding: EdgeInsets.zero,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget lapangtersedia() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 3,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         height: 310,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 150,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(8),
//                   topLeft: Radius.circular(8),
//                 ),
//                 child: Image.asset(
//                   'images/lapangan.png',
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Golden',
//                     style: lampiranStyle,
//                     textAlign: TextAlign.left,
//                   ),
//                   Text(
//                     'Kota Semarang',
//                     style: ketStyle,
//                     textAlign: TextAlign.left,
//                   ),
//                   const SizedBox(height: 3),
//                   Row(
//                     children: [
//                       futsalbadge('Futsal'),
//                       const SizedBox(width: 8),
//                       badmintonbadge('Badminton'),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Rp. 60.000-80.000/jam',
//                         style: regularFont3,
//                       ),
//                       IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.edit,
//                           color: Colors.grey.withOpacity(0.8),
//                           size: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: shortButton3,
//                       child: Text(
//                         'Lihat Status Lapangan',
//                         style: buttonTextStyle,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget futsalbadge(String name) {
//     return Container(
//       height: 18,
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.grey.withOpacity(0.15),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.sports_soccer, size: 10),
//           const SizedBox(width: 6),
//           Text(name, style: facilityStle, textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }
//   Widget badmintonbadge(String name) {
//     return Container(
//       height: 18,
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.grey.withOpacity(0.15),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(MingCute.badminton_line, size: 10),
//           const SizedBox(width: 6),
//           Text(name, style: facilityStle, textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }
// }
