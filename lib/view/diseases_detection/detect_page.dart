import 'package:digifarmer/widgets/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';

class DetectPage extends StatelessWidget {
  DetectPage({super.key, required this.title, required this.imagePath});
  final String title;
  final String imagePath;
  final textStyle = TextStyle(
      fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              Row(
                children: [
                  AnimatedPress(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Remix.arrow_left_s_line, size: 30.sp),
                    ),
                  ),
                  Text(
                    'back',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      'assets/images/detection/plant.jpg',
                      height: 175.h,
                      width: 400.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 60.h,
                    left: 10.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: textStyle.copyWith(
                            fontSize: 34.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Identifier',
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.white,
                            height: 0.6.h,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 30.h),
              Text(
                'Digifarmer',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontFamily: GoogleFonts.righteous().fontFamily,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Supporting Farmers in ',
                style: textStyle.copyWith(
                  fontSize: 22.sp,
                ),
              ),
              Text(
                'Safegauarding their Crops Health',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30.h),
              button(
                'Take picture',
                'of your plant',
                Remix.camera_line,
                context,
              ),
              SizedBox(height: 15.h),
              button(
                'Import',
                'from your gallary',
                Remix.gallery_view_2,
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(
      String title, String subTitle, IconData icon, BuildContext context) {
    return AnimatedPress(
      child: Container(
        height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30.r),
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
                Text(
                  subTitle,
                  style: textStyle.copyWith(
                    fontSize: 16.sp,
                    color: const Color(0xFF428C2C),
                    height: 0.7.h,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child:
                  Icon(icon, color: Colors.white.withOpacity(0.9), size: 40.sp),
            ),
          ],
        ),
      ),
    );
  }
}
