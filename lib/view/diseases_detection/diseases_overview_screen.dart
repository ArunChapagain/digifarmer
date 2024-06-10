import 'package:digifarmer/view/diseases_detection/detect_page.dart';
import 'package:digifarmer/widgets/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseasesDetectionPage extends StatelessWidget {
  DiseasesDetectionPage({super.key});
  final textStyle = TextStyle(
    fontFamily: GoogleFonts.poppins(
      fontWeight: FontWeight.w700,
    ).fontFamily,
  );
  final List<Map> plants = [
    {
      'name': 'Tomato Leaf',
      'image': 'assets/images/detection/tomato.png',
      'color': '0xfff94533'
    },
    {
      'name': 'Maize Leaf',
      'image': 'assets/images/detection/corn.png',
      'color': '0xffd8a520'
    },
    {
      'name': 'Rice Leaf',
      'image': 'assets/images/detection/rice.png',
      'color': '0xffadd65f'
    },
    {
      'name': 'Wheat Leaf',
      'image': 'assets/images/detection/wheat.png',
      'color': '0xffd8a520'
    },
    {
      'name': 'Sugarcane Leaf',
      'image': 'assets/images/detection/sugarcane.png',
      'color': '0xffadd65f'
    },
    {
      'name': 'Cotton Leaf',
      'image': 'assets/images/detection/cotton.png',
      'color': '0xff8a5046'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          SizedBox(height: 40.h),
          Text(
            'Identify Crop',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 30.sp,
              fontFamily: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
              ).fontFamily,
              height: 0.1,
            ),
          ),
          Text(
            'Diseases',
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
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
                left: 80.w,
                child: Text(
                  'Digifarmer',
                  style: textStyle.copyWith(
                    fontSize: 34.sp,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 18.h),
          Text(
            'Select the crop',
            style: textStyle.copyWith(
              fontSize: 25.sp,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 525.h,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15.w,
              childAspectRatio: 0.75.w,
              children: List.generate(plants.length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetectPage(
                            title: plants[index]['name'],
                            imagePath: plants[index]['image'],
                            color: plants[index]['color'],
                          ),
                        ));
                      },
                      child: AnimatedPress(
                        child: Container(
                          height: 120.h,
                          width: 200.h,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7E6E6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            height: 50.h,
                            width: 60.w,
                            plants[index]['image'],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plants[index]['name'],
                            style: textStyle.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Identifier',
                            style: TextStyle(
                              height: 0.8.w,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          // SizedBox(height: 20.h)
        ]),
      ),
    ));
  }
}
