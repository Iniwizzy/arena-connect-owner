// import 'dart:convert';

// import 'package:arena_connect/api/api.dart';
// import 'package:flutter/material.dart';
// import 'package:arena_connect/config/theme.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:arena_connect/model/res_user.dart';
// import 'package:http/http.dart' as http;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool isLoading = false;
//   List<User> listUser = [];
//   List<User> filteredUser = [];

//   // Simulated fetch function
//   // Future<String> fetchUser() async {
//   //   // Replace this with your actual API call logic
//   //   await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
//   //   return "Brian"; // Simulated API response
//   // }

//   Future<void> getUser() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       String? token = await ApiService().getToken();
//       if (token == null) {
//         throw Exception('Token not found');
//       }
//       http.Response res = await http.get(
//         Uri.parse("$baseUrl/users"),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       List<User>? data = resUserFromJson(res.body).data;
//       setState(() {
//         isLoading = false;
//         listUser = data ?? [];
//         filteredUser = listUser;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(e.toString()),
//             backgroundColor: Colors.green,
//           ),
//         );
//       });
//     }
//   }
// // class _HomePageState extends State<HomePage> {
// //   Future<String>? userName;

// //   // Replace with your actual API endpoint
// //   final String baseUrl = "https://yourapi.com";

// //   Future<String> fetchUser() async {
// //     try {
// //       // Assuming you need to pass a token for authorization
// //       String? token = await ApiService().getToken();
// //       if (token == null) {
// //         throw Exception('Token not found');
// //       }

// //       // Perform the GET request
// //       final response = await http.get(
// //         Uri.parse("$baseUrl/users"),
// //         headers: {'Authorization': 'Bearer $token'},
// //       );

// //       // Check if the response is successful
// //       if (response.statusCode == 200) {
// //         // Parse the JSON data
// //         final data = json.decode(response.body);
// //         // Assuming `name` is the field in the JSON data
// //         return data['name'] ?? 'No Name';
// //       } else {
// //         throw Exception('Failed to load user');
// //       }
// //     } catch (e) {
// //       throw Exception("Error fetching user: $e");
// //     }
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     userName = fetchUser();
// //   }

//   @override
//   void initState() {
//     super.initState();
//     // name = fetchUser();
//     getUser();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primary,
//       appBar: PreferredSize(
//         preferredSize:
//             const Size.fromHeight(80), // Atur ukuran tinggi sesuai kebutuhan
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           flexibleSpace: Padding(
//             padding:
//                 const EdgeInsets.only(top: 45.0), // Memberikan padding atas
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20),
//                   child: Image.asset(
//                     "images/img_logopng2_1.png",
//                     height: 26,
//                     width: 70,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.pushNamed(context, '/search');
//                       },
//                       borderRadius: BorderRadius.circular(50),
//                       highlightColor: white.withOpacity(0.2),
//                       splashColor: white.withOpacity(0.2),
//                       child: const SizedBox(
//                         height: 45,
//                         width: 45,
//                         child:
//                             Icon(Icons.search, size: 25, color: Colors.white),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         Navigator.pushNamed(context, '/notifikasi');
//                       },
//                       borderRadius: BorderRadius.circular(50),
//                       highlightColor: white.withOpacity(0.2),
//                       splashColor: white.withOpacity(0.2),
//                       child: const SizedBox(
//                         height: 45,
//                         width: 45,
//                         child: Icon(Icons.notifications,
//                             size: 25, color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(width: 25),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 const SizedBox(height: 15),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 47),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 100, // Adjust height to fit your design
//                           child: ListView.builder(
//                             itemCount: filteredUser.length,
//                             itemBuilder: (context, index) {
//                               return RichText(
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: "Hi, ",
//                                       style: superFont2.copyWith(
//                                         color: Colors.white,
//                                         fontSize: 26,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                     TextSpan(
//                                       text:
//                                           filteredUser[index].name ?? 'No Name',
//                                       style: superFont2.copyWith(
//                                         color: Colors.white,
//                                         fontSize: 26,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 textAlign: TextAlign.left,
//                               );
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           "Selamat datang",
//                           style: superFont2.copyWith(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 18,
//                           ),
//                         ),
//                         const SizedBox(height: 22),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),

//                 // Bagian Putih bawah
//                 Expanded(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft:
//                             Radius.circular(30.0), // Lengkungan di kiri atas
//                         topRight:
//                             Radius.circular(30.0), // Lengkungan di kanan atas
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 30),
//                         _listBar(context),
//                         const SizedBox(height: 30),
//                         _ringkasan(context),
//                         const SizedBox(height: 30),
//                         _pemesanan(context),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//       bottomNavigationBar: _BottomNavigation(context),
//     );
//   }
// }

// Widget _listBar(BuildContext context) {
//   return Row(
//     mainAxisAlignment:
//         MainAxisAlignment.spaceEvenly, // Mengatur jarak antar item
//     children: [
//       Column(
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.pushNamed(context, '/fieldsearch');
//             },
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 46,
//                   width: 46,
//                   child: SvgPicture.asset(
//                     "images/lapangan_icon.svg",
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   "Lapangan",
//                   style: superFont2.copyWith(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       Column(
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.pushNamed(context, '/kalender');
//             },
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 46,
//                   width: 46,
//                   child: SvgPicture.asset(
//                     "images/calendar_icon.svg",
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   "Kalender",
//                   style: superFont2.copyWith(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       Column(
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.pushNamed(context, '/kompetisi');
//             },
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 46,
//                   width: 46,
//                   child: SvgPicture.asset(
//                     "images/kompetisi_icon.svg",
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   "Kompetisi",
//                   style: superFont2.copyWith(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }

// Widget _ringkasan(BuildContext context) {
//   return SizedBox(
//       child: Padding(
//           // color: Colors.red,
//           padding: const EdgeInsets.only(left: 34, right: 34),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Ringkasan Aktivitas",
//                   style: superFont2.copyWith(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 Text(
//                   "Aktivitas penyewaan 30 hari terakhir",
//                   style: superFont2.copyWith(
//                       color: tertiary,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400),
//                 ),
//                 const SizedBox(height: 8),
//                 SizedBox(
//                   width: double.maxFinite,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: _ringkasanTransaksi(
//                           context,
//                           transactionMessage: "Pendapatan",
//                           transactionAmount: "0",
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: _ringkasanTransaksi(
//                           context,
//                           transactionMessage: "Transaksi Berhasil",
//                           transactionAmount: "0",
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )));
// }

// Widget _ringkasanTransaksi(
//   BuildContext context, {
//   required String transactionMessage,
//   required String transactionAmount,
// }) {
//   return Container(
//     padding: const EdgeInsets.only(
//       left: 8,
//       top: 4,
//       bottom: 4,
//     ),
//     decoration: BoxDecoration(
//       color: const Color(0XFFFFFFFF),
//       borderRadius: BorderRadius.circular(6),
//       boxShadow: const [
//         BoxShadow(
//           color: Color(0X11000000),
//           spreadRadius: 2,
//           blurRadius: 2,
//           offset: Offset(
//             0,
//             4,
//           ),
//         )
//       ],
//     ),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(transactionMessage,
//             style: superFont4.copyWith(
//                 color: Colors.black, fontWeight: FontWeight.w400)),
//         Text(
//           transactionAmount,
//           style: superFont2.copyWith(color: Colors.black, fontSize: 15),
//         ),
//         const SizedBox(height: 14)
//       ],
//     ),
//   );
// }

// Widget _pemesanan(BuildContext context) {
//   return SizedBox(
//     child: Container(
//       padding: const EdgeInsets.only(left: 34, right: 34),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Riwayat Pemesanan",
//               style: superFont2.copyWith(
//                   color: Colors.black,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500),
//             ),
//             const Spacer(),
//             Text(
//               "Lihat Semua",
//               style: superFont2.copyWith(
//                   color: Colors.black,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w400),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 top: 3,
//                 left: 8,
//               ),
//               child: SizedBox(
//                 height: 12,
//                 width: 8,
//                 child: SvgPicture.asset(
//                   "images/img_vector_12x6.svg",
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// Widget _BottomNavigation(BuildContext context) {
//   return Container(
//     color: Colors.white,
//     padding: const EdgeInsets.symmetric(vertical: 10), // Padding vertikal
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _bottomNavItem(context, '/home', Icons.home, "Beranda", true),
//         _bottomNavItem(context, '/pesanan', Icons.book, "Pesanan", false),
//         _bottomNavItem(
//             context, '/pembayaran', Icons.payments_sharp, "Transaksi", false),
//         _bottomNavItem(
//             context, '/laporankeuangan', Icons.bar_chart, "Laporan", false),
//         _bottomNavItem(context, '/profil', Icons.person, "Profil", false),
//       ],
//     ),
//   );
// }

// Widget _bottomNavItem(BuildContext context, String route, IconData icon,
//     String label, bool isActive) {
//   return InkWell(
//     onTap: () {
//       Navigator.pushNamed(context, route);
//     },
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, color: isActive ? const Color(0xFF0D2C76) : Colors.grey),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontFamily: 'Poppins', // Mengatur font menjadi Poppins
//             fontSize: 12,
//             color: isActive ? const Color(0xFF0D2C76) : Colors.grey,
//           ),
//         )
//       ],
//     ),
//   );
// }
