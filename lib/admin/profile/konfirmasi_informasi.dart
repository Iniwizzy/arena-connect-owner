import 'package:arena_connect/api/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KonfirmasiInformasiBankScreen extends StatelessWidget {
  final String bankName;
  final String accountNumber;
  final String accountName;
  final bool isMainAccount;

  const KonfirmasiInformasiBankScreen({
    super.key,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.isMainAccount,
  });

  @override
  Widget build(BuildContext context) {
    // Use Theme to override the font family
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      child: KonfirmasiInformasiBankPage(
        bankName: bankName,
        accountNumber: accountNumber,
        accountName: accountName,
        isMainAccount: isMainAccount,
      ),
    );
  }
}

class KonfirmasiInformasiBankPage extends StatefulWidget {
  final String bankName;
  final String accountNumber;
  final String accountName;
  final bool isMainAccount;

  const KonfirmasiInformasiBankPage({
    super.key,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.isMainAccount,
  });

  @override
  _KonfirmasiInformasiBankPageState createState() =>
      _KonfirmasiInformasiBankPageState();
}

class _KonfirmasiInformasiBankPageState
    extends State<KonfirmasiInformasiBankPage> {
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  Future<void> _submitToDatabase() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');
      final fieldCentreId = prefs.getString('field_centre_id');

      if (userId == null || fieldCentreId == null) {
        throw Exception('User ID or Field Centre ID not found');
      }

      final response = await _apiService.addBank(
        bankName: widget.bankName,
        accountNumber: widget.accountNumber,
        fieldCentreId: fieldCentreId,
        userId: userId,
      );

      setState(() {
        _isLoading = false;
      });

      if (response['success']) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Rekening bank berhasil ditambahkan'),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to profile page using named route
          Navigator.of(context).pushReplacementNamed('/profil');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['message'] ?? 'Gagal menambahkan rekening bank'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF12215C),
        titleSpacing: 0,
        title: const Text(
          "Konfirmasi Informasi Bank",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
          splashColor: Colors.white.withOpacity(0.3),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFF12215C),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldRow("Nama Bank", widget.bankName,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 8),
                      _buildFieldRow("No. Rekening", widget.accountNumber,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 8),
                      _buildFieldRow("Nama Lengkap", widget.accountName,
                          fontWeight: FontWeight.bold, hasDivider: false),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF489DD6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 2,
                    ),
                    onPressed: _isLoading ? null : _submitToDatabase,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "SELESAI",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFieldRow(String title, String value,
      {FontWeight fontWeight = FontWeight.normal, bool hasDivider = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF12215C),
              fontWeight: fontWeight,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF12215C),
              fontWeight: FontWeight.w300,
            ),
          ),
          if (hasDivider)
            const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
// import 'package:arena_connect/api/api.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:arena_connect/admin/profile/tambah_rekening2.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class KonfirmasiInformasiBankScreen extends StatelessWidget {
//   final String bankName;
//   final String accountNumber;
//   final String accountName;
//   final bool isMainAccount;

//   const KonfirmasiInformasiBankScreen({
//     super.key,
//     required this.bankName,
//     required this.accountNumber,
//     required this.accountName,
//     required this.isMainAccount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: GoogleFonts.poppins().fontFamily,
//         scaffoldBackgroundColor: const Color(0xFFF4F6F9),
//       ),
//       home: KonfirmasiInformasiBankPage(
//         bankName: bankName,
//         accountNumber: accountNumber,
//         accountName: accountName,
//         isMainAccount: isMainAccount,
//       ),
//     );
//   }
// }

// class KonfirmasiInformasiBankPage extends StatefulWidget {
//   final String bankName;
//   final String accountNumber;
//   final String accountName;
//   final bool isMainAccount;

//   const KonfirmasiInformasiBankPage({
//     super.key,
//     required this.bankName,
//     required this.accountNumber,
//     required this.accountName,
//     required this.isMainAccount,
//   });

//   @override
//   _KonfirmasiInformasiBankPageState createState() =>
//       _KonfirmasiInformasiBankPageState();
// }

// class _KonfirmasiInformasiBankPageState
//     extends State<KonfirmasiInformasiBankPage> {
//   bool _isLoading = false;
//   final ApiService _apiService = ApiService();

//   Future<void> _submitToDatabase() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       // Get user ID and field centre ID from SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getString('user_id');
//       final fieldCentreId = prefs.getString('field_centre_id');

//       if (userId == null || fieldCentreId == null) {
//         throw Exception('User ID or Field Centre ID not found');
//       }

//       // Submit to API
//       final response = await _apiService.addBank(
//         bankName: widget.bankName,
//         accountNumber: widget.accountNumber,
//         fieldCentreId: fieldCentreId,
//         userId: userId,
//       );

//       setState(() {
//         _isLoading = false;
//       });

//       if (response['success']) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Rekening bank berhasil ditambahkan'),
//               backgroundColor: Colors.green,
//             ),
//           );
//           // Navigate to profile page
//           Navigator.pushReplacementNamed(context, '/profil');
//         }
//       } else {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(response['message'] ?? 'Gagal menambahkan rekening bank'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
      
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF12215C),
//         titleSpacing: 0,
//         title: const Text(
//           "Konfirmasi Informasi Bank",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//             size: 18,
//           ),
//           onPressed: () => Navigator.pop(context),
//           splashColor: Colors.white.withOpacity(0.3),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 16),
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.white,
//                     border: Border.all(
//                       color: const Color(0xFF12215C),
//                       width: 1,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 6,
//                         spreadRadius: 1,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildFieldRow("Nama Bank", widget.bankName,
//                           fontWeight: FontWeight.bold),
//                       const SizedBox(height: 8),
//                       _buildFieldRow("No. Rekening", widget.accountNumber,
//                           fontWeight: FontWeight.bold),
//                       const SizedBox(height: 8),
//                       _buildFieldRow("Nama Lengkap", widget.accountName,
//                           fontWeight: FontWeight.bold, hasDivider: false),
//                     ],
//                   ),
//                 ),
//                 const Spacer(),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF489DD6),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       elevation: 2,
//                     ),
//                     onPressed: _isLoading ? null : _submitToDatabase,
//                     child: _isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             "SELESAI",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (_isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.3),
//               child: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFieldRow(String title, String value,
//       {FontWeight fontWeight = FontWeight.normal, bool hasDivider = true}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               color: const Color(0xFF12215C),
//               fontWeight: fontWeight,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 16,
//               color: const Color(0xFF12215C),
//               fontWeight: FontWeight.w300,
//             ),
//           ),
//           if (hasDivider)
//             const Divider(color: Colors.grey),
//         ],
//       ),
//     );
//   }
// }