import 'package:flutter/material.dart';

const double kHBox0 = 5.0;
const double kHBox1 = 10.0;
const double kHBox2 = 20.0;
const double kHBox3 = 30.0;
const double kHBox4 = 40.0;

const SizedBox kHSizedBox0 = SizedBox(width: kHBox0);
const SizedBox kHSizedBox1 = SizedBox(width: kHBox1);
const SizedBox kHSizedBox2 = SizedBox(width: kHBox2);
const SizedBox kHSizedBox3 = SizedBox(width: kHBox3);
const SizedBox kHSizedBox4 = SizedBox(width: kHBox4);

const double kVBox0 = 5.0;
const double kVBox1 = 10.0;
const double kVBox2 = 20.0;
const double kVBox3 = 30.0;
const double kVBox4 = 40.0;
const double kVBox5 = 50.0;
const double kVBox6 = 60.0;
const double kVBox7 = 70.0;
const double kVBox8 = 80.0;
const double kVBox9 = 90.0;

const SizedBox kVCreateButtonGap = SizedBox(height: kVBox2 + kVBox0);
const SizedBox kVCreateHeight = SizedBox(height: kVBox2);
const SizedBox kVMainScreenBottomGap = SizedBox(height: kVBox2);
const SizedBox kVSheetActionTileGap = SizedBox(height: kVBox1 + 3);
const SizedBox kVSizedBox0 = SizedBox(height: kVBox0);
const SizedBox kVSizedBox1 = SizedBox(height: kVBox1);
const SizedBox kVSizedBox2 = SizedBox(height: kVBox2);
const SizedBox kVSizedBox3 = SizedBox(height: kVBox3);
const SizedBox kVSizedBox4 = SizedBox(height: kVBox4);
const SizedBox kVSizedBox5 = SizedBox(height: kVBox5);
const SizedBox kVSizedBox6 = SizedBox(height: kVBox6);
const SizedBox kVSizedBox7 = SizedBox(height: kVBox7);
const SizedBox kVSizedBox8 = SizedBox(height: kVBox8);
const SizedBox kVSizedBox9 = SizedBox(height: kVBox9);
const SizedBox kVTabBarViewGap = SizedBox(height: kVBox1 + kVBox0);

//only use it inside the widget body for responsive height
appHeight(BuildContext context) => MediaQuery.of(context).size.height;

//only use it inside the widget body for responsive width
appWidth(BuildContext context) => MediaQuery.of(context).size.width;
