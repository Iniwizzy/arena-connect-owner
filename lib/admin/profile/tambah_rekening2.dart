import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arena_connect/admin/profile/konfirmasi_informasi.dart';

class TambahRekeningScreen extends StatelessWidget {
  const TambahRekeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hapus MaterialApp di sini karena akan menyebabkan context baru
    return const TambahRekeningPage();
  }
}

class TambahRekeningPage extends StatefulWidget {
  const TambahRekeningPage({super.key});

  @override
  _TambahRekeningPageState createState() => _TambahRekeningPageState();
}

class _TambahRekeningPageState extends State<TambahRekeningPage> {
  int _currentIndex = 4;
  bool _isRekeningUtama = true;
  String? selectedBank;

  // List of available banks
  final List<String> banks = ['BRI', 'BNI', 'Mandiri', 'BCA'];

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _noRekeningController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _noRekeningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          // Add this wrapper
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
                const SizedBox(
                  height: 20,
                ),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          selectedBank != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const KonfirmasiInformasiBankScreen(),
                          ),
                        );
                      } else if (selectedBank == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Silakan pilih bank terlebih dahulu'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        const SizedBox(
                          height: 20,
                        );
                      }
                    },
                    child: const Text(
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
      ),
    );
  }

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
