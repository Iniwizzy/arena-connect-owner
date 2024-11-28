import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';

class TambahLapangan extends StatefulWidget {
  const TambahLapangan({Key? key}) : super(key: key);

  @override
  _TambahLapanganState createState() => _TambahLapanganState();
}

class _TambahLapanganState extends State<TambahLapangan> {
  List<bool> selectedStatus = List.filled(10, false);
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> pickImage() async {
    if (_selectedImages.length < 1) {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // aktifkan ini jika ingin coba crop (debug pakai hp)
        // CroppedFile? croppedFile = await ImageCropper().cropImage(
        //   sourcePath: pickedFile.path,
        //   aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
        // );

        // if (croppedFile != null) {
        //   setState(() {
        //     _selectedImages.add(File(croppedFile.path));
        //   });
        // }
        setState(() {
          _selectedImages.add(File(pickedFile.path)); // Use the original image
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Anda hanya dapat mengupload maksimal 1 gambar.')),
      );
    }
  }

  bool isFormFilled() {
    return _nameController.text.isNotEmpty &&
        _typeController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _selectedImages.length >= 1; // At least 3 images required
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Menutup keyboard saat klik di luar input
        },
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 7),
                  Text(
                    "Tambah Lapangan",
                    style: superFont2.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 27),
                  buildInputField(
                      labelText: "Nama lapangan", controller: _nameController),
                  const SizedBox(height: 24),
                  buildInputField(
                      labelText: "Jenis lapangan", controller: _typeController),
                  const SizedBox(height: 24),
                  buildInputField(
                      labelText: "Harga per Jam",
                      controller: _priceController,
                      inputType: TextInputType.number),
                  const SizedBox(height: 24),
                  buildInputField(
                      labelText: "Deskripsi",
                      maxLines: 4,
                      controller: _descriptionController),
                  const SizedBox(height: 38),
                  Text(
                    "Foto Lapangan",
                    style: superFont2.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: pickImage,
                    label: Text('Upload',
                        style: superFont4.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                    icon: const Icon(Icons.upload),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: white,
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        // Menambahkan border radius
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  buildImageGrid(),
                  const SizedBox(height: 55),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0), // Sesuaikan padding atas dan bawah
                      backgroundColor: isFormFilled()
                          ? primary
                          : Colors.grey
                              .shade400, // Change color based on form validation
                      shape: RoundedRectangleBorder(
                        // Menambahkan border radius
                        borderRadius: BorderRadius.circular(10),
                      ), // Warna latar belakang
                    ),
                    onPressed: isFormFilled()
                        ? () {
                            // Aksi tombol
                          }
                        : null, // Disable button if form is not filled
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Daftar',
                          style: superFont2.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500), // Warna teks
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _selectedImages.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Membuat gambar rounded
              child: Image.file(
                _selectedImages[index],
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            if (index == 0)
              Positioned(
                top: 83,
                left: 17,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(
                        8), // Membuat padding "Utama" rounded
                  ),
                ),
              ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedImages.removeAt(index);
                  });
                },
                child: const Icon(
                  Icons.cancel_sharp,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget buildInputField({
  required String labelText,
  TextInputType inputType = TextInputType.text,
  int? maxLines = 1,
  required TextEditingController controller,
}) {
  return TextFormField(
    controller: controller,
    keyboardType:
        inputType == TextInputType.text ? TextInputType.multiline : inputType,
    maxLines: maxLines,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: superFont2.copyWith(
        color: tertiary,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: tertiary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    ),
    style: superFont2.copyWith(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 15,
    ),
  );
}
