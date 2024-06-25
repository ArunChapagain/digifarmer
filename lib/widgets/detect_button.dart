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
      required this.icon,
      this.isSecondBtn});
  final Function onTap;
  final bool? isSecondBtn;
  final String title;
  final String subTitle;
  final IconData icon;
  final textStyle = TextStyle(
      fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily);

  bool get btn {
    if (isSecondBtn == null) {
      return false;
    } else {
      return isSecondBtn!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: AnimatedPress(
        child: Container(
          height: 70.h,
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
          decoration: BoxDecoration(
            // color: Theme.of(context).primaryColor.withOpacity(0.8),
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
            gradient: LinearGradient(
              colors: btn
                  ? [
                      const Color(0xFFBBDD73),
                      const Color(0xFFCDE299),
                    ]
                  : [
                      const Color.fromARGB(255, 127, 182, 8),
                      const Color(0xff87bb18),
                      const Color(0xFF99C628),
                      const Color(0xFFA8D24C),
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
                      color: btn
                          ? const Color(0xFF020120).withOpacity(0.7)
                          : Colors.white.withOpacity(0.9),
                      fontSize: 22.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: btn
                          ? const Color(0xFF020120).withOpacity(0.5)
                          : const Color(0xFF428C2C),
                      height: 0.7.h,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Icon(
                  icon,
                  color: btn
                      ? const Color(0xFF020120).withOpacity(0.7)
                      : Colors.white.withOpacity(0.9),
                  size: 40.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
