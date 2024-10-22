import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';

class Checkout extends StatelessWidget {
  static const String routeName = '/checkout';

  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> package =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // final arguments = ModalRoute.of(context)?.settings.arguments;
    //   if (arguments != null) {
    //     Map<String, dynamic> args = arguments as Map<String, dynamic>;
    //       // ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    //     List<Map<String, dynamic>> package = arguments['packages'];
    // int selectedIndex = arguments['selectedIndex'];

    // Map<String, dynamic> selectedPackage = package[selectedIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 95, 93),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Color.fromARGB(255, 11, 207, 76),
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              'Checkout for ${package['title']}',
              style: titleTextStyle,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 11, 207, 76),
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.018,
                  horizontal: MediaQuery.of(context).size.width * 0.15,
                ),
              ),
              child: Text('Back', style: buttonStyle),
            ),
          ],
        ),
      ),
    );
  }
  // else {
  //   return const Scaffold(
  //     body: Center(
  //       child: Text('tidak ada'),
  //     )
  //   );
  // }
}
