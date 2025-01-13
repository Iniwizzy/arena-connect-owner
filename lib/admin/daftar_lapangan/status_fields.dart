import 'package:arena_connect/admin/daftar_lapangan/status_fields.dart';
import 'package:arena_connect/admin/config/theme.dart';
import 'package:arena_connect/admin/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LihatStatusLapanganPage extends StatelessWidget {
  final Map<String, Map<String, dynamic>> jamSewaData;

  const LihatStatusLapanganPage({
    Key? key,
    required this.jamSewaData,
  }) : super(key: key);

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
                  'Status Lapangan',
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
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: jamSewaData.keys.length,
              itemBuilder: (context, index) {
                final kategori = jamSewaData.keys.elementAt(index);
                final data = jamSewaData[kategori]!;

                // Generate dynamic time slots
                final List<String> timeSlots = _generateTimeSlots(
                  data['start'],
                  data['end'],
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getKategoriIcon(kategori),
                          size: 24,
                          color: const Color.fromRGBO(18, 33, 92, 1),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          kategori,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    ...timeSlots.map(
                      (slot) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 60,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 3),
                                      // spreadRadius: 2,
                                      blurRadius: 4,
                                      color: Colors.black.withOpacity(0.6),
                                    )
                                  ],
                                  color: const Color.fromRGBO(18, 33, 92, 1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color.fromRGBO(18, 33, 92, 1),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      slot,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // const Spacer(),
                            // Text(
                            //   'Rp ${data['harga']} / jam',
                            //   style: const TextStyle(
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w500,
                            //     fontFamily: 'Poppins',
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getKategoriIcon(String kategori) {
    switch (kategori) {
      case 'Sesi Pagi':
        return Icons.wb_sunny_outlined;
      case 'Sesi Siang':
        return Icons.sunny;
      case 'Sesi Sore':
        return Icons.sunny_snowing;
      case 'Sesi Malam':
        return Icons.nightlight_outlined;
      default:
        return Icons.help_outline;
    }
  }

  List<String> _generateTimeSlots(String startTime, String endTime) {
    final startHour = int.parse(startTime.split(':')[0]);
    final endHour = int.parse(endTime.split(':')[0]);

    List<String> timeSlots = [];
    for (int hour = startHour; hour < endHour; hour++) {
      final nextHour = hour + 1;
      final slot =
          '${hour.toString().padLeft(2, '0')}.00 - ${nextHour.toString().padLeft(2, '0')}.00';
      timeSlots.add(slot);
    }
    return timeSlots;
  }
}
