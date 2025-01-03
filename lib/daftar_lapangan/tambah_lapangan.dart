import 'dart:io';
import 'package:arena_connect/api/api.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahLapangan extends StatefulWidget {
  final String? fieldCentreId; // Make this optional

  const TambahLapangan({
    Key? key,
    this.fieldCentreId, // Remove the required attribute
  }) : super(key: key);

  @override
  _TambahLapanganState createState() => _TambahLapanganState();
}

class _TambahLapanganState extends State<TambahLapangan> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionsController = TextEditingController();

  String _selectedType = 'Futsal';
  String _selectedStatus = 'Tersedia';
  bool isSubmitting = false;

  final List<String> _types = ['Futsal', 'Badminton'];
  final List<String> _statuses = [
    'Tersedia',
    'Telah dibooking',
    'Dalam perbaikan',
    'Tidak tersedia'
  ];

  final ApiService _apiService = ApiService();

  bool isFormFilled() {
    return _nameController.text.isNotEmpty &&
        _descriptionsController.text.isNotEmpty;
  }

  Future<void> submitField() async {
    // Validate form before submission
    if (!isFormFilled()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi semua field yang diperlukan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      // Comprehensive debugging for field centre ID
      final prefs = await SharedPreferences.getInstance();

      // Check all possible sources of field centre ID
      String? widgetFieldCentreId = widget.fieldCentreId;
      String? prefsFieldCentreId = prefs.getString('field_centre_id');

      print('Widget Field Centre ID: $widgetFieldCentreId');
      print('Prefs Field Centre ID: $prefsFieldCentreId');

      // Prioritize sources of field centre ID
      String? fieldCentreId = widgetFieldCentreId ?? prefsFieldCentreId;

      // Print all SharedPreferences keys to debug
      print('All SharedPreferences keys:');
      print(prefs.getKeys());

      if (fieldCentreId == null || fieldCentreId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Field Centre ID tidak ditemukan. Silakan tambah Field Centre terlebih dahulu.'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          isSubmitting = false;
        });
        return;
      }

      print('Using Field Centre ID: $fieldCentreId');

      final result = await _apiService.addField(
        name: _nameController.text,
        fieldCentreId: fieldCentreId,
        type: _selectedType,
        descriptions: _descriptionsController.text,
        status: _selectedStatus,
      );

      // Debug print the entire result
      print('Add Field Result: $result');

      // Detailed error handling
      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Lapangan berhasil ditambahkan'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context,
            '/daftarlapang'); // Return true to indicate successful addition
      } else {
        // Handle specific validation errors
        if (result['errors'] != null) {
          String errorMessage = '';
          Map<String, dynamic> errors = result['errors'];

          errors.forEach((key, value) {
            if (value is List) {
              errorMessage += '${value.join('\n')}\n';
            } else {
              errorMessage += '$value\n';
            }
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage.isNotEmpty
                  ? errorMessage
                  : (result['message'] ?? 'Gagal menambahkan lapangan')),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          // Generic error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Gagal menambahkan lapangan'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('Catch block error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tambah Lapangan",
                style: superFont2.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 27),

              buildInputField(
                  labelText: "Nama Lapangan", controller: _nameController),
              const SizedBox(height: 24),

              // Type Dropdown
              Text(
                "Jenis Lapangan",
                style: superFont2.copyWith(
                  color: tertiary,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: tertiary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedType,
                  underline: Container(),
                  items: _types.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),

              buildInputField(
                  labelText: "Deskripsi",
                  maxLines: 4,
                  controller: _descriptionsController),
              const SizedBox(height: 24),

              // Status Dropdown
              Text(
                "Status",
                style: superFont2.copyWith(
                  color: tertiary,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: tertiary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedStatus,
                  underline: Container(),
                  items: _statuses.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStatus = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor:
                      isFormFilled() ? primary : Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: isFormFilled() && !isSubmitting ? submitField : null,
                child: Center(
                  child: isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Tambah Lapangan',
                          style: superFont2.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Utility method for input fields (assumed to be defined elsewhere)
  Widget buildInputField({
    required String labelText,
    TextEditingController? controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: superFont2.copyWith(
            color: tertiary,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: tertiary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: tertiary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primary),
            ),
          ),
        ),
      ],
    );
  }
}
