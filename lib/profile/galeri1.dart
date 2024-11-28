import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:google_fonts/google_fonts.dart';
import 'package:arena_connect/profile/galeri.dart' as galeripage;
import 'package:arena_connect/profile/editprofil1.dart';

void main() {
  runApp(CropImageScreen());
}

class CropImageScreen extends StatelessWidget {
  const CropImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageCropperPage(),
    );
  }
}

class ImageCropperPage extends StatefulWidget {
  const ImageCropperPage({super.key});

  @override
  _ImageCropperPageState createState() => _ImageCropperPageState();
}

class _ImageCropperPageState extends State<ImageCropperPage> {
  CroppedFile? _imageFile;
  CroppedFile? _croppedFile;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = CroppedFile(pickedFile.path);
      });
    }
  }

  Future<void> _cropImage() async {
    if (_imageFile == null) return;

    // Membaca file sebagai Uint8List untuk digunakan oleh image package
    final Uint8List imageBytes = await File(_imageFile!.path).readAsBytes();
    final img.Image? originalImage = img.decodeImage(imageBytes);

    if (originalImage != null) {
      final int width = originalImage.width;
      final int height = originalImage.height;

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _imageFile!.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        maxWidth: width,
        maxHeight: height,
      );

      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 33, 92, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 33, 92, 1),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: _croppedFile == null
                  ? _imageFile == null
                      ? Image.asset('images/galeri6.jpg')
                      : Image.file(File(_imageFile!.path))
                  : Image.file(File(_croppedFile!.path)),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const galeripage.GaleriPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Batal',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: Colors.white),
                  onPressed: _cropImage,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile1Screen(),
                      ),
                    );
                  },
                  child: Text(
                    'Selesai',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: _BottomNavigation(context),
    );
  }
}

Widget _BottomNavigation(BuildContext context) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 10), // Padding vertikal
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _bottomNavItem(context, '/home', Icons.home, "Beranda", false),
        _bottomNavItem(context, '/pesanan', Icons.book, "Pesanan", false),
        _bottomNavItem(
            context, '/pembayaran', Icons.payments_sharp, "Transaksi", false),
        _bottomNavItem(
            context, '/laporankeuangan', Icons.bar_chart, "Laporan", false),
        _bottomNavItem(context, '/profil', Icons.person, "Profil", true),
      ],
    ),
  );
}

Widget _bottomNavItem(BuildContext context, String route, IconData icon,
    String label, bool isActive) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, route);
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF0D2C76) : Colors.grey),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins', // Mengatur font menjadi Poppins
            fontSize: 12,
            color: isActive ? const Color(0xFF0D2C76) : Colors.grey,
          ),
        )
      ],
    ),
  );
}
