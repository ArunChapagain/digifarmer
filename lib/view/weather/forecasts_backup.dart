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
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeOutBack,
//     ));
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
//       String forecastDate = DateFormat('EEEE, d MMMM')
//           .format(DateTime.parse(weatherData[index]["date"]));

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

//     Widget buildWeatherMetric(String iconPath, String value, String unit, Color color) {
//       return Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(10.r),
//           border: Border.all(color: color.withOpacity(0.3)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(
//               iconPath,
//               width: 20.w,
//               height: 20.w,
//             ),
//             SizedBox(height: 4.h),
//             Text(
//               '$value$unit',
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w600,
//                 color: _constants.blackColor.withOpacity(0.8),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     Widget buildForecastCard(Map forecast, int index) {
//       return AnimatedContainer(
//         duration: Duration(milliseconds: 300 + (index * 100)),
//         curve: Curves.easeOutBack,
//         margin: EdgeInsets.only(bottom: 16.h, left: 4.w, right: 4.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//               spreadRadius: -5,
//             ),
//             BoxShadow(
//               color: Colors.white.withOpacity(0.8),
//               blurRadius: 1,
//               offset: const Offset(0, 1),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20.r),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Colors.white.withOpacity(0.9),
//                     Colors.white.withOpacity(0.7),
//                   ],
//                 ),
//                 border: Border.all(
//                   color: Colors.white.withOpacity(0.3),
//                   width: 1,
//                 ),
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20.w),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 forecast["forecastDate"].split(',')[0],
//                                 style: TextStyle(
//                                   color: _constants.primaryColor,
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               SizedBox(height: 4.h),
//                               Text(
//                                 forecast["forecastDate"].split(',')[1].trim(),
//                                 style: TextStyle(
//                                   color: Colors.grey[600],
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 16.w,
//                             vertical: 8.h,
//                           ),
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 _constants.primaryColor.withOpacity(0.1),
//                                 _constants.secondaryColor.withOpacity(0.1),
//                               ],
//                             ),
//                             borderRadius: BorderRadius.circular(15.r),
//                             border: Border.all(
//                               color: _constants.primaryColor.withOpacity(0.2),
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 '${forecast["minTemperature"]}°',
//                                 style: TextStyle(
//                                   color: Colors.grey[600],
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 6.w),
//                                 width: 20.w,
//                                 height: 1.h,
//                                 color: Colors.grey[400],
//                               ),
//                               Text(
//                                 '${forecast["maxTemperature"]}°C',
//                                 style: TextStyle(
//                                   color: _constants.blackColor,
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.h),
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(12.w),
//                           decoration: BoxDecoration(
//                             color: _constants.primaryColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(15.r),
//                             border: Border.all(
//                               color: _constants.primaryColor.withOpacity(0.2),
//                             ),
//                           ),
//                           child: Image.asset(
//                             'assets/images/weather/${forecast["weatherIcon"]}',
//                             width: 32.w,
//                             height: 32.w,
//                           ),
//                         ),
//                         SizedBox(width: 12.w),
//                         Expanded(
//                           child: Text(
//                             forecast["weatherName"] == 'Patchy rain nearby'
//                                 ? 'Partially cloudy'
//                                 : forecast["weatherName"],
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               color: _constants.blackColor.withOpacity(0.8),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             buildWeatherMetric(
//                               'assets/images/weather/windspeed.png',
//                               '${forecast["maxWindSpeed"]}',
//                               'km/h',
//                               _constants.primaryColor,
//                             ),
//                             SizedBox(width: 12.w),
//                             buildWeatherMetric(
//                               'assets/images/weather/humidity.png',
//                               '${forecast["avgHumidity"]}',
//                               '%',
//                               Colors.blue,
//                             ),
//                             SizedBox(width: 12.w),
//                             buildWeatherMetric(
//                               'assets/images/weather/lightrain.png',
//                               '${forecast["chanceOfRain"]}',
//                               '%',
//                               Colors.indigo,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [
//           _constants.primaryColor,
//           _constants.secondaryColor.withOpacity(0.8),
//         ],
//       ).colors.first,
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
//                 _constants.primaryColor.withOpacity(0.9),
//                 _constants.secondaryColor.withOpacity(0.7),
//               ],
//             ),
//           ),
//           child: ClipRRect(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   border: Border(
//                     bottom: BorderSide(
//                       color: Colors.white.withOpacity(0.2),
//                       width: 0.5,
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
//             color: Colors.white.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(
//               color: Colors.white.withOpacity(0.3),
//             ),
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
//             fontSize: 24.sp,
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//             shadows: [
//               Shadow(
//                 offset: const Offset(0, 2),
//                 blurRadius: 4,
//                 color: Colors.black.withOpacity(0.3),
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
//               _constants.secondaryColor.withOpacity(0.8),
//               Theme.of(context).scaffoldBackgroundColor,
//             ],
//             stops: const [0.0, 0.3, 1.0],
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
//                   height: size.height * .75,
//                   width: size.width,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.white.withOpacity(0.9),
//                         Theme.of(context).scaffoldBackgroundColor,
//                       ],
//                     ),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30.r),
//                       topRight: Radius.circular(30.r),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         offset: const Offset(0, -5),
//                         blurRadius: 20,
//                         spreadRadius: 0,
//                       ),
//                     ],
//                   ),
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Positioned(
//                       top: -100,
//                       right: 20,
//                       left: 20,
//                       child: SlideTransition(
//                         position: _slideAnimation,
//                         child: FadeTransition(
//                           opacity: _fadeAnimation,
//                           child: Container(
//                             height: 220.h,
//                             width: size.width * .7,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25.r),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: _constants.primaryColor.withOpacity(0.3),
//                                   offset: const Offset(0, 20),
//                                   blurRadius: 40,
//                                   spreadRadius: -10,
//                                 ),
//                                 BoxShadow(
//                                   color: Colors.white.withOpacity(0.8),
//                                   offset: const Offset(0, -5),
//                                   blurRadius: 10,
//                                   spreadRadius: -5,
//                                 ),
//                               ],
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(25.r),
//                               child: BackdropFilter(
//                                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                       colors: [
//                                         _constants.primaryColor.withOpacity(0.9),
//                                         _constants.secondaryColor.withOpacity(0.8),
//                                         _constants.tertiaryColor.withOpacity(0.9),
//                                       ],
//                                     ),
//                                     border: Border.all(
//                                       color: Colors.white.withOpacity(0.3),
//                                       width: 1,
//                                     ),
//                                     borderRadius: BorderRadius.circular(25.r),
//                                   ),
//                                   child: Stack(
//                                     clipBehavior: Clip.none,
//                                     children: [
//                                       // Weather icon with improved positioning
//                                       Positioned(
//                                         top: 20.h,
//                                         left: 20.w,
//                                         child: Container(
//                                           padding: EdgeInsets.all(8.w),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white.withOpacity(0.2),
//                                             borderRadius: BorderRadius.circular(15.r),
//                                             border: Border.all(
//                                               color: Colors.white.withOpacity(0.3),
//                                             ),
//                                           ),
//                                           child: Image.asset(
//                                             "assets/images/weather/${getForecastWeather(0)["weatherIcon"]}",
//                                             width: 60.w,
//                                             height: 60.w,
//                                           ),
//                                         ),
//                                       ),
//                                       // Weather name with better styling
//                                       Positioned(
//                                         top: 110.h,
//                                         left: 20.w,
//                                         right: 100.w,
//                                         child: Text(
//                                           getForecastWeather(0)["weatherName"],
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 20.sp,
//                                             fontWeight: FontWeight.w700,
//                                             shadows: [
//                                               Shadow(
//                                                 offset: const Offset(0, 2),
//                                                 blurRadius: 4,
//                                                 color: Colors.black.withOpacity(0.3),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       // Temperature display with modern styling
//                                       Positioned(
//                                         top: 15.h,
//                                         right: 20.w,
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.end,
//                                           children: [
//                                             RichText(
//                                               text: TextSpan(
//                                                 children: [
//                                                   TextSpan(
//                                                     text: getForecastWeather(0)["maxTemperature"].toString(),
//                                                     style: TextStyle(
//                                                       fontSize: 48.sp,
//                                                       fontWeight: FontWeight.w900,
//                                                       color: Colors.white,
//                                                       shadows: [
//                                                         Shadow(
//                                                           offset: const Offset(0, 2),
//                                                           blurRadius: 8,
//                                                           color: Colors.black.withOpacity(0.3),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   TextSpan(
//                                                     text: '°C',
//                                                     style: TextStyle(
//                                                       fontSize: 24.sp,
//                                                       fontWeight: FontWeight.w700,
//                                                       color: Colors.white.withOpacity(0.9),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             SizedBox(height: 4.h),
//                                             Text(
//                                               'Feels like ${getForecastWeather(0)["minTemperature"]}°C',
//                                               style: TextStyle(
//                                                 color: Colors.white.withOpacity(0.8),
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       // Weather metrics with enhanced design
//                                       Positioned(
//                                         bottom: 20.h,
//                                         left: 20.w,
//                                         right: 20.w,
//                                         child: Container(
//                                           padding: EdgeInsets.symmetric(
//                                             horizontal: 16.w,
//                                             vertical: 12.h,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white.withOpacity(0.2),
//                                             borderRadius: BorderRadius.circular(15.r),
//                                             border: Border.all(
//                                               color: Colors.white.withOpacity(0.3),
//                                             ),
//                                           ),
//                                           child: buildWeatherItemRow(getForecastWeather(0)),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                             Positioned(
//                               top: 240.h,
//                               left: 0,
//                               child: Container(
//                                 height: 500.h,
//                                 width: size.width * .9,
//                                 padding: EdgeInsets.symmetric(horizontal: 8.w),
//                                 child: ListView.builder(
//                                   itemCount: weatherData.length.clamp(0, 5),
//                                   physics: const BouncingScrollPhysics(),
//                                   itemBuilder: (context, index) {
//                                     return AnimatedContainer(
//                                       duration: Duration(milliseconds: 300 + (index * 100)),
//                                       curve: Curves.easeOutBack,
//                                       child: buildForecastCard(
//                                         getForecastWeather(index),
//                                         index,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
