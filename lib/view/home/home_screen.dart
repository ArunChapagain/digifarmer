import 'package:digifarmer/config/function/get_weather_icon.dart';
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
import 'package:digifarmer/widgets/animation.dart';
import 'package:digifarmer/widgets/detect_button.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color(0xFF11723D),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _greetingsAndWeatherStack(context),
            SizedBox(height: 10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontSize: 16.sp,
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
                          fontSize: 16.sp,
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
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
      color: context.color.primary,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(R.kR20),
        bottomRight: Radius.circular(R.kR20),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: AnimatedPress(
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.theme.scaffoldBackgroundColor,
                  ),
                  child: Icon(
                    Remix.logout_circle_r_line,
                    size: 25,
                    color: context.color.primary,
                  ),
                ),
              ),
            ),
          ],
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
  return Consumer<WeatherProvider>(
    builder: (context, state, child) {
      return Container(
        width: context.screenWidth * 0.95,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: context.color.onPrimary,
          borderRadius: BorderRadius.circular(18.5.r),
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
                    kVSizedBox0,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${state.temperature}\u00B0C',
                          style: customTextStyle(
                            color: context.color.onSurface,
                            fontSize: FontSize.kS28,

                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        kHSizedBox3,
                        Column(
                          children: [
                            Text(
                              "High: ${state.weatherModel.forecast?.forecastday?[0].day?.maxtempC ?? ''}\u00B0C",
                              style: customTextStyle(
                                color: context.color.onSurface,
                                fontSize: FontSize.kS14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Low: ${state.weatherModel.forecast?.forecastday?[0].day?.maxtempC ?? ''}\u00B0C",
                              style: customTextStyle(
                                color: context.color.onSurface,
                                fontSize: FontSize.kS14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset(
                    getWeathericonFromAssets(state.weatherIcon),
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        AppImages.sunPath,
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
              ],
            ),
            kVSizedBox1,
            DottedLine(
              dashColor: context.color.inversePrimary,
              lineThickness: 2,
              dashLength: 5,
              dashGapLength: 6,
            ),
            kVSizedBox1,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _weatherItem(
                  title: "Humidity",
                  value: "${state.weatherModel.current?.humidity.toString()} %",
                ),
                _weatherItem(
                  title: "Precipitation",
                  value:
                      "${state.weatherModel.current?.precipMm.toString()} mm",
                ),
                _weatherItem(
                  title: "Wind",
                  value:
                      "${state.weatherModel.current?.windKph.toString()} Kph",
                ),
                _weatherItem(
                  title: "Pressure",
                  value:
                      "${state.weatherModel.current?.pressureMb.toString()} mb",
                ),
              ],
            ),
            kVSizedBox1,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 0,
              children: [
                _sunriseSunsetItem(
                  title: "Sunrise",
                  time:
                      "${state.weatherModel.forecast?.forecastday?[0].astro?.sunrise ?? ''} "
                      "",
                ),
                // SizedBox(width: 4.25),
                Image.asset(
                  AppImages.sunPath,
                  width: 160,
                  height: 60,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppImages.sunPath,
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    );
                  },
                ),

                // SizedBox(width: 4.25),
                _sunriseSunsetItem(
                  title: "SunSet",
                  time:
                      "${state.weatherModel.forecast?.forecastday?[0].astro?.sunset ?? ""} ",
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Widget _sunriseSunsetItem({required String title, required String time}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        time,
        style: TextStyle(
          fontSize: 16.sp,
          // fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),

      Text(title, style: TextStyle(fontSize: 10.sp, color: Colors.grey[700])),
    ],
  );
}

Widget _weatherItem({required String title, required String value}) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
      SizedBox(height: 4.h),
      Text(
        value,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    ],
  );
}

Widget _greetingsAndWeatherStack(BuildContext context) {
  return SizedBox(
    height: 350,
    child: Stack(
      key: ValueKey("GreetingsAndStack"),
      alignment: Alignment.topCenter,
      children: [
        _greetings(context),
        Positioned(bottom: 0, child: _weatherCard(context)),
      ],
    ),
  );
}
