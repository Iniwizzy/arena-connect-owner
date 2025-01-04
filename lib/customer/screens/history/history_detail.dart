import 'package:flutter/material.dart';

// Color Palettes
Color primary = const Color(0xFF12215C);
Color tertiary = const Color(0xFFA7ADC3);
Color white = const Color(0xFFFFFFFF);

class HistoryDetail extends StatefulWidget {
  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  int _rating = 0;
  int _currentIndex = 1;

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terima Kasih!'),
          content: const Text('Terima kasih atas rating anda!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStar(int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          _rating = index;
        });
        _showThankYouDialog();
      },
      icon: Icon(
        index <= _rating ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 40,
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History Pembayaran',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
        backgroundColor: primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: white), // Ikon back
          onPressed: () {
            Navigator.of(context).pop(); // Aksi kembali
          },
        ),
        leadingWidth: 20, // Atur lebar area leading agar lebih kecil
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: Container(
            height: 4.0,
          ),
        ),
      ),
            body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'GOR LOMBA TRI JUANG',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lapangan Lomba Tri Juang 2A',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.sports_tennis),
                              const SizedBox(width: 10),
                              Text(
                                'Badminton',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today),
                              const SizedBox(width: 10),
                              Text(
                                'Jum, 5 Dec 2024\n09:00 - 10:00',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.location_on),
                              const SizedBox(width: 10),
                              Text(
                                'Jl. Tri Lomba Juang, Mugassari',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.monetization_on),
                              const SizedBox(width: 10),
                              Text(
                                'Biaya: 26.000',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Bagaimana Pengalamanmu?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        List.generate(5, (index) => _buildStar(index + 1)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
