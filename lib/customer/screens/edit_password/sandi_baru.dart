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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
        backgroundColor: Colors.blue, // Sesuaikan warna AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Logika untuk kembali
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        // Agar konten berada di tengah
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Supaya kolom menyesuaikan konten
            crossAxisAlignment:
                CrossAxisAlignment.center, // Untuk menempatkan konten di tengah
            children: [
              const Text(
                'Masukkan kata sandi baru',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center, // Agar teks di tengah
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true, // Agar input sandi tidak terlihat
                decoration: const InputDecoration(
                  labelText: 'Kata sandi baru',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                        // Tambahkan logika ketika tombol ditekan
                        print('Simpan Perubahan');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isButtonEnabled
                      ? Colors.blue
                      : Colors.grey, // Ubah warna tombol berdasarkan status
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
