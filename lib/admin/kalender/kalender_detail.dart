import 'package:flutter/material.dart';
import 'package:arena_connect/admin/config/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KalenderDetailJadwalScreen extends StatefulWidget {
  const KalenderDetailJadwalScreen({Key? key}) : super(key: key);

  @override
  State<KalenderDetailJadwalScreen> createState() =>
      _KalenderDetailJadwalScreenState();
}

class _KalenderDetailJadwalScreenState
    extends State<KalenderDetailJadwalScreen> {
  String selectedCourtType = 'badminton';
  String selectedCourt = 'Lapangan Badminton 1';

  final Map<String, List<String>> courtOptions = {
    'badminton': ['Lapangan Badminton 1', 'Lapangan Badminton 2'],
    'futsal': ['Lapangan Futsal 1', 'Lapangan Futsal 2'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildCourtTypeSelection(context),
          _buildCourtSelection(context),
          Expanded(
            child: _buildScheduleSection(context),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0XFF12215C),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Detail Jadwal',
        style: notifikasiStyle.copyWith(
          color: Colors.white,
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _buildCourtTypeSelection(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            _buildCourtTypeButton('badminton', 'Badminton'),
            const SizedBox(width: 12),
            _buildCourtTypeButton('futsal', 'Futsal'),
          ],
        ),
      ),
    );
  }

  Widget _buildCourtTypeButton(String type, String label) {
    final isSelected = selectedCourtType == type;
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSelected ? const Color(0XFF12215C) : Colors.white,
          side: BorderSide(
            color: const Color(0XFF12215C),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () {
          setState(() {
            selectedCourtType = type;
            selectedCourt = courtOptions[type]![0];
          });
        },
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0XFF12215C),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCourtSelection(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: PopupMenuButton<String>(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0XFF12215C),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedCourt,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SvgPicture.asset(
                "images/img_mynauiarrowupdown.svg",
                height: 16,
                width: 16,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        itemBuilder: (BuildContext context) {
          return courtOptions[selectedCourtType]!.map((String court) {
            return PopupMenuItem<String>(
              value: court,
              child: Text(court),
            );
          }).toList();
        },
        onSelected: (String court) {
          setState(() {
            selectedCourt = court;
          });
        },
      ),
    );
  }

  Widget _buildScheduleSection(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: const Text(
              "Kamis, 19 September 2024",
              style: TextStyle(
                color: Color(0XFF000000),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: 14,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SchedulelistItemWidget(courtName: selectedCourt),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SchedulelistItemWidget extends StatelessWidget {
  final String courtName;

  const SchedulelistItemWidget({
    Key? key,
    required this.courtName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0X0C000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: const Color(0XFFEB0707),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "07:00 - 08.00",
                      style: TextStyle(
                        color: Color(0XFF000000),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0XFF12215C),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        courtName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "Azizah Salsa",
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
