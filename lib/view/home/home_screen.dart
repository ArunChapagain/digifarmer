import 'package:digifarmer/provider/myapp_provider.dart';
import 'package:digifarmer/view/home/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final myappProvider = MyappProvider();
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     Consumer<MyappProvider>(builder: (_, myappProvider, child) {
      //       return isDarkMode(context)
      //           ? IconButton(
      //               icon: Icon(Remix.sun_line),
      //               onPressed: () {
      //                 myappProvider.themeMode = ThemeMode.light;
      //               },
      //             )
      //           : IconButton(
      //               icon: Icon(Remix.moon_line),
      //               onPressed: () {
      //                 myappProvider.themeMode = ThemeMode.dark;
      //               },
      //             );
      //     })
      //   ],
      // ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                height: 250.h,
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
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                SizedBox(height: 5.h),
                const SliderCarousel(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
