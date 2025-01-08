import 'package:flutter/material.dart';
import 'package:arena_connect/admin/profile/konfirmasi_informasi.dart';
import 'package:arena_connect/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahRekeningScreen extends StatelessWidget {
  const TambahRekeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TambahRekeningPage();
  }
}

class TambahRekeningPage extends StatefulWidget {
  const TambahRekeningPage({super.key});

  @override
  _TambahRekeningPageState createState() => _TambahRekeningPageState();
}

class _TambahRekeningPageState extends State<TambahRekeningPage> {
  bool _isRekeningUtama = true;
  String? selectedBank;
  bool _isLoading = false;
  
  final List<String> banks = ['BRI', 'BNI', 'Mandiri', 'BCA', 'Dana', 'Ovo', 'Gopay'];
  
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _noRekeningController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    _namaController.dispose();
    _noRekeningController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && selectedBank != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KonfirmasiInformasiBankScreen(
            bankName: selectedBank!,
            accountNumber: _noRekeningController.text,
            accountName: _namaController.text,
            isMainAccount: _isRekeningUtama,
          ),
        ),
      );
    } else if (selectedBank == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih bank terlebih dahulu'),
          backgroundColor: Colors.red,
        ),
      );
    }
    //   setState(() {
    //     _isLoading = true;
    //   });

    //   try {
    //     // Get user ID and field centre ID from SharedPreferences
    //     final prefs = await SharedPreferences.getInstance();
    //     final userId = prefs.getString('user_id');
    //     final fieldCentreId = prefs.getString('field_centre_id');

    //     if (userId == null || fieldCentreId == null) {
    //       throw Exception('User ID or Field Centre ID not found');
    //     }

    //     // Prepare data for API call
    //     final response = await _apiService.addBank(
    //       bankName: selectedBank!,
    //       accountNumber: _noRekeningController.text,
    //       fieldCentreId: fieldCentreId,
    //       userId: userId,
    //     );

    //     setState(() {
    //       _isLoading = false;
    //     });

    //     if (response['success']) {
    //       // Show success message
    //       if (mounted) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           const SnackBar(
    //             content: Text('Rekening bank berhasil ditambahkan'),
    //             backgroundColor: Colors.green,
    //           ),
    //         );
            
    //         // Navigate to confirmation screen
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => const KonfirmasiInformasiBankScreen(),
    //           ),
    //         );
    //       }
    //     } else {
    //       if (mounted) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(
    //             content: Text(response['message'] ?? 'Gagal menambahkan rekening bank'),
    //             backgroundColor: Colors.red,
    //           ),
    //         );
    //       }
    //     }
    //   } catch (e) {
    //     setState(() {
    //       _isLoading = false;
    //     });
        
    //     if (mounted) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text('Error: $e'),
    //           backgroundColor: Colors.red,
    //         ),
    //       );
    //     }
    //   }
    // } else if (selectedBank == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Silakan pilih bank terlebih dahulu'),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
  }

  // Rest of the existing UI code remains the same until the ElevatedButton
  @override
  Widget build(BuildContext context) {
    // Previous UI code remains the same...
    
    // Update only the ElevatedButton onPressed handler
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF12215C),
        titleSpacing: 0,
        title: const Text(
          "Tambah Rekening Bank",
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
          onPressed: () {
            Navigator.pushNamed(context, '/profil');
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildFormField(
                    "Nama Lengkap",
                    _namaController,
                    TextInputType.name,
                  ),
                  const SizedBox(height: 10),
                  _buildBankDropdown(),
                  const SizedBox(height: 10),
                  _buildFormField(
                    "No. Rekening",
                    _noRekeningController,
                    TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Atur Sebagai Rekening Utama",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF12215C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isRekeningUtama = !_isRekeningUtama;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 50,
                          height: 28,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _isRekeningUtama
                                ? const Color(0xFF489DD6)
                                : const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: _isRekeningUtama
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                        elevation: 5,
                      ),
                      onPressed: _isLoading ? null : _submitForm,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "SIMPAN",
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

  // Existing _buildFormField and _buildBankDropdown methods remain the same...
  Widget _buildFormField(
    String label,
    TextEditingController controller,
    TextInputType keyboardType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF12215C),
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field ini tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildBankDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nama Bank",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF12215C),
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedBank,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF489DD6),
            ),
            hint: const Text(
              'Pilih Bank',
              style: TextStyle(
                color: Color(0xFF489DD6),
              ),
            ),
            items: banks.map((String bank) {
              return DropdownMenuItem<String>(
                value: bank,
                child: Text(
                  bank,
                  style: const TextStyle(
                    color: Color(0xFF12215C),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedBank = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFieldRow(String title, String value,
      {bool isBankField = false, FontWeight fontWeight = FontWeight.normal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF12215C),
              fontWeight: fontWeight, // Menyesuaikan ketebalan teks
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: isBankField
                      ? const Color(0xFF489DD6) // Warna biru untuk "BNI"
                      : const Color(0xFF12215C),
                  fontWeight: fontWeight, // Menyesuaikan ketebalan teks
                ),
              ),
              if (isBankField)
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF489DD6), // Ikon juga diberi warna biru
                ),
            ],
          ),
        ],
      ),
    );
  }
}