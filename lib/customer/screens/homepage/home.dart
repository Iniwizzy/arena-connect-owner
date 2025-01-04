import 'package:arena_connect/customer/screens/field-search/field_search.dart';
import 'package:arena_connect/customer/screens/search/sparring_search.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/customer/config/theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Image.asset(
              'images/element.png',
              fit: BoxFit.contain,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Cari',
                              hintStyle: const TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFFA7ADC3),
                              ),
                              prefixIcon: const Padding(
                                padding:
                                    EdgeInsets.only(left: 15.0, right: 10.0),
                                child: Icon(
                                  Icons.search,
                                  color: Color(0xFF12215c),
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: Color(0xFF12215c),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'LAPANGAN POPULER DI SEKITAR KAMU',
                      style: buttonFont4,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Center(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'images/futsal1.jpg',
                            width: 313,
                            height: 151,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          left: 15,
                          child: Text(
                            'Maxs Sport Center',
                            style: buttonFont2,
                          ),
                        ),
                        const Positioned(
                          bottom: 15,
                          left: 15,
                          child: Text(
                            'Kota Semarang',
                            style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          right: 15,
                          child: Text(
                            '4.5',
                            style: buttonFont2,
                          ),
                        ),
                        const Positioned(
                          bottom: 26,
                          right: 40,
                          child: Icon(
                            Icons.star,
                            size: 18.0,
                            color: Color(0xFFFFD233),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 15.0),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20.0),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Color(0xFFA5D2F1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FieldSearch()),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.sports_soccer,
                                          color: Color(0xFF12215c),
                                          size: 30,
                                        ),
                                        Text(
                                          'Lapangan',
                                          style: superFont5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Color(0xFFA5D2F1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.scoreboard,
                                        color: Color(0xFF12215c),
                                        size: 30,
                                      ),
                                      Text(
                                        'Sparring',
                                        style: superFont5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Color(0xFFA5D2F1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.sports_score_sharp,
                                        color: Color(0xFF12215c),
                                        size: 30,
                                      ),
                                      Text(
                                        'Kompetisi',
                                        style: superFont5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'OLAHRAGA YUK!',
                      style: superFont4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: 5.0),
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  'images/futsal2.jpg',
                                  width: 100,
                                  height: 84,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 100,
                                  height: 31,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 5,
                                child: Text(
                                  'Lapangan Arena 1',
                                  style: superFont6,
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                left: 5,
                                child: Text(
                                  'Kota Semarang',
                                  style: regulerFont8,
                                ),
                              ),
                              Positioned(
                                bottom: 3,
                                right: 5,
                                child: Text(
                                  '4.5',
                                  style: superFont6,
                                ),
                              ),
                              const Positioned(
                                bottom: 4,
                                right: 20,
                                child: Icon(
                                  Icons.star,
                                  size: 8,
                                  color: Color(0xFFFFD233),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5.0),
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  'images/badminton1.jpg',
                                  width: 100,
                                  height: 84,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 100,
                                  height: 31,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 5,
                                child: Text(
                                  'Lapangan Arena 2',
                                  style: superFont6,
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                left: 5,
                                child: Text(
                                  'Kota Semarang',
                                  style: regulerFont8,
                                ),
                              ),
                              Positioned(
                                bottom: 3,
                                right: 5,
                                child: Text(
                                  '4.0',
                                  style: superFont6,
                                ),
                              ),
                              const Positioned(
                                bottom: 4,
                                right: 20,
                                child: Icon(
                                  Icons.star,
                                  size: 8,
                                  color: Color(0xFFFFD233),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5.0),
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  'images/badminton2.jpg',
                                  width: 100,
                                  height: 84,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 100,
                                  height: 31,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 5,
                                child: Text(
                                  'Lapangan Arena 3',
                                  style: superFont6,
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                left: 5,
                                child: Text(
                                  'Kota Semarang',
                                  style: regulerFont8,
                                ),
                              ),
                              Positioned(
                                bottom: 3,
                                right: 5,
                                child: Text(
                                  '4.0',
                                  style: superFont6,
                                ),
                              ),
                              const Positioned(
                                bottom: 4,
                                right: 20,
                                child: Icon(
                                  Icons.star,
                                  size: 8,
                                  color: Color(0xFFFFD233),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5.0),
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  'images/badminton3.jpg',
                                  width: 100,
                                  height: 84,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 100,
                                  height: 31,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 5,
                                child: Text(
                                  'Lapangan Arena 4',
                                  style: superFont6,
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                left: 5,
                                child: Text(
                                  'Kota Semarang',
                                  style: regulerFont8,
                                ),
                              ),
                              Positioned(
                                bottom: 3,
                                right: 5,
                                child: Text(
                                  '4.0',
                                  style: superFont6,
                                ),
                              ),
                              const Positioned(
                                bottom: 4,
                                right: 20,
                                child: Icon(
                                  Icons.star,
                                  size: 8,
                                  color: Color(0xFFFFD233),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            height: 28.5,
                            decoration: BoxDecoration(
                              color: const Color(0xFF12215c),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                                Text(
                                  "Cari Lapangan Terdekat di Sekitarmu",
                                  style: TextStyle(
                                      fontSize: 9.5, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'LAPANGAN DI SEKITAR KAMU',
                      style: superFont4,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: SizedBox(
                      height: 153.0,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                const SizedBox(width: 5.0),
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image.asset(
                                        'images/futsal3.jpg',
                                        width: 308.0,
                                        height: 153.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      child: Container(
                                        width: 308,
                                        height: 45,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      left: 10,
                                      child: Text(
                                        'Kota Semarang',
                                        style: regulerFont10,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      left: 10,
                                      child: Text(
                                        'LAPANGAN BARATA',
                                        style: superFont5,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 15.0),
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image.asset(
                                        'images/badminton3.jpg',
                                        width: 308.0,
                                        height: 153.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      child: Container(
                                        width: 308,
                                        height: 45,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      left: 10,
                                      child: Text(
                                        'Kota Semarang',
                                        style: regulerFont10,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      left: 10,
                                      child: Text(
                                        'LAPANGAN KENCANA',
                                        style: superFont5,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 15.0),
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image.asset(
                                        'images/lapangan-futsal.jpg',
                                        width: 308.0,
                                        height: 153.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      child: Container(
                                        width: 308,
                                        height: 45,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      left: 10,
                                      child: Text(
                                        'Kota Semarang',
                                        style: regulerFont10,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      left: 10,
                                      child: Text(
                                        'LAPANGAN KOMPETISI',
                                        style: superFont5,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.history),
      //       label: 'History',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Cari',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Color(0xFF12215c),
      //   unselectedItemColor: Colors.grey,
      //   selectedLabelStyle: TextStyle(color: Color(0xFF12215c)),
      //   unselectedLabelStyle: TextStyle(color: Colors.grey),
      //   onTap: _onItemTapped,
      // ),
      // bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
