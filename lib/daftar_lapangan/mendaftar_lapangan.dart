import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';
import 'package:http/http.dart' as http;

class RegisterField extends StatefulWidget {
  const RegisterField({Key? key}) : super(key: key);

  @override
  _RegisterFieldState createState() => _RegisterFieldState();
}

class _RegisterFieldState extends State<RegisterField> {
  final List<String> options = [
    'Toilet',
    'Wi-fi',
    'Cafe & Resto',
    'Musholla',
    'Parkir Mobil',
    'Parkir Motor',
    'Ruang Ganti',
    'Tribun',
    'Jual Makanan',
    'Jual Minuman',
  ];

  List<bool> selectedStatus = List.filled(10, false);
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _rulesController = TextEditingController();
  bool isLoading = false;

  // Future<void> getFields() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     http.Response res = await http.get(Uri)
  //   }
  // }

  Future<void> pickImage() async {
    if (_selectedImages.length < 5) {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
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
            content: Text('Anda hanya dapat mengupload maksimal 5 gambar.')),
      );
    }
  }

  bool isFormFilled() {
    return _nameController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _rulesController.text.isNotEmpty &&
        _selectedImages.length >= 3; // At least 3 images required
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
          FocusScope.of(context).unfocus();
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
                    "Informasi Lapangan",
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
                      labelText: "Lokasi", controller: _locationController),
                  const SizedBox(height: 24),
                  buildInputField(
                      labelText: "Deskripsi",
                      maxLines: 4,
                      controller: _descriptionController),
                  const SizedBox(height: 24),
                  buildInputField(
                      labelText: "Aturan lapangan",
                      maxLines: 4,
                      controller: _rulesController),
                  const SizedBox(height: 38),
                  Text(
                    "Fasilitas Lapangan",
                    style: superFont2.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 13),
                  buildFacilitiesSelection(),
                  const SizedBox(height: 38),
                  Text(
                    "Foto Lapangan (minimal 3)",
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
                          vertical: 15.0, horizontal: 20.0),
                      backgroundColor:
                          isFormFilled() ? primary : Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isFormFilled()
                        ? () {
                            Navigator.pushNamed(context, '/tambahlapangan');
                          }
                        : null, // Disable button if form is not filled
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selanjutnya',
                          style: superFont2.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: Colors.white),
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

  Widget buildFacilitiesSelection() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4.5,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedStatus[index] = !selectedStatus[index];
            });
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: selectedStatus[index] ? primary : white,
              borderRadius: BorderRadius.circular(20.0),
              border: selectedStatus[index]
                  ? Border.all(color: primary)
                  : Border.all(color: tertiary),
            ),
            child: Center(
              child: Text(
                options[index],
                style: superFont2.copyWith(
                  color: selectedStatus[index] ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
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
              borderRadius: BorderRadius.circular(10),
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Utama",
                    style: superFont4.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
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
