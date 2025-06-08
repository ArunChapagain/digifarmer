import 'package:flutter/material.dart';

extension CustomContext on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  //This one for colorScheme shortcut
  ColorScheme get color => Theme.of(this).colorScheme;

  //This one for fontSize
  ///I created different Font class to limit textTheme values, let's assume if some one is using context.font and he is getting too may options related to text theme so how will he know which one is for use??
  ///So in theme.dart file i have created Font class which will give limited numbers of getters

  ///This one for textTheme shortcut
  TextTheme get textTheme => Theme.of(this).textTheme;
}
