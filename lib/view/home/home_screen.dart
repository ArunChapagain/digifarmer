import 'package:digifarmer/constants/app_images.dart';
import 'package:digifarmer/constants/style.dart';
import 'package:digifarmer/extension/build_context.dart';
import 'package:digifarmer/provider/weather_provider.dart';
import 'package:digifarmer/theme/app_typography.dart';
import 'package:digifarmer/theme/constants.dart';
import 'package:digifarmer/theme/dimension.dart';
import 'package:digifarmer/utils/helper/get_date_time.dart';
import 'package:digifarmer/view/diseases_detection/detect_page.dart';
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
            _greetingsAndWeatherStack(context),
            SizedBox(height: 10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Row(
                //             children: [
                //               Text(
                //                 'Digifarmer',
                //                 style: Theme.of(
                //                   context,
                //                 ).textTheme.displayMedium!.copyWith(
                //                   fontFamily:
                //                       GoogleFonts.righteous().fontFamily,
                //                   fontSize: 36.sp,
                //                   fontWeight: FontWeight.bold,
                //                   color: Theme.of(context).primaryColor,
                //                 ),
                //               ),
                //               Icon(
                //                 Remix.leaf_fill,
                //                 color: Theme.of(context).primaryColor,
                //                 size: 40.sp,
                //               ),
                //             ],
                //           ),
                //           GestureDetector(
                //             onTap: () {
                //               setState(() {
                //                 //logout
                //                 FirebaseAuth.instance.signOut();
                //               });
                //             },
                //             child: AnimatedPress(
                //               child: Container(
                //                 height: 30.h,
                //                 width: 40.w,
                //                 decoration: BoxDecoration(
                //                   color: Theme.of(
                //                     context,
                //                   ).primaryColor.withOpacity(.85),
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 child: const Icon(
                //                   Remix.logout_circle_r_line,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       Text(
                //         'Smart Farming Solutions',
                //         style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 15.h),
                // const WeatherCard(),
                // SizedBox(height: 20.h),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => const DetectPage(
                                title: 'Plant Health',
                                imagePath: 'assets/images/detection/health.png',
                                color: '0xFF42A57F',
                              ),
                        ),
                      );
                    },
                    title: 'Detector',
                    subTitle: 'Tap to diagnose plant health',
                    icon: Remix.search_2_line,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _greetings(BuildContext context) {
  return Container(
    height: 150,
    width: appWidth(context),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
    decoration: BoxDecoration(
      color: context.color.primary,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(R.kR12),
        bottomRight: Radius.circular(R.kR12),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomRichText(
          firstText: 'Hello, ',
          firstTextStyle: customTextStyle(
            fontSize: FontSize.kS24,
            color: context.color.inversePrimary,
          ),
          secondText: "Good ${getTimeOfDay(now)}",
          secondTextStyle: customTextStyle(
            fontSize: FontSize.kS24,

            fontWeight: FontWeight.w700,
            color: context.color.onPrimary,
          ),
        ),
        Text(
          getFormattedDate(now),
          style: customTextStyle(color: context.color.inversePrimary),
        ),
      ],
    ),
  );
}

Widget _weatherCard(BuildContext context) {
  //TODO: Implement Weather card
  return Consumer<WeatherProvider>(
    builder: (context, state, child) {
      return Container(
        width: context.screenWidth * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: context.color.onPrimary,
          borderRadius: BorderRadius.circular(R.kR16),
        ),
        alignment: Alignment.center,

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Icon(Icons.location_on_outlined, size: 20),
                        Text(
                          state.location,
                          style: customTextStyle(
                            fontSize: FontSize.kS20,
                            fontWeight: FontWeight.w700,
                            color: context.color.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${state.temperature}\u00B0C', //TODO: Implement Weather Temp
                          style: customTextStyle(
                            color: context.color.onSurface,
                            fontSize: FontSize.kS28,

                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              "High: ${state.weatherModel.forecast}\u00B0C", //TODO: Implement Weather High Temp
                              style: customTextStyle(
                                color: context.color.onSurface,
                                fontSize: FontSize.kS14,
                              ),
                            ),
                            Text(
                              "Low: +10\u00B0C", //TODO: Implement Weather Low Temp
                              style: customTextStyle(
                                color: context.color.onSurface,
                                fontSize: FontSize.kS14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset(
                  AppImages.sunPath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            // Add more weather details here
          ],
        ),
      );
    },
  );
}

Widget _greetingsAndWeatherStack(BuildContext context) {
  return SizedBox(
    height: 300,
    child: Stack(
      key: ValueKey("GreetingsAndStack"),
      alignment: Alignment.topCenter,
      children: [
        _greetings(context),
        Positioned(bottom: 80, child: _weatherCard(context)),
      ],
    ),
  );
}

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherConstants = Constants();
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        final date = DateFormat('EEEE, MMM d').format(DateTime.now());
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: weatherConstants.primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 127, 182, 8),
                Color(0xff87bb18),
                Color(0xFF99C628),
                // Theme.of(context).primaryColor,
                // Theme.of(context).primaryColor.withOpacity(0.5),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 20.w),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 26.sp,
                      fontFamily:
                          GoogleFonts.notoSans(
                            fontWeight: FontWeight.w700,
                          ).fontFamily,
                      color: Colors.grey[200],
                    ),
                  ),
                  SizedBox(width: 15.w),
                  weatherProvider.currentIcon != null
                      ? Image.asset(
                        'assets/images/weather/${weatherProvider.weatherIcon}',
                        height: 32.h,
                      )
                      : const CupertinoActivityIndicator(),
                ],
              ),
              SizedBox(height: 6.h),
              const Divider(color: Colors.white, thickness: 1),
              SizedBox(height: 6.h),
              // SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  rowCard(
                    Icons.thermostat_outlined,
                    '${(weatherProvider.temperature).toInt().toString()}\u00B0C',
                  ),
                  rowCard(
                    Icons.water_drop_outlined,
                    '${weatherProvider.humidity.toString()}%',
                  ),
                  rowCard(
                    Icons.cloud_outlined,
                    ' ${weatherProvider.cloud.toString()}%',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget rowCard(IconData icon, String data) {
    Color color = const Color.fromARGB(255, 19, 112, 22);
    return Container(
      // height: 55.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: const Color(0xDB9BE655),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 27.sp),
          // SizedBox(width: 3.w),
          Text(
            data,
            style: TextStyle(
              color: color,
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
