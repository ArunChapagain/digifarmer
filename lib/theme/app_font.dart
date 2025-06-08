import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  // Sansation font family
  static final TextStyle sansation = TextStyle(fontFamily: 'Sansation');

  // Font weights for Sansation
  static const FontWeight sansationLight = FontWeight.w300;
  static const FontWeight sansationRegular = FontWeight.w400;
  static const FontWeight sansationBold = FontWeight.w700;

  // Helper methods for Sansation with different weights
  static TextStyle sansationWithWeight({
    FontWeight? weight,
    double? size,
    Color? color,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Sansation',
      fontWeight: weight,
      fontSize: size,
      color: color,
      decoration: decoration,
    );
  }

  // Inter font family
  static final TextStyle inter = GoogleFonts.inter();

  //Parisienne fo
  static final TextStyle parisienne = GoogleFonts.parisienne();

  // Raleway font family
  static final TextStyle raleway = GoogleFonts.raleway();

  // Lato font family
  static final TextStyle lato = GoogleFonts.lato();

  // Poppins font family
  static final TextStyle poppins = GoogleFonts.poppins();
  static final TextStyle karla = GoogleFonts.karla();
  static final TextStyle roboto = GoogleFonts.roboto();
  static final TextStyle openSans = GoogleFonts.openSans();
}
