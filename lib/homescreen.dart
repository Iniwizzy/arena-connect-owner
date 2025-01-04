// import 'package:arena_connect/authentication/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // final auth = AuthService();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'images/background-image.png',
              fit: BoxFit.cover,
            ),
          ),
          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 100),
                    height: 150,
                    width: 150,
                    child: Center(
                      // padding: const EdgeInsets.symmetric(),
                      child: Image.asset('images/arena-connect1.png',
                          width: 150, height: 150),
                    ),
                  ),
                  // const Center(
                  //   child: Text(
                  //     "  Welcome to"
                  //     "\nArena Connect ",
                  //     style: TextStyle(
                  //         fontFamily: "Kanit",
                  //         color: Color(0xFF12215C),
                  //         fontWeight: FontWeight.w700,
                  //         fontSize: 31),
                  //   ),
                  // )
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF489DD6),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 18),
                              child: Text(
                                "Masuk",
                                style: TextStyle(
                                    fontFamily: 'SourceSans3',
                                    color: Color(0xFFffffff)),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF12215C),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 18),
                              child: Text(
                                "Daftar",
                                style: TextStyle(
                                    fontFamily: 'SourceSans3',
                                    color: Color(0xFFffffff)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
