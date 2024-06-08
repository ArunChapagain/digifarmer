import 'package:digifarmer/view/diseases_detection/overview_screen.dart';
import 'package:digifarmer/view/home/widgets/slider.dart';
import 'package:digifarmer/widgets/detect_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController =
        TabController(length: 4, vsync: this); // assuming you have 3 tabs

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                height: 190.h,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/home/smart_farmer.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          'Digifarmer',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontFamily: GoogleFonts.righteous().fontFamily,
                                fontSize: 34.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                        const Text(
                          'Smart Farming Solutions',
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      const Icon(Remix.lightbulb_flash_line),
                      SizedBox(width: 8.w),
                      Text(
                        'Tips',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7.h),
                const SliderCarousel(),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Remix.plant_line),
                      SizedBox(width: 8.w),
                      Text(
                        'Plant Assistance',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.h),
                  DetectButton(
                      onTap: () {
                        _tabController.animateTo(2);
                        // Navigator.of(context).push( 
                        //   MaterialPageRoute(
                        //     builder: (context) => DiseasesDetectionPage(),
                        //   ),
                        // );
                      },
                      title: 'Detector',
                      subTitle: 'Tap to detect disease',
                      icon: Remix.search_2_line),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
