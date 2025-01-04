import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const UbahPasswordScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UbahPasswordScreen extends StatefulWidget {
  const UbahPasswordScreen({super.key});

  @override
  _UbahPasswordScreenState createState() => _UbahPasswordScreenState();
}

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validatePassword);
    _passwordController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    final bool isPasswordFilled = _passwordController.text.isNotEmpty;
    if (isPasswordFilled != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = isPasswordFilled;
      });
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Text(
            'Simpan Perubahan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2C57), // Sesuaikan dengan warna teks
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Apakah kamu yakin ingin menyimpan perubahan?',
            style: TextStyle(
              color: Color(0xFF1F2C57), // Sesuaikan dengan warna teks
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1F2C57), // Warna biru tua (Kembali)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'Kembali',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                    _showSuccessMessage(); // Tampilkan pesan sukses
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF57B1EB), // Warna biru muda (Simpan)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sandi anda berhasil diperbarui!'),
        backgroundColor: Colors.lime,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Masukkan kata sandi baru',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Kata sandi baru',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                        _showConfirmationDialog(); // Tampilkan dialog konfirmasi
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isButtonEnabled ? Colors.blue : Colors.grey,
                ),
                child: const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
