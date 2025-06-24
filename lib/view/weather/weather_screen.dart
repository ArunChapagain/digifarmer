import 'package:digifarmer/provider/location_provider.dart';
import 'package:digifarmer/provider/network_checker_provider.dart';
import 'package:digifarmer/provider/weather_provider.dart';
import 'package:digifarmer/theme/constants.dart';
import 'package:digifarmer/theme/dimension.dart';
import 'package:digifarmer/view/weather/forecasts.dart';
import 'package:digifarmer/view/weather/widgets/reload_weather.dart';
import 'package:digifarmer/view/weather/widgets/weather_item.dart';
import 'package:digifarmer/widgets/animation.dart';
import 'package:digifarmer/widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottom_sheet;
import 'package:remixicon/remixicon.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _HomePageState();
}

class _HomePageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  final Constants _constants = Constants();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer2<WeatherProvider, NetworkCheckerProvider>(
          builder: (context, weatherProvider, networkProvider, chid) {
            if (weatherProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return networkProvider.status == InternetStatus.disconnected
                ? const NoInternetWidget()
                : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kVSizedBox0,
                        leadingColumnRow(context, weatherProvider),
                        kVSizedBox1,
                        _weatherCard(context, weatherProvider),
                        kVSizedBox1,

                        TodayForecast(
                          dailyWeatherForecast:
                              weatherProvider.dailyWeatherForecast,
                          hourlyWeatherForecast:
                              weatherProvider.hourlyWeatherForecast,
                          constants: _constants,
                        ),
                      ],
                    ),
                  ),
                );
          },
        ),
      ),
    );
  }

  Widget leadingColumnRow(
    BuildContext context,
    WeatherProvider weatherProvider,
  ) {
    // boo
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LocationDisplay(
              location: weatherProvider.location,
              cityController: _cityController,
              constants: _constants,
            ),
          ],
        ),
        AnimatedPress(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 6.w),

            width: 110.w,
            decoration: BoxDecoration(
              color: Color(0xFFD8E7D8),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: RotatingIconButton(
              onPressed: () => weatherProvider.getWeather(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _weatherCard(BuildContext context, WeatherProvider weatherProvider) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),

          // width: 110.w,
          decoration: BoxDecoration(
            color: Color(0xFFD8E7D8),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Image.asset(
            "assets/images/weather/${weatherProvider.weatherIcon}",
            height: 200.w,
          ),
        ),
        kVSizedBox2,
        Text(
          '${weatherProvider.temperature.toString()}\u00B0',

          style: TextStyle(
            fontFamily:
                GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily,
            height: 1,
            color: Colors.black,
            fontSize: 50.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          weatherProvider.currentWeatherStatus.toString(),
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 26.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        kVSizedBox2,
        Container(
          // padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 6.w),
          // width: 110.w,
          decoration: BoxDecoration(
            color: Color(0xFFD8E7D8),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 30.w),
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          // decoration: BoxDecoration(
          //   color: Color(0xFFD8E7D8),
          //   borderRadius: BorderRadius.circular(30.r),
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _weatherItem(
                imagePath: 'windspeed',
                title: 'Wind',
                value: '${weatherProvider.windSpeed} km/h',
              ),
              SizedBox(
                height: 35.h,
                child: VerticalDivider(
                  color: Colors.black.withOpacity(0.3),
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                ),
              ),
              _weatherItem(
                imagePath: 'humidity',
                title: 'Humidity',
                value: '${weatherProvider.humidity}%',
              ),
              SizedBox(
                height: 35.h,
                child: VerticalDivider(
                  color: Colors.black.withOpacity(0.3),
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                ),
              ),
              _weatherItem(
                imagePath: 'cloud',
                title: 'Cloud',
                value: '${weatherProvider.cloud}%',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _weatherItem({
    required String imagePath,
    required String title,
    required String value,
  }) {
    return Column(
      spacing: 2,
      children: [
        Image.asset(
          'assets/images/weather/${imagePath}.png',
          fit: BoxFit.cover,
          height: 30.w,
          width: 30.w,
        ),
        Text(
          value,
          style: TextStyle(
            height: 1,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget weatherCard({
    required Constants constants,
    required WeatherProvider weatherProvider,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
      height: 320.h,
      decoration: BoxDecoration(
        gradient: constants.linearGradientBlue,
        boxShadow: [
          BoxShadow(
            color: constants.primaryColor.withOpacity(.5),
            spreadRadius: 2.r,
            blurRadius: 5.r,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          weatherCardLeadingRow(context, weatherProvider),
          Image.asset(
            "assets/images/weather/${weatherProvider.weatherIcon}",
            height: 100.w,
          ),
          TemperatureDisplay(
            temperature: weatherProvider.temperature,
            constants: constants,
          ),
          Text(
            weatherProvider.currentWeatherStatus,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 25.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          DateTimeDisplay(
            currentTime: weatherProvider.currentTime,
            currentDate: weatherProvider.currentDate,
          ),
          const Divider(color: Colors.white70, indent: 20, endIndent: 20),
          WeatherStatsRow(
            windSpeed: weatherProvider.windSpeed,
            humidity: weatherProvider.humidity,
            cloud: weatherProvider.cloud,
          ),
        ],
      ),
    );
  }

  Widget weatherCardLeadingRow(
    BuildContext context,
    WeatherProvider weatherProvider,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocationDisplay(
            location: weatherProvider.location,
            cityController: _cityController,
            constants: _constants,
          ),
          AnimatedPress(
            child: RotatingIconButton(
              onPressed: () {
                weatherProvider.getWeather();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TemperatureDisplay extends StatelessWidget {
  final double temperature;
  final Constants constants;

  const TemperatureDisplay({
    super.key,
    required this.temperature,
    required this.constants,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.end,
          text: TextSpan(
            children: [
              TextSpan(
                text: temperature.toString(),
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = constants.shader,
                ),
              ),
              TextSpan(
                text: '\u00B0C',
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = constants.shader,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DateTimeDisplay extends StatelessWidget {
  final String currentTime;
  final String currentDate;

  const DateTimeDisplay({
    super.key,
    required this.currentTime,
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          currentTime,
          style: TextStyle(color: Colors.white70, fontSize: 18.sp),
        ),
        SizedBox(width: 5.w),
        Text(
          currentDate,
          style: TextStyle(color: Colors.white70, fontSize: 18.sp),
        ),
      ],
    );
  }
}

class WeatherStatsRow extends StatelessWidget {
  final int windSpeed;
  final int humidity;
  final int cloud;

  const WeatherStatsRow({
    super.key,
    required this.windSpeed,
    required this.humidity,
    required this.cloud,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeatherItem(
            value: windSpeed,
            unit: 'km/h',
            imageUrl: 'assets/images/weather/windspeed.png',
          ),
          WeatherItem(
            value: humidity,
            unit: '%',
            imageUrl: 'assets/images/weather/humidity.png',
          ),
          WeatherItem(
            value: cloud,
            unit: '%',
            imageUrl: 'assets/images/weather/cloud.png',
          ),
        ],
      ),
    );
  }
}

class LocationDisplay extends StatelessWidget {
  final String location;
  final TextEditingController cityController;
  final Constants constants;

  const LocationDisplay({
    super.key,
    required this.location,
    required this.cityController,
    required this.constants,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cityController.clear();
        bottom_sheet.showMaterialModalBottomSheet(
          context: context,
          builder:
              (context) => SingleChildScrollView(
                controller: bottom_sheet.ModalScrollController.of(context),
                child: SearchCityBottomSheet(
                  cityController: cityController,
                  constants: constants,
                ),
              ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            RemixIcons.map_pin_2_fill,
            color: Color(0xFFFF6C32),
            size: 24,
          ),
          SizedBox(width: 10.w),
          Text(
            location,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(
            RemixIcons.arrow_down_s_line,
            color: Colors.black,
            size: 30,
          ),
        ],
      ),
    );
  }
}

class SearchCityBottomSheet extends StatelessWidget {
  final TextEditingController cityController;
  final Constants constants;

  const SearchCityBottomSheet({
    super.key,
    required this.cityController,
    required this.constants,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          SizedBox(
            width: 70,
            child: Divider(thickness: 3.5, color: constants.primaryColor),
          ),
          const SizedBox(height: 10),
          TextField(
            // onChanged: (searchText) => fetchWeatherData(searchText),
            controller: cityController,
            autofocus: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: constants.primaryColor),
              suffixIcon: GestureDetector(
                onTap: () => cityController.clear(),
                child: Icon(Icons.close, color: constants.primaryColor),
              ),
              hintText: 'Search city e.g. Pokhara',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20.w),
          Consumer2(
            builder: (
              context,
              WeatherProvider weatherProvider,
              LocationProvider locationProvider,
              child,
            ) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      locationProvider.getCurrentLocation().then((_) {
                        weatherProvider.setAndGetWeather(
                          '${locationProvider.latitude},${locationProvider.longitude}',
                        );
                        Navigator.pop(context);
                      });
                    },
                    child: AnimatedPress(
                      child: Container(
                        // width: 110.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0089E4),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Location via GPS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            const Icon(Icons.gps_fixed, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<WeatherProvider>(
                        context,
                        listen: false,
                      ).setAndGetWeather(cityController.text);
                    },
                    child: AnimatedPress(
                      child: Container(
                        width: 110.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0089E4),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class TodayForecast extends StatelessWidget {
  final List dailyWeatherForecast;
  final List hourlyWeatherForecast;
  final Constants constants;

  const TodayForecast({
    super.key,
    required this.dailyWeatherForecast,
    required this.hourlyWeatherForecast,
    required this.constants,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Today',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ForecastsScreen(
                              dailyForecastWeather: dailyWeatherForecast,
                            ),
                      ),
                    ),
                child: AnimatedPress(
                  child: Text(
                    'Forecasts >',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 105.h,
          child: HourlyForecastList(
            hourlyWeatherForecast: hourlyWeatherForecast,
            constants: constants,
          ),
        ),
      ],
    );
  }
}

class HourlyForecastList extends StatefulWidget {
  final List hourlyWeatherForecast;
  final Constants constants;

  const HourlyForecastList({
    super.key,
    required this.hourlyWeatherForecast,
    required this.constants,
  });

  @override
  State<HourlyForecastList> createState() => _HourlyForecastListState();
}

class _HourlyForecastListState extends State<HourlyForecastList> {
  late ScrollController _scrollController;
  int currentHourIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _findCurrentHourIndex();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentHour();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _findCurrentHourIndex() {
    final now = DateTime.now();
    final currentHour = now.hour;

    for (int i = 0; i < widget.hourlyWeatherForecast.length; i++) {
      final forecast = widget.hourlyWeatherForecast[i];
      final forecastDateTime = DateTime.parse(forecast["time"]);
      if (forecastDateTime.hour == currentHour &&
          forecastDateTime.day == now.day) {
        currentHourIndex = i;
        break;
      }
    }
  }

  void _scrollToCurrentHour() {
    if (currentHourIndex > 0) {
      final itemWidth = 90.w; // 80.w width + 10.w margin
      final scrollPosition =
          (currentHourIndex * itemWidth) -
          (MediaQuery.of(context).size.width / 2) +
          (itemWidth / 2);

      _scrollController.animateTo(
        scrollPosition.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.hourlyWeatherForecast.length,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final forecast = widget.hourlyWeatherForecast[index];
        final forecastTime = get12HourTime(forecast["time"].substring(11, 16));
        final forecastTemperature = forecast["temp_c"].round().toString();
        final forecastWeatherName = forecast["condition"]["text"];
        final forecastWeatherIcon =
            "${forecastWeatherName.replaceAll(' ', '').toLowerCase()}.png";

        final isCurrentHour = index == currentHourIndex;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 80.w,
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  isCurrentHour
                      ? const Color(0xFF0089E4)
                      : Colors.grey.withOpacity(0.3),
              width: 1,
            ),
            color:
                isCurrentHour
                    ? const Color(0xFF0089E4)
                    : const Color(0xFFD8E7D8),
            borderRadius: const BorderRadius.all(Radius.circular(36)),
            boxShadow:
                isCurrentHour
                    ? [
                      BoxShadow(
                        color: const Color(0xFF0089E4).withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$forecastTemperature\u00B0',
                style: TextStyle(
                  height: 0.8,
                  color:
                      isCurrentHour
                          ? Colors.white
                          : widget.constants.blackColor.withOpacity(.7),
                  fontSize: isCurrentHour ? 22.sp : 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: isCurrentHour ? 40 : 35,
                child: Image.asset(
                  'assets/images/weather/$forecastWeatherIcon',
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                forecastTime,
                style: TextStyle(
                  fontSize: isCurrentHour ? 15.sp : 14.sp,
                  color:
                      isCurrentHour
                          ? Colors.white
                          : widget.constants.blackColor.withOpacity(.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String get12HourTime(String time) {
    final inputDate = DateFormat("HH:mm").parse(time);
    return DateFormat("hh:mm").format(inputDate);
  }
}
