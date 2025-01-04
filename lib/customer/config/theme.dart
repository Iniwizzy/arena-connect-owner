import 'package:flutter/material.dart';

// Color Palettes
Color primary = const Color(0xFF12215C);
Color secondary = const Color(0xFF489DD6);
Color tertiary = const Color(0xFFA7ADC3);
Color white = const Color(0xFFFFFFFF);

// Font Styles
TextStyle superFont0 = TextStyle(
  fontFamily: 'Poppins-Bold',
  fontWeight: FontWeight.w300,
  fontSize: 30,
  color: primary,
);

TextStyle superFont1 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w900,
  fontSize: 19,
  color: primary,
);

TextStyle superFont2 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: primary,
);

TextStyle superFont3 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 14,
  color: primary,
);

TextStyle superFont4 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 12,
  color: primary,
);

TextStyle superFont5 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 10,
  color: primary,
);

TextStyle superFont6 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 8,
  color: primary,
);

// Regular Font Styles
TextStyle regulerFont1 = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.normal,
  fontSize: 14,
  color: primary,
);

TextStyle regulerFontSelected1 = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.normal,
  fontSize: 14,
  color: white,
);

TextStyle regulerFont2 = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.bold,
  fontSize: 12,
  color: primary,
);

TextStyle regulerFont3 = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.normal,
  fontSize: 10,
  color: primary,
);

TextStyle regulerFont4 = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.normal,
  fontSize: 9,
  color: primary,
);

TextStyle regulerFont5 = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.normal,
  fontSize: 5,
  color: primary,
);

TextStyle regulerFont6 = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.normal,
  fontSize: 10,
  color: primary,
);

TextStyle regulerFont7 = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.normal,
  fontSize: 10,
  color: secondary,
);

TextStyle regulerFont8 = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.normal,
  fontSize: 4,
  color: secondary,
);

TextStyle regulerFont9 = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.normal,
  fontSize: 12,
  color: tertiary,
);

TextStyle regulerFont10 = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.normal,
  fontSize: 9,
  color: tertiary,
);

// Button Font Styles
TextStyle daftarButtonFont = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: white,
);

TextStyle masukButtonFont = TextStyle(
  fontFamily: 'Source Sans Pro',
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: white,
);

TextStyle buttonFont1 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 15,
  color: white,
);

TextStyle buttonFont2 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 14,
  color: white,
);

TextStyle buttonFont3 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 13,
  color: white,
);

TextStyle buttonFont4 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 12,
  color: white,
);

TextStyle buttonFont5 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 10,
  color: white,
);

TextStyle buttonFont6 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 8,
  color: white,
);

TextStyle buttonFont7 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 7,
  color: white,
);

// Button Styles //

ButtonStyle longButton1 = ElevatedButton.styleFrom(
  minimumSize: const Size(double.infinity, 37),
  backgroundColor: secondary,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(3),
  ),
);

ButtonStyle longButton2 = ElevatedButton.styleFrom(
  minimumSize: const Size(301, 37),
  backgroundColor: const Color(0xFFA8E911),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);

ButtonStyle longButton3 = ElevatedButton.styleFrom(
  minimumSize: const Size(301, 37),
  backgroundColor: const Color(0xFFFF1F00),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);

ButtonStyle shortButton1 = ElevatedButton.styleFrom(
    minimumSize: const Size(175, 32),
    backgroundColor: secondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20));

ButtonStyle daftarButton = ElevatedButton.styleFrom(
    minimumSize: const Size(141, 52),
    backgroundColor: primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(
        color: Colors.white, // Warna stroke putih
        width: 1.5, // Ketebalan stroke
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20));

ButtonStyle masukButton = ElevatedButton.styleFrom(
    minimumSize: const Size(141, 52),
    backgroundColor: secondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(
        color: Colors.white, // Warna stroke putih
        width: 1.5, // Ketebalan stroke
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20));

ButtonStyle shortButtonPrimary = ElevatedButton.styleFrom(
    minimumSize: const Size(131, 32),
    backgroundColor: primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20));

ButtonStyle shortButtonPrimary2 = OutlinedButton.styleFrom(
    minimumSize: const Size(90, 32),
    backgroundColor: primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    side: BorderSide(color: primary),
    padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20));

ButtonStyle shortButtonSecondary = ElevatedButton.styleFrom(
    minimumSize: const Size(131, 32),
    backgroundColor: secondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20));

ButtonStyle shortButton2 = ElevatedButton.styleFrom(
    minimumSize: const Size(82, 22),
    backgroundColor: secondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20));

ButtonStyle shortButton3 = ElevatedButton.styleFrom(
    minimumSize: const Size(42, 22),
    backgroundColor: secondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 2));
