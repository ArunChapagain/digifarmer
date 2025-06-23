// import 'package:digifarmer/theme/constants.dart';
// import 'package:digifarmer/view/weather/widgets/weather_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'dart:ui';

// class ForecastsScreen extends StatefulWidget {
//   final dynamic dailyForecastWeather;

//   const ForecastsScreen({super.key, required this.dailyForecastWeather});

//   @override
//   State<ForecastsScreen> createState() => _ForecastsScreenState();
// }

// class _ForecastsScreenState extends State<ForecastsScreen>
//     with TickerProviderStateMixin {
//   final Constants _constants = Constants();
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.5),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
//     );
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     var weatherData = widget.dailyForecastWeather;

//     Map getForecastWeather(int index) {
//       var day = weatherData[index]["day"];
//       int maxWindSpeed = day["maxwind_kph"].toInt();
//       int avgHumidity = day["avghumidity"].toInt();
//       int chanceOfRain = day["daily_chance_of_rain"].toInt();
//       int minTemperature = day["mintemp_c"].toInt();
//       int maxTemperature = day["maxtemp_c"].toInt();
//       String weatherName = day["condition"]["text"];
//       String weatherIcon =
//           "${weatherName.replaceAll(' ', '').toLowerCase()}.png";
//       String forecastDate = DateFormat(
//         'EEEE, d MMMM',
//       ).format(DateTime.parse(weatherData[index]["date"]));

//       return {
//         'maxWindSpeed': maxWindSpeed,
//         'avgHumidity': avgHumidity,
//         'chanceOfRain': chanceOfRain,
//         'forecastDate': forecastDate,
//         'weatherName': weatherName,
//         'weatherIcon': weatherIcon,
//         'minTemperature': minTemperature,
//         'maxTemperature': maxTemperature,
//       };
//     }

//     Widget buildWeatherItemRow(Map forecast) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           WeatherItem(
//             value: forecast["maxWindSpeed"],
//             unit: "km/h",
//             imageUrl: "assets/images/weather/windspeed.png",
//           ),
//           WeatherItem(
//             value: forecast["avgHumidity"],
//             unit: "%",
//             imageUrl: "assets/images/weather/humidity.png",
//           ),
//           WeatherItem(
//             value: forecast["chanceOfRain"],
//             unit: "%",
//             imageUrl: "assets/images/weather/lightrain.png",
//           ),
//         ],
//       );
//     }

//     Widget buildWeatherMetric(
//       String iconPath,
//       String value,
//       String unit,
//       Color color,
//     ) {
//       return Container(
//         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [color.withAlpha(25), color.withAlpha(15)],
//           ),
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(color: color.withAlpha(50), width: 1),
//           boxShadow: [
//             BoxShadow(
//               color: color.withAlpha(20),
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: EdgeInsets.all(6.w),
//               decoration: BoxDecoration(
//                 color: color.withAlpha(30),
//                 shape: BoxShape.circle,
//               ),
//               child: Image.asset(iconPath, width: 18.w, height: 18.w),
//             ),
//             SizedBox(height: 6.h),
//             Text(
//               '$value$unit',
//               style: TextStyle(
//                 fontSize: 11.sp,
//                 fontWeight: FontWeight.w700,
//                 color: _constants.blackColor.withAlpha(200),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     Widget buildForecastCard(Map forecast, int index) {
//       return Container(
//         margin: EdgeInsets.only(bottom: 16.h, left: 8.w, right: 8.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(24.r),
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.white.withAlpha(240), Colors.white.withAlpha(200)],
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withAlpha(15),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//               spreadRadius: -5,
//             ),
//             BoxShadow(
//               color: Colors.white.withAlpha(200),
//               blurRadius: 1,
//               offset: const Offset(0, 1),
//             ),
//           ],
//           border: Border.all(color: Colors.white.withAlpha(100), width: 1.5),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(24.r),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//             child: Padding(
//               padding: EdgeInsets.all(20.w),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               forecast["forecastDate"].split(',')[0],
//                               style: TextStyle(
//                                 color: _constants.primaryColor,
//                                 fontSize: 20.sp,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                             SizedBox(height: 4.h),
//                             Text(
//                               forecast["forecastDate"].split(',')[1].trim(),
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 20.w,
//                           vertical: 10.h,
//                         ),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               _constants.primaryColor.withAlpha(30),
//                               _constants.secondaryColor.withAlpha(30),
//                             ],
//                           ),
//                           borderRadius: BorderRadius.circular(20.r),
//                           border: Border.all(
//                             color: _constants.primaryColor.withAlpha(60),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               '${forecast["minTemperature"]}°',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.symmetric(horizontal: 8.w),
//                               width: 20.w,
//                               height: 2.h,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[400],
//                                 borderRadius: BorderRadius.circular(1.r),
//                               ),
//                             ),
//                             Text(
//                               '${forecast["maxTemperature"]}°C',
//                               style: TextStyle(
//                                 color: _constants.blackColor,
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 24.h),
//                   Row(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(14.w),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               _constants.primaryColor.withAlpha(40),
//                               _constants.primaryColor.withAlpha(20),
//                             ],
//                           ),
//                           borderRadius: BorderRadius.circular(18.r),
//                           border: Border.all(
//                             color: _constants.primaryColor.withAlpha(60),
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: _constants.primaryColor.withAlpha(20),
//                               blurRadius: 8,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Image.asset(
//                           'assets/images/weather/${forecast["weatherIcon"]}',
//                           width: 36.w,
//                           height: 36.w,
//                         ),
//                       ),
//                       SizedBox(width: 16.w),
//                       Expanded(
//                         child: Text(
//                           forecast["weatherName"] == 'Patchy rain nearby'
//                               ? 'Partially cloudy'
//                               : forecast["weatherName"],
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             color: _constants.blackColor.withAlpha(200),
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           buildWeatherMetric(
//                             'assets/images/weather/windspeed.png',
//                             '${forecast["maxWindSpeed"]}',
//                             'km/h',
//                             _constants.primaryColor,
//                           ),
//                           SizedBox(width: 12.w),
//                           buildWeatherMetric(
//                             'assets/images/weather/humidity.png',
//                             '${forecast["avgHumidity"]}',
//                             '%',
//                             Colors.blue,
//                           ),
//                           SizedBox(width: 12.w),
//                           buildWeatherMetric(
//                             'assets/images/weather/lightrain.png',
//                             '${forecast["chanceOfRain"]}',
//                             '%',
//                             Colors.indigo,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: _constants.primaryColor,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 _constants.primaryColor.withAlpha(230),
//                 _constants.secondaryColor.withAlpha(180),
//               ],
//             ),
//           ),
//           child: ClipRRect(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white.withAlpha(25),
//                   border: Border(
//                     bottom: BorderSide(
//                       color: Colors.white.withAlpha(50),
//                       width: 0.8,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         leading: Container(
//           margin: EdgeInsets.all(8.w),
//           decoration: BoxDecoration(
//             color: Colors.white.withAlpha(60),
//             borderRadius: BorderRadius.circular(14.r),
//             border: Border.all(color: Colors.white.withAlpha(80)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withAlpha(20),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: IconButton(
//             icon: Icon(
//               Icons.arrow_back_ios_rounded,
//               color: Colors.white,
//               size: 20.sp,
//             ),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         centerTitle: true,
//         title: Text(
//           'Weather Forecast',
//           style: TextStyle(
//             fontSize: 26.sp,
//             fontWeight: FontWeight.w800,
//             color: Colors.white,
//             letterSpacing: 0.5,
//             shadows: [
//               Shadow(
//                 offset: const Offset(0, 2),
//                 blurRadius: 8,
//                 color: Colors.black.withAlpha(80),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               _constants.primaryColor,
//               _constants.secondaryColor.withAlpha(200),
//               Theme.of(context).scaffoldBackgroundColor,
//             ],
//             stops: const [0.0, 0.4, 1.0],
//           ),
//         ),
//         child: SafeArea(
//           child: Stack(
//             alignment: Alignment.center,
//             clipBehavior: Clip.none,
//             children: [
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 800),
//                   curve: Curves.easeInOut,
//                   height: size.height * .78,
//                   width: size.width,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.white.withAlpha(230),
//                         Theme.of(context).scaffoldBackgroundColor,
//                       ],
//                     ),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(35.r),
//                       topRight: Radius.circular(35.r),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withAlpha(25),
//                         offset: const Offset(0, -8),
//                         blurRadius: 30,
//                         spreadRadius: 0,
//                       ),
//                     ],
//                   ),
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       // Hero Weather Card
//                       Positioned(
//                         top: -90,
//                         right: 20,
//                         left: 20,
//                         child: SlideTransition(
//                           position: _slideAnimation,
//                           child: FadeTransition(
//                             opacity: _fadeAnimation,
//                             child: Container(
//                               height: 240.h,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(30.r),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: _constants.primaryColor.withAlpha(
//                                       80,
//                                     ),
//                                     offset: const Offset(0, 25),
//                                     blurRadius: 50,
//                                     spreadRadius: -15,
//                                   ),
//                                   BoxShadow(
//                                     color: Colors.white.withAlpha(200),
//                                     offset: const Offset(0, -8),
//                                     blurRadius: 15,
//                                     spreadRadius: -5,
//                                   ),
//                                 ],
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(30.r),
//                                 child: BackdropFilter(
//                                   filter: ImageFilter.blur(
//                                     sigmaX: 15,
//                                     sigmaY: 15,
//                                   ),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight,
//                                         colors: [
//                                           _constants.primaryColor.withAlpha(
//                                             240,
//                                           ),
//                                           _constants.secondaryColor.withAlpha(
//                                             220,
//                                           ),
//                                           _constants.tertiaryColor.withAlpha(
//                                             240,
//                                           ),
//                                         ],
//                                       ),
//                                       border: Border.all(
//                                         color: Colors.white.withAlpha(80),
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     child: Stack(
//                                       children: [
//                                         // Weather icon
//                                         Positioned(
//                                           top: 24.h,
//                                           left: 24.w,
//                                           child: Container(
//                                             padding: EdgeInsets.all(12.w),
//                                             decoration: BoxDecoration(
//                                               color: Colors.white.withAlpha(60),
//                                               borderRadius:
//                                                   BorderRadius.circular(20.r),
//                                               border: Border.all(
//                                                 color: Colors.white.withAlpha(
//                                                   80,
//                                                 ),
//                                               ),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.black.withAlpha(
//                                                     30,
//                                                   ),
//                                                   blurRadius: 8,
//                                                   offset: const Offset(0, 4),
//                                                 ),
//                                               ],
//                                             ),
//                                             child: Image.asset(
//                                               "assets/images/weather/${getForecastWeather(0)["weatherIcon"]}",
//                                               width: 70.w,
//                                               height: 70.w,
//                                             ),
//                                           ),
//                                         ),
//                                         // Weather name
//                                         Positioned(
//                                           top: 130.h,
//                                           left: 24.w,
//                                           right: 120.w,
//                                           child: Text(
//                                             getForecastWeather(
//                                               0,
//                                             )["weatherName"],
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 22.sp,
//                                               fontWeight: FontWeight.w800,
//                                               letterSpacing: 0.5,
//                                               shadows: [
//                                                 Shadow(
//                                                   offset: const Offset(0, 2),
//                                                   blurRadius: 6,
//                                                   color: Colors.black.withAlpha(
//                                                     80,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         // Temperature
//                                         Positioned(
//                                           top: 20.h,
//                                           right: 24.w,
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                             children: [
//                                               RichText(
//                                                 text: TextSpan(
//                                                   children: [
//                                                     TextSpan(
//                                                       text:
//                                                           getForecastWeather(
//                                                                 0,
//                                                               )["maxTemperature"]
//                                                               .toString(),
//                                                       style: TextStyle(
//                                                         fontSize: 52.sp,
//                                                         fontWeight:
//                                                             FontWeight.w900,
//                                                         color: Colors.white,
//                                                         letterSpacing: -1,
//                                                         shadows: [
//                                                           Shadow(
//                                                             offset:
//                                                                 const Offset(
//                                                                   0,
//                                                                   3,
//                                                                 ),
//                                                             blurRadius: 10,
//                                                             color: Colors.black
//                                                                 .withAlpha(80),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     TextSpan(
//                                                       text: '°C',
//                                                       style: TextStyle(
//                                                         fontSize: 28.sp,
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                         color: Colors.white
//                                                             .withAlpha(230),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               SizedBox(height: 6.h),
//                                               Text(
//                                                 'Feels like ${getForecastWeather(0)["minTemperature"]}°C',
//                                                 style: TextStyle(
//                                                   color: Colors.white.withAlpha(
//                                                     200,
//                                                   ),
//                                                   fontSize: 15.sp,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         // Weather metrics
//                                         Positioned(
//                                           bottom: 24.h,
//                                           left: 24.w,
//                                           right: 24.w,
//                                           child: Container(
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal: 20.w,
//                                               vertical: 16.h,
//                                             ),
//                                             decoration: BoxDecoration(
//                                               color: Colors.white.withAlpha(50),
//                                               borderRadius:
//                                                   BorderRadius.circular(20.r),
//                                               border: Border.all(
//                                                 color: Colors.white.withAlpha(
//                                                   80,
//                                                 ),
//                                               ),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.black.withAlpha(
//                                                     20,
//                                                   ),
//                                                   blurRadius: 8,
//                                                   offset: const Offset(0, 4),
//                                                 ),
//                                               ],
//                                             ),
//                                             child: buildWeatherItemRow(
//                                               getForecastWeather(0),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       // Forecast List
//                       Positioned(
//                         top: 170.h,
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           height: 450.h,
//                           padding: EdgeInsets.symmetric(horizontal: 12.w),
//                           child: ListView.builder(
//                             padding: EdgeInsets.zero,
//                             itemCount: weatherData.length.clamp(1, 7),
//                             physics: const BouncingScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return AnimatedContainer(
//                                 duration: Duration(
//                                   milliseconds: 400 + (index * 150),
//                                 ),
//                                 curve: Curves.easeOutBack,
//                                 child: buildForecastCard(
//                                   getForecastWeather(index),
//                                   index,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
