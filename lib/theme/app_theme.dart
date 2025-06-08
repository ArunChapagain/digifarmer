import 'package:digifarmer/provider/myapp_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

///Whether to use dark mode
bool isDarkMode(BuildContext context) {
  Theme.of(context);
  final ThemeMode themeMode = context.read<MyappProvider>().themeMode;
  if (themeMode == ThemeMode.system) {
    return View.of(context).platformDispatcher.platformBrightness ==
        Brightness.dark;
  } else {
    return themeMode == ThemeMode.dark;
  }
}

ThemeMode themeMode(String mode) => switch (mode) {
  'system' => ThemeMode.system,
  'dark' => ThemeMode.dark,
  'light' => ThemeMode.light,
  _ => ThemeMode.system,
};

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
}

///theme
class AppThemeGreen {
  ///Main color
  // static const primaryColor = Color(0xFF5AC03B);
  static const primaryColor = Color(0xFF54BB35);

  ///Light theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    //font
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF11723D),
      onPrimary: Colors.white,
      inversePrimary: Color(0xFFBDDDBB), // white text on inverse primary
      secondary: Color(0xFF607D8B),
      onSecondary: Colors.white,
      tertiary: Color(0xFFEEF3EE),
      onTertiary: Color(0xFF1C1B1F), // dark text for contrast on tertiary
      surface: Color.fromARGB(
        255,
        67,
        206,
        57,
      ), //TODO: change this to your surface color

      onSurface: Color(0xFF1C1B1F), //TODO: change this to your onSurface color
      error: Color(0xFFB00020), // default error color, change if needed
      onError: Colors.white,
    ),

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
    // scaffoldBackgroundColor: const Color(0xFFF6F8FA),
    scaffoldBackgroundColor: const Color.fromARGB(255, 233, 245, 233),
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
    primarySwatch: const MaterialColor(0xFF545454, {
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
    }),
    //Color of water wave when clicked
    splashColor: Colors.transparent,
    //Background highlight color when clicked
    highlightColor: Colors.transparent,
    //Card
    cardColor: Colors.white,
    //bottomSheet
    bottomSheetTheme: const BottomSheetThemeData(
      modalBackgroundColor: Color(0xFFF6F8FA),
    ),
    //Radio
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(const Color(0xFF111315)),
      overlayColor: WidgetStateProperty.all(const Color(0xFF111315)),
    ),
  );
}
