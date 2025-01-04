import 'package:arena_connect/customer/config/theme.dart';
import 'package:arena_connect/customer/screens/sparring/detailsparring.dart';
import 'package:flutter/material.dart';

class Listsparring extends StatefulWidget {
  const Listsparring({super.key});

  @override
  State<Listsparring> createState() => _ListsparringState();
}

class _ListsparringState extends State<Listsparring> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Color(0xFF12215C)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Sparring',
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFF12215C),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFF12215C),
                            width: 2.0,
                          ),
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(Icons.search, color: Color(0xFF12215C)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Detailsparring()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    height: 185,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'images/logobolaA.png',
                                width: 45,
                                height: 45,
                              ),
                              const SizedBox(width: 10),
                              Text('VS', style: superFont2),
                              const SizedBox(width: 10),
                              Image.asset(
                                'images/logobolaB.png',
                                width: 45,
                                height: 45,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'HAPPY SUNDAY',
                                style: superFont3,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.sports_soccer,
                                color: Color(0xFF12215C),
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text('Futsal', style: regulerFont1),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: Color(0xFF12215C),
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text('Sab, 25 September 2024, 14:00 - 15:00',
                                  style: regulerFont1),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Color(0xFF12215C),
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text('Reham, Semarang', style: regulerFont1),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  height: 185,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'images/logomintonA.png',
                              width: 45,
                              height: 45,
                            ),
                            const SizedBox(width: 10),
                            Text('VS', style: superFont2),
                            const SizedBox(width: 10),
                            Image.asset(
                              'images/logomintonB.png',
                              width: 45,
                              height: 45,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'HAPPY MONDAY',
                              style: superFont3,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Image.asset(
                              'images/shuttlecock.png',
                              width: 14,
                              height: 14,
                            ),
                            const SizedBox(width: 8),
                            Text('Badminton', style: regulerFont1),
                            const SizedBox(width: 15),
                            const Icon(
                              Icons.group,
                              color: Color(0xFF12215C),
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Text('Ganda Campuran', style: regulerFont1)
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Color(0xFF12215C),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text('Sab, 24 September 2024, 13:00 - 12:00',
                                style: regulerFont1),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Color(0xFF12215C),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text('GOR Jogo Rogo, Semarang',
                                style: regulerFont1),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  height: 185,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'images/logomintonA.png',
                              width: 45,
                              height: 45,
                            ),
                            const SizedBox(width: 10),
                            Text('VS', style: superFont2),
                            const SizedBox(width: 10),
                            Image.asset(
                              'images/logomintonB.png',
                              width: 45,
                              height: 45,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'HAPPY FRIDAY',
                              style: superFont3,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Image.asset(
                              'images/shuttlecock.png',
                              width: 14,
                              height: 14,
                            ),
                            const SizedBox(width: 8),
                            Text('Badminton', style: regulerFont1),
                            const SizedBox(width: 10),
                            const Icon(Icons.person_2_sharp, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              'Single',
                              style: regulerFont1,
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Color(0xFF12215C),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text('Sab, 1 November 2024, 16:00 - 17:00',
                                style: regulerFont1),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Color(0xFF12215C),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text('KIO SPORT, Semarang', style: regulerFont1),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  height: 185,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'images/logobolaA.png',
                              width: 45,
                              height: 45,
                            ),
                            const SizedBox(width: 10),
                            Text('VS', style: superFont2),
                            const SizedBox(width: 10),
                            Image.asset(
                              'images/logobolaB.png',
                              width: 45,
                              height: 45,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'HAPPY SATURDAY',
                              style: superFont3,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.sports_soccer_outlined,
                              color: Color(0xFF12215C),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text('Futsal', style: regulerFont1),
                            const SizedBox(width: 10),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Color(0xFF12215C),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text('Sab, 30 September 2024, 08:00 - 09:00',
                                style: regulerFont1),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Color(0xFF12215C),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text('Mega Futsal, Semarang', style: regulerFont1),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
