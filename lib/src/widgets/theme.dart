import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static ThemeData lightMode(BuildContext context) {
    return ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        background: const Color(0xffffffff),
        primary: const Color(0xff171717),
        secondary: const Color(0xfff3f3f3),
        tertiary: Color(0xff8d8d8d),
        inversePrimary: Colors.grey.shade800,
      ),
    );
  }
}
