import 'package:flutter/material.dart';


class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    for (var controller in otpControllers) {
      controller.addListener(_checkOtpFilled);
    }
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _checkOtpFilled() {
    bool filled = otpControllers.every((controller) => controller.text.isNotEmpty);
    setState(() {
      isButtonEnabled = filled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF192C6B), // warna biru tua
        elevation: 0,
        title: Text(
          'Ubah Password',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Aksi untuk ikon tambahan (opsional)
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ketik kode verifikasi yang telah dikirim ke alamat email anda',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),

            // Kotak untuk kode OTP (6 buah TextField)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return Container(
                  width: 40,
                  child: TextField(
                    controller: otpControllers[index],
                    onChanged: (value) {
                      if (value.length == 1 && index != 5) {
                        FocusScope.of(context).nextFocus(); // Pindah ke TextField berikutnya
                      } else if (value.isEmpty && index != 0) {
                        FocusScope.of(context).previousFocus(); // Pindah ke TextField sebelumnya
                      }
                    },
                    textAlign: TextAlign.center,
                    maxLength: 1, // Maksimum 1 karakter
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '', // Hilangkan hitungan karakter di bawah
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: isButtonEnabled
                  ? () {
                      // Aksi saat tombol diklik jika aktif
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isButtonEnabled
                    ? Color(0xFF4C9EEB)
                    : Color(
                        0xFFADB5BD), // Biru saat aktif, abu-abu saat tidak aktif
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Kirim Kode OTP',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
