import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color backgroundBlack = Color(0xFF000000);
  static const Color backgroundDark = Color(0xFF0A0A0A);
  static const Color accentRed = Color(0xFFFF2A2A);
  static const Color accentDarkRed = Color(0xFFE50914);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFFAAAAAA);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundBlack,
      primaryColor: accentRed,
      colorScheme: const ColorScheme.dark(
        primary: accentRed,
        secondary: accentDarkRed,
        surface: backgroundDark,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.inter(fontSize: 52, fontWeight: FontWeight.w700, color: textWhite, letterSpacing: -2),
        displayMedium: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w700, color: textWhite, letterSpacing: -1),
        headlineLarge: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w500, color: textWhite),
        bodyLarge: GoogleFonts.inter(fontSize: 16, color: textGrey, height: 1.6, fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.inter(fontSize: 14, color: textGrey, height: 1.6, fontWeight: FontWeight.w400),
        labelLarge: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: textWhite, letterSpacing: 2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentRed,
          foregroundColor: textWhite,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          elevation: 0,
          textStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textWhite,
          side: const BorderSide(color: textWhite, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          textStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }
}
