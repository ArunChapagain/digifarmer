import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Stack(
                children: [
                  Text(
                    'Digifarmer',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontFamily: GoogleFonts.righteous().fontFamily,
                          fontSize: 34.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  Image.asset(
                    'assets/images/smart_farmer.png',
                  ),
                  // contentArea(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contentArea() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Expanded(
              child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [blurBackground(), sheetContentArea()],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget blurBackground() {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: Container(
              decoration:
                  BoxDecoration(color: Colors.grey.shade200.withOpacity(0.4))),
        ));
  }

  Widget sheetContentArea() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              width: 50,
              height: 4,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
