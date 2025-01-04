import 'dart:convert';
import 'package:arena_connect/api/api.dart';
import 'package:arena_connect/customer/config/theme.dart';
import 'package:arena_connect/customer/models/res_fields.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectSchedule extends StatefulWidget {
  final int fieldCentreId;
  const SelectSchedule({super.key, required this.fieldCentreId});

  @override
  // ignore: library_private_types_in_public_api
  _SelectScheduleState createState() => _SelectScheduleState();
}

class DashedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final Paint paintLine;

  DashedLinePainter(
      {this.dashWidth = 4.0, this.dashSpace = 5.0, Color color = Colors.white})
      : paintLine = Paint()
          ..color = color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2), paintLine);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _SelectScheduleState extends State<SelectSchedule> {
  int selectedIndex = -1;
  int selectedScheduleIndex = -1;
  String _selectedPrice = 'Rp0';
  List<Field> fields = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getFields();
  }

  Future<void> _getFields() async {
    try {
      String? token = await ApiService().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/api/field-centres/${widget.fieldCentreId}/fields'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success']) {
          setState(() {
            fields = (responseData['data'] as List)
                .map((field) => Field.fromJson(field))
                .toList();
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load fields');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget scheduleChooseIcon() {
      return Column(
        children: [
          Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary,
                  border: Border.all(color: Colors.white, width: 1)),
              child: const IconButton(
                  icon: Icon(Icons.calendar_month_outlined),
                  color: Colors.white,
                  onPressed: null,
                  disabledColor: Colors.white)),
        ],
      );
    }

    Widget bookingDetailIcon() {
      return Column(
        children: [
          Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary,
                  border: Border.all(color: Colors.white, width: 1)),
              child: const IconButton(
                  icon: Icon(Icons.list_alt_rounded),
                  color: Colors.white,
                  onPressed: null,
                  disabledColor: Colors.white)),
        ],
      );
    }

    Widget paymentIcon() {
      return Column(
        children: [
          Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary,
                  border: Border.all(color: Colors.white, width: 1)),
              child: const IconButton(
                  icon: Icon(Icons.payments_outlined),
                  color: Colors.white,
                  onPressed: null,
                  disabledColor: Colors.white)),
        ],
      );
    }

    Widget scheduleChooseOption(
      int fieldIndex,
      int scheduleIndex,
      String duration,
      String hoursDuration,
      String pricing,
    ) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = fieldIndex;
            selectedScheduleIndex = scheduleIndex;
            _selectedPrice = pricing;
          });
        },
        child: Container(
          padding: const EdgeInsets.only(left: 24, top: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Card.outlined(
                color: selectedIndex == fieldIndex &&
                        selectedScheduleIndex == scheduleIndex
                    ? primary
                    : white,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(duration,
                              style: selectedIndex == fieldIndex &&
                                      selectedScheduleIndex == scheduleIndex
                                  ? regulerFontSelected1
                                  : regulerFont1),
                          const SizedBox(height: 1),
                          Text(hoursDuration,
                              style: selectedIndex == fieldIndex &&
                                      selectedScheduleIndex == scheduleIndex
                                  ? regulerFontSelected1
                                  : regulerFont1)
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 12, top: 6, bottom: 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Kasih pengkondisian di text Booked
                          // Text("Booked", style: regulerFont3),
                          const SizedBox(height: 1),
                          Text(pricing,
                              style: selectedIndex == fieldIndex &&
                                      selectedScheduleIndex == scheduleIndex
                                  ? regulerFontSelected1
                                  : regulerFont1),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'images/top-wave-cropped.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                          color: white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 40),
                              child: Column(
                                children: [
                                  scheduleChooseIcon(),
                                  const SizedBox(height: 1),
                                  Text(
                                    "Pilih Jadwal",
                                    style: buttonFont6,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: CustomPaint(
                            painter: DashedLinePainter(),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(0),
                                child: bookingDetailIcon()),
                            const SizedBox(height: 1),
                            Text(
                              "Detail Booking",
                              style: buttonFont6,
                            ),
                          ],
                        ),
                        Expanded(
                          child: CustomPaint(
                            painter: DashedLinePainter(),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 40),
                              child: Column(
                                children: [
                                  paymentIcon(),
                                  const SizedBox(height: 1),
                                  Text(
                                    "Pembayaran",
                                    style: buttonFont6,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Nampilin list lapangan yang tersedia
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Center(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView(
                              children: fields.map((field) {
                                return ExpansionTile(
                                  textColor: white,
                                  title: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/lapangan-futsal.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            field.name,
                                            style: regulerFont2,
                                          ),
                                          Text(
                                            field.type,
                                            style: regulerFont7,
                                          ),
                                          Text(
                                            "${field.schedules.length} Jadwal",
                                            style: regulerFont7,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(
                                    Icons.expand_circle_down,
                                    color: primary,
                                  ),
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ...field.schedules
                                              .asMap()
                                              .entries
                                              .map(
                                            (entry) {
                                              int scheduleIndex = entry.key;
                                              Schedule schedule = entry.value;
                                              return scheduleChooseOption(
                                                fields.indexOf(field),
                                                scheduleIndex,
                                                schedule.startTime,
                                                schedule.endTime,
                                                field.price[0].priceFrom,
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          GestureDetector(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  _selectedPrice =
                                                      field.price[0].priceFrom;
                                                });
                                              },
                                              style: shortButton2,
                                              child: Text(
                                                "Buat Booking",
                                                style: buttonFont6,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Harga Total", style: regulerFont10),
                              Text("Rp$_selectedPrice", style: superFont4),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: longButton1,
                                  child: Text(
                                    "Selanjutnya",
                                    style: buttonFont4,
                                  )),
                              const SizedBox(height: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
