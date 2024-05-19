import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///Whether to use dark mode
bool isDarkMode(BuildContext context) {
  final ThemeMode themeMode =
      MediaQuery.platformBrightnessOf(context) == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
  if (themeMode == ThemeMode.system) {
    return View.of(context).platformDispatcher.platformBrightness ==
        Brightness.dark;
  } else {
    return themeMode == ThemeMode.dark;
  }
}

///Theme basics
class AppTheme {
  ///Device reference size
  static const double wdp = 360.0;
  static const double hdp = 690.0;

  ///Secondary color
  static const subColor = Color(0xFF8F969C);

  ///Background color series
  static const backgroundColor1 = Color(0xFFE8ECF0);
  static const backgroundColor2 = Color(0xFFFCFBFC);
  static const backgroundColor3 = Color(0xFFF3F2F3);

  static ThemeData getLightThemeData(BuildContext context) {
    return AppThemeGreen.lightTheme;
  }

  static ThemeData getDarkThemeData(BuildContext context) {
    return AppThemeGreen.darkTheme;
  }
}

///theme
class AppThemeGreen {
  ///Main color
  static const primaryColor = Color.fromARGB(255, 49, 137, 45);

  ///Light theme
  static final lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    //font
    fontFamily: GoogleFonts.nunitoSans().fontFamily,
    //letter
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black87),
      displayMedium: TextStyle(color: Colors.black87),
      displaySmall: TextStyle(color: Colors.black87),
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
      bodySmall: TextStyle(color: Colors.black87),
    ),
    //main color
    primaryColor: primaryColor,
    //scaffold background color
    scaffoldBackgroundColor:
        const Color(0xFFF6F8FA), //0xFFF7F7F7 0xFFF9F9F9 0xFFF6F8FA 0xFFFCFBFC
    //bottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    //TabBar
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Color(0xFFAFB8BF),
    ),
    //Bounce wave color
    primarySwatch: const MaterialColor(
      0xFF545454,
      {
        50: Color(0xFF545454),
        100: Color(0xFF545454),
        200: Color(0xFF545454),
        300: Color(0xFF545454),
        400: Color(0xFF545454),
        500: Color(0xFF545454),
        600: Color(0xFF545454),
        700: Color(0xFF545454),
        800: Color(0xFF545454),
        900: Color(0xFF545454),
      },
    ),
    //Color of water wave when clicked
    splashColor: Colors.transparent,
    //Background highlight color when clicked
    highlightColor: Colors.transparent,
    //Card
    cardColor: Colors.white,
    //bottomSheet
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFFF6F8FA)),
    //Radio
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(const Color(0xFF111315)),
      overlayColor: WidgetStateProperty.all(const Color(0xFF111315)),
    ),
  );

  ///Dark theme
  static final darkTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    //font
    fontFamily: GoogleFonts.nunitoSans().fontFamily,

    //letter
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFFEFEFEF)),
      displayMedium: TextStyle(color: Color(0xFFEFEFEF)),
      displaySmall: TextStyle(color: Color(0xFFEFEFEF)),
      bodyLarge: TextStyle(color: Color(0xFFEFEFEF)),
      bodyMedium: TextStyle(color: Color(0xFFEFEFEF)),
      bodySmall: TextStyle(color: Color(0xFFEFEFEF)),
    ),
    //main color
    primaryColor: primaryColor,
    //scaffold background color
    scaffoldBackgroundColor: const Color(0xFF111315),
    //bottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1A1D1F),
    ),
    //TabBar
    tabBarTheme: const TabBarTheme(
      // labelColor: primaryColor,
      // unselectedLabelColor: primaryColor.withOpacity(0.4)
      labelColor: Colors.white,
      unselectedLabelColor: Color(0xFF6F767E),
    ),
    //Bounce wave color
    primarySwatch: const MaterialColor(
      0xFF545454,
      {
        50: Color(0xFF545454),
        100: Color(0xFF545454),
        200: Color(0xFF545454),
        300: Color(0xFF545454),
        400: Color(0xFF545454),
        500: Color(0xFF545454),
        600: Color(0xFF545454),
        700: Color(0xFF545454),
        800: Color(0xFF545454),
        900: Color(0xFF545454),
      },
    ),
    //Color of water wave when clicked
    splashColor: Colors.transparent,
    //Background highlight color when clicked
    highlightColor: Colors.transparent,
    //Card
    cardColor: const Color(0xFF202427),
    //bottomSheet
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFF111315)),
    //Radio
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(const Color(0xFFEFEFEF)),
      overlayColor: WidgetStateProperty.all(const Color(0xFFEFEFEF)),
    ),
  );
}
