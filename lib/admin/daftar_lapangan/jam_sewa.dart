import 'package:arena_connect/admin/config/theme.dart';
import 'package:arena_connect/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JamSewaPage extends StatefulWidget {
  final String fieldId; // Add field ID parameter

  const JamSewaPage({super.key, required this.fieldId}); // Update constructor

  @override
  _JamSewaPageState createState() => _JamSewaPageState();
}

class _JamSewaPageState extends State<JamSewaPage> {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  final Map<String, Map<String, TextEditingController>> jamControllers = {
    'Sesi Pagi': {
      'start': TextEditingController(),
      'end': TextEditingController()
    },
    'Sesi Siang': {
      'start': TextEditingController(),
      'end': TextEditingController()
    },
    'Sesi Sore': {
      'start': TextEditingController(),
      'end': TextEditingController()
    },
    'Sesi Malam': {
      'start': TextEditingController(),
      'end': TextEditingController()
    },
  };

  Future<void> _saveSchedules() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Prepare the data
      List<Map<String, dynamic>> schedules = [];
      
      jamControllers.forEach((session, controllers) {
        // Validate time format
        String startTime = _formatTimeInput(controllers['start']!.text);
        String endTime = _formatTimeInput(controllers['end']!.text);
        
        if (startTime.isEmpty || endTime.isEmpty) {
          throw Exception('Format waktu tidak valid. Gunakan format HH:mm');
        }

        schedules.add({
          'session': session,
          'start_time': startTime,
          'end_time': endTime,
          'price': int.parse(hargaControllers[session]!.text.replaceAll(RegExp(r'[^0-9]'), '')),
        });
      });

      final result = await _apiService.saveFieldSchedules(
        fieldId: widget.fieldId, // Use the passed field ID
        schedules: schedules,
      );

      if (result['status'] == true) { // Updated to match API response
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jadwal berhasil disimpan')),
        );
        Navigator.pop(context);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Gagal menyimpan jadwal')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Helper method to format time input
  String _formatTimeInput(String input) {
    // Remove any non-digit characters
    String digits = input.replaceAll(RegExp(r'[^0-9:]'), '');
    
    // If input contains colon, validate the format
    if (digits.contains(':')) {
      List<String> parts = digits.split(':');
      if (parts.length == 2) {
        int? hours = int.tryParse(parts[0]);
        int? minutes = int.tryParse(parts[1]);
        
        if (hours != null && minutes != null && 
            hours >= 0 && hours < 24 && 
            minutes >= 0 && minutes < 60) {
          return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
        }
      }
    }
    
    return '';
  }

  final Map<String, IconData> kategoriIcons = {
    'Sesi Pagi': Icons.wb_sunny_outlined, // Ikon untuk pagi
    'Sesi Siang': Icons.sunny, // Ikon untuk siang
    'Sesi Sore': Icons.sunny_snowing, // Ikon untuk sore
    'Sesi Malam': Icons.nightlight_outlined, // Ikon untuk malam
  };

  final Map<String, TextEditingController> hargaControllers = {
    'Sesi Pagi': TextEditingController(),
    'Sesi Siang': TextEditingController(),
    'Sesi Sore': TextEditingController(),
    'Sesi Malam': TextEditingController(),
  };

  bool get allFieldsFilled {
    for (var controllers in jamControllers.values) {
      if (controllers['start']!.text.trim().isEmpty ||
          controllers['end']!.text.trim().isEmpty) return false;
    }
    for (var controller in hargaControllers.values) {
      if (controller.text.trim().isEmpty) return false;
    }
    return true;
  }

  void checkFields() {
    print("Jam Controllers:");
    jamControllers.forEach((kategori, controllers) {
      print(
          "$kategori Start: ${controllers['start']!.text}, End: ${controllers['end']!.text}");
    });

    print("Harga Controllers:");
    hargaControllers.forEach((kategori, controller) {
      print("$kategori Harga: ${controller.text}");
    });

    print("All Fields Filled: $allFieldsFilled");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, left: 15),
            height: 100,
            color: const Color.fromRGBO(18, 33, 92, 1),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  'Jam Sewa Lapangan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: jamControllers.keys.map((kategori) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(kategoriIcons[kategori], size: 24),
                            const SizedBox(width: 8),
                            Text(
                              kategori,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 100,
                          height: 30,
                          child: TextField(
                            textAlignVertical:
                                const TextAlignVertical(y: -0.25),
                            controller: hargaControllers[kategori],
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: 'Harga per jam',
                              hintStyle: ket2Style.copyWith(fontSize: 10),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tentukan $kategori',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller:
                                      jamControllers[kategori]!['start'],
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    hintText: 'Mulai',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text('—', style: TextStyle(fontSize: 16)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {});
                                    checkFields();
                                  },
                                  controller: jamControllers[kategori]!['end'],
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    hintText: 'Selesai',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                );
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(301, 37),
                backgroundColor: allFieldsFilled
                    ? const Color(0xFF489DD6)
                    : Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: allFieldsFilled ? (_isLoading ? null : _saveSchedules) : null,
              child: _isLoading 
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    'Simpan',
                    style: regulerFontSelected1.copyWith(fontWeight: FontWeight.w600),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
