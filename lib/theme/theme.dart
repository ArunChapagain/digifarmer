import 'package:flutter/material.dart';

/*
🟩 primary
Main brand color – used most frequently.
Applies to:
Buttons (like Sign Up, Login, Save buttons)
Top app bars
FABs (Floating Action Buttons)
Example from your UI: the green used on buttons — that’s your primary.

🟦 secondary
Supporting color, often used less prominently.
Applies to:
Chips
Secondary buttons or actions
Progress indicators or icons

Example from your UI: the blue-gray used in the weather card for temperature or icons.

🟨 tertiary
Accent color, for emphasis or special UI elements.

Applies to:
Icons or illustrations (like the maize leaf identifier yellow)
Tags or highlights
Example from your UI: yellow maize highlight (used in disease cards).

⚪ background & surface
Background: the canvas your app draws on (usually white or dark gray).

Surface: containers like cards, sheets, dialogs.

Example:

Background: White behind your whole screen.

Surface: Card UI behind "Select the crop", or the weather module.

⚫ onPrimary, onSecondary, etc.
These define the text/icon colors placed on top of the primary, secondary, etc.

For example:

If your primary is a green button, onPrimary should be white text so it's readable.
*/

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xE6D7E7D7),
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
  // Optional: Customize border outlines and components using `outline` color
  dividerColor: Color(0xFFCDCDCD), // using outline
);
