import 'package:digifarmer/widgets/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DetectButton extends StatelessWidget {
  DetectButton(
      {super.key,
      required this.onTap,
      required this.title,
      required this.subTitle,
      required this.icon});
  final Function onTap;

  final String title;
  final String subTitle;
  final IconData icon;
  final textStyle = TextStyle(
      fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: AnimatedPress(
        child: Container(
          height: 75.h,
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.all(
              Radius.circular(26.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                blurRadius: 10.0,
                spreadRadius: 0.1,
                offset: const Offset(1, 7),
              ),
            ],
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 127, 182, 8),
                Color(0xff87bb18),
                Color.fromARGB(255, 187, 233, 71),
                Color.fromARGB(255, 149, 200, 37),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: textStyle.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 22.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: const Color(0xFF428C2C),
                      height: 0.7.h,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Icon(icon,
                    color: Colors.white.withOpacity(0.9), size: 40.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}