import 'package:digifarmer/provider/weather_provider.dart';
import 'package:digifarmer/view/diseases_detection/diseases_overview_screen.dart';
import 'package:digifarmer/view/home/widgets/slider.dart';
import 'package:digifarmer/widgets/detect_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Digifarmer',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                              fontFamily: GoogleFonts.righteous().fontFamily,
                              fontSize: 36.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      Text(
                        'Smart Farming Solutions',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      const WeatherCard(),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          const Icon(Remix.lightbulb_flash_line),
                          SizedBox(width: 8.w),
                          Text(
                            'Tips',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7.h),
                const SliderCarousel(),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DiseasesDetectionPage(),
                          ),
                        );
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

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
      final date = DateFormat('EEEE, MMM d').format(DateTime.now());
      return Column(
        children: [
          Row(
            children: [
              Text(
                date,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 30.sp,
                      fontFamily: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w700,
                      ).fontFamily,
                    ),
              ),
              SizedBox(width: 20.w),
              weatherProvider.currentIcon != null
                  ? Image.asset(
                      'assets/images/weather/${weatherProvider.weatherIcon}',
                      height: 50.h,
                    )
                  : const CupertinoActivityIndicator(),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowCard(
                Icons.thermostat_outlined,
                const Color(0xff9c6135),
                const Color(0xFFFCF0B6),
                '${(weatherProvider.temperature).toInt().toString()}\u00B0C',
              ),
              rowCard(
                Icons.water_drop_outlined,
                const Color(0xff599d8b),
                const Color(0xFFD5E1E1),
                '${weatherProvider.humidity.toString()}%',
              ),
              rowCard(
                Remix.cloud_line,
                const Color(0xffa33f3f),
                const Color(0xFFF6C7C7),
                '${weatherProvider.cloud.toString()}%',
              ),
            ],
          )
        ],
      );
    });
  }

  Widget rowCard(IconData icon, Color iconColor, Color color, String data) {
    return Container(
      height: 45.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 28,
          ),
          SizedBox(width: 5.w),
          Text(
            data,
            style: TextStyle(
              color: iconColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
