import 'dart:io';
import 'package:arena_connect/api/api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/admin/config/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Facility {
  final int id;
  final String name;

  Facility({required this.id, required this.name});

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      id: json['id'],
      name: json['name'],
    );
  }
}

class RegisterField extends StatefulWidget {
  const RegisterField({Key? key}) : super(key: key);

  @override
  _RegisterFieldState createState() => _RegisterFieldState();
}

class _RegisterFieldState extends State<RegisterField> {
  List<Facility> _facilities = [];
  List<bool> _selectedFacilities = [];

  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionsController = TextEditingController();
  final TextEditingController _rulesController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mapsController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _priceFromController = TextEditingController();

  final ApiService _apiService = ApiService();
  bool isLoading = false;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchFacilities();
  }

  Future<void> _fetchFacilities() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await _apiService.getFacilities();
      if (response['success']) {
        setState(() {
          _facilities = (response['data'] as List)
              .map((facility) => Facility.fromJson(facility))
              .toList();
          _selectedFacilities = List.filled(_facilities.length, false);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message'] ?? 'Gagal mengambil fasilitas'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionsController.dispose();
    _rulesController.dispose();
    _addressController.dispose();
    _mapsController.dispose();
    _phoneNumberController.dispose();
    _priceFromController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    if (_selectedImages.length <= 5) {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImages.add(File(pickedFile.path));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Anda hanya dapat mengupload maksimal 5 gambar.')),
      );
    }
  }

  Future<void> submitField() async {
    if (!isFormFilled()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap lengkapi semua field'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      // Get logged in user ID from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');

      if (userId == null) {
        throw Exception('User ID not found. Please login again.');
      }
      // Get selected facility IDs
      List<int> selectedFacilitiesIds = []; // Make sure this line is correct
      for (var i = 0; i < _facilities.length; i++) {
        if (_selectedFacilities[i]) {
          selectedFacilitiesIds.add(_facilities[i].id);
        }
      }

      // Debug print
      print('Valid Facility IDs: $selectedFacilitiesIds');
      print('Facility IDs type: ${selectedFacilitiesIds.runtimeType}');

      final result = await _apiService.registerField(
        userId: userId,
        name: _nameController.text,
        descriptions: _descriptionsController.text,
        rules: _rulesController.text,
        address: _addressController.text,
        maps: _mapsController.text,
        phoneNumber: _phoneNumberController.text,
        priceFrom: _priceFromController.text,
        facilityIds: selectedFacilitiesIds, // Use the correct variable name
        images: _selectedImages,
        rating: '4.5',
        // type: '',
      );

      // Tambahan debug print untuk response
      print('API Response: $result');

      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lapangan berhasil didaftarkan')),
        );
        Navigator.pushNamed(context, '/profile');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                result['errors']['message'] ?? 'Gagal mendaftarkan lapangan'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool isFormFilled() {
    return _nameController.text.isNotEmpty &&
        _descriptionsController.text.isNotEmpty &&
        _rulesController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _mapsController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty &&
        _priceFromController.text.isNotEmpty &&
        _selectedImages.isNotEmpty &&
        _selectedFacilities.contains(true);
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Informasi Lapangan",
                          style: superFont2.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 27),
                        buildInputField(
                            labelText: "Nama Lapangan",
                            controller: _nameController),
                        const SizedBox(height: 24),
                        buildInputField(
                            labelText: "Deskripsi",
                            maxLines: 4,
                            controller: _descriptionsController),
                        const SizedBox(height: 24),
                        buildInputField(
                            labelText: "Aturan Lapangan",
                            maxLines: 4,
                            controller: _rulesController),
                        const SizedBox(height: 24),
                        buildInputField(
                            labelText: "Alamat Lengkap",
                            controller: _addressController,
                            maxLines: 2),
                        const SizedBox(height: 24),
                        buildInputField(
                            labelText: "Link Google Maps",
                            controller: _mapsController),
                        const SizedBox(height: 24),
                        buildInputField(
                            labelText: "Nomor Telepon",
                            controller: _phoneNumberController,
                            inputType: TextInputType.phone),
                        const SizedBox(height: 24),
                        buildInputField(
                            labelText: "Harga Mulai",
                            controller: _priceFromController,
                            inputType: TextInputType.number),
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
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
                          onPressed: isFormFilled() && !isSubmitting
                              ? submitField
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isSubmitting ? 'Mengirim...' : 'Daftarkan',
                                style: superFont2.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (!isSubmitting)
                                // const Icon(Icons.arrow_forward_ios,
                                //     color: Colors.white),
                                if (isSubmitting)
                                  const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
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
      itemCount: _facilities.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedFacilities[index] = !_selectedFacilities[index];
            });
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: _selectedFacilities[index] ? primary : white,
              borderRadius: BorderRadius.circular(20.0),
              border: _selectedFacilities[index]
                  ? Border.all(color: primary)
                  : Border.all(color: tertiary),
            ),
            child: Center(
              child: Text(
                _facilities[index].name,
                style: superFont2.copyWith(
                  color:
                      _selectedFacilities[index] ? Colors.white : Colors.black,
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
