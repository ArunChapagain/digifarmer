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
      'image': 'assets/images/detection/plant.jpg',
    },
    {
      'name': 'Potato Leaf',
      'image': 'assets/images/detection/plant.jpg',
    },
    {
      'name': 'Maize Leaf',
      'image': 'assets/images/detection/plant.jpg',
    },
    {
      'name': 'Rice Leaf',
      'image': 'assets/images/detection/plant.jpg',
    },
    {
      'name': 'Wheat Leaf',
      'image': 'assets/images/detection/plant.jpg',
    },
    {
      'name': 'Sugarcane Leaf',
      'image': 'assets/images/detection/plant.jpg',
    },
    {
      'name': 'Cotton Leaf',
      'image': 'assets/images/detection/plant.jpg',
    },
    {
      'name': 'Soybean Leaf',
      'image': 'assets/images/detection/plant.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
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
              color: Theme.of(context).primaryColor.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 700.h,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
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
                          ),
                        ));
                      },
                      child: AnimatedPress(
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            plants[index]['image'],
                            height: 120.h,
                            width: 200.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Column(
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
