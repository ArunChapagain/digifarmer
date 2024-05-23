import 'package:digifarmer/provider/weather_provider.dart';
import 'package:digifarmer/theme/constants.dart';
import 'package:digifarmer/view/weather/forecasts.dart';
import 'package:digifarmer/view/weather/widgets/reload_weather.dart';
import 'package:digifarmer/view/weather/widgets/weather_item.dart';
import 'package:digifarmer/widgets/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottom_sheet;

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
        child: Consumer<WeatherProvider>(
            builder: (context, weatherProvider, chid) {
          if (weatherProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.w),
                  Text(
                    'Weather',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 35.sp,
                      fontFamily: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                      ).fontFamily,
                      height: 0.1,
                    ),
                  ),
                  SizedBox(height: 30.w),
                  weatherCard(
                      constants: _constants, weatherProvider: weatherProvider),
                  SizedBox(height: 20.w),
                  TodayForecast(
                      dailyWeatherForecast:
                          weatherProvider.dailyWeatherForecast,
                      hourlyWeatherForecast:
                          weatherProvider.hourlyWeatherForecast,
                      constants: _constants),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget weatherCard(
      {required Constants constants,
      required WeatherProvider weatherProvider}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
      height: 310.h,
      decoration: BoxDecoration(
        gradient: constants.linearGradientBlue,
        boxShadow: [
          BoxShadow(
            color: constants.primaryColor.withOpacity(.5),
            spreadRadius: 5.r,
            blurRadius: 7.r,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          weatherCardLeadingRow(context, weatherProvider),
          Image.asset("assets/images/weather/${weatherProvider.weatherIcon}",
              height: 100.w),
          TemperatureDisplay(
              temperature: weatherProvider.temperature, constants: constants),
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
              currentDate: weatherProvider.currentDate),
          const Divider(color: Colors.white70, indent: 20, endIndent: 20),
          WeatherStatsRow(
              windSpeed: weatherProvider.windSpeed,
              humidity: weatherProvider.humidity,
              cloud: weatherProvider.cloud),
        ],
      ),
    );
  }

  Widget weatherCardLeadingRow(
      BuildContext context, WeatherProvider weatherProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocationDisplay(
              location: weatherProvider.location,
              cityController: _cityController,
              fetchWeatherData: weatherProvider.fetchWeatherData,
              constants: _constants),
          AnimatedPress(
            child: RotatingIconButton(
              onPressed: () {
                weatherProvider.setAndGetweather(_cityController.text);
              },
            ),
          )
          // ReloadWeatherButton(
          //   onPressed: () {
          //     weatherProvider.setAndGetweather(_cityController.text);
          //   },
          // )
        ],
      ),
    );
  }
}

class TemperatureDisplay extends StatelessWidget {
  final double temperature;
  final Constants constants;

  const TemperatureDisplay(
      {super.key, required this.temperature, required this.constants});

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
                    foreground: Paint()..shader = constants.shader),
              ),
              TextSpan(
                text: '\u00B0C',
                style: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = constants.shader),
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

  const DateTimeDisplay(
      {super.key, required this.currentTime, required this.currentDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(currentTime,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18.sp,
            )),
        SizedBox(width: 5.w),
        Text(currentDate,
            style: TextStyle(color: Colors.white70, fontSize: 18.sp)),
      ],
    );
  }
}

class WeatherStatsRow extends StatelessWidget {
  final int windSpeed;
  final int humidity;
  final int cloud;

  const WeatherStatsRow(
      {super.key,
      required this.windSpeed,
      required this.humidity,
      required this.cloud});

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
              imageUrl: 'assets/images/weather/windspeed.png'),
          WeatherItem(
              value: humidity,
              unit: '%',
              imageUrl: 'assets/images/weather/humidity.png'),
          WeatherItem(
              value: cloud,
              unit: '%',
              imageUrl: 'assets/images/weather/cloud.png'),
        ],
      ),
    );
  }
}

class LocationDisplay extends StatelessWidget {
  final String location;
  final TextEditingController cityController;
  final Function fetchWeatherData;
  final Constants constants;

  const LocationDisplay(
      {super.key,
      required this.location,
      required this.cityController,
      required this.fetchWeatherData,
      required this.constants});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/images/weather/pin.png", width: 20.w),
        const SizedBox(width: 2),
        Text(
          location,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          onPressed: () {
            cityController.clear();
            bottom_sheet.showMaterialModalBottomSheet(
              context: context,
              builder: (context) => SingleChildScrollView(
                controller: bottom_sheet.ModalScrollController.of(context),
                child: SearchCityBottomSheet(
                    cityController: cityController,
                    fetchWeatherData: fetchWeatherData,
                    constants: constants),
              ),
            );
          },
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
        ),
      ],
    );
  }
}

class SearchCityBottomSheet extends StatelessWidget {
  final TextEditingController cityController;
  final Function fetchWeatherData;
  final Constants constants;

  const SearchCityBottomSheet(
      {super.key,
      required this.cityController,
      required this.fetchWeatherData,
      required this.constants});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          SizedBox(
              width: 70,
              child: Divider(thickness: 3.5, color: constants.primaryColor)),
          const SizedBox(height: 10),
          TextField(
            // onChanged: (searchText) => fetchWeatherData(searchText),
            controller: cityController,
            autofocus: true,
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
          SizedBox(
            height: 20.w,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Provider.of<WeatherProvider>(context, listen: false)
                    .setAndGetweather(cityController.text);
              },
              child: AnimatedPress(
                child: Container(
                  width: 110.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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

  const TodayForecast(
      {super.key,
      required this.dailyWeatherForecast,
      required this.hourlyWeatherForecast,
      required this.constants});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Today',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ForecastsScreen(
                          dailyForecastWeather: dailyWeatherForecast))),
              child: AnimatedPress(
                child: Text('Forecasts',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25.sp,
                        color: const Color(0xFF00A4E4))),
              ),
            ),
          ],
        ),
        SizedBox(
            height: 150.w,
            child: HourlyForecastList(
                hourlyWeatherForecast: hourlyWeatherForecast,
                constants: constants)),
      ],
    );
  }
}

class HourlyForecastList extends StatelessWidget {
  final List hourlyWeatherForecast;
  final Constants constants;

  const HourlyForecastList(
      {super.key,
      required this.hourlyWeatherForecast,
      required this.constants});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hourlyWeatherForecast.length,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        vertical: 10.w,
        horizontal: 10.w,
      ),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final forecast = hourlyWeatherForecast[index];
        final forecastTime = get12HourTime(forecast["time"].substring(11, 16));
        final forecastTemperature = forecast["temp_c"].round().toString();
        final forecastWeatherName = forecast["condition"]["text"];
        final forecastWeatherIcon =
            "${forecastWeatherName.replaceAll(' ', '').toLowerCase()}.png";

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 110.w,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 5,
                color: constants.primaryColor.withOpacity(.4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(forecastTime,
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: constants.blackColor.withOpacity(.7),
                      fontWeight: FontWeight.w500)),
              Image.asset(
                'assets/images/weather/$forecastWeatherIcon',
                width: 45.w,
              ),
              Text('$forecastTemperature\u00B0C',
                  style: TextStyle(
                      color: constants.blackColor.withOpacity(.7),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        );
      },
    );
  }

  String get12HourTime(String time) {
    final inputDate = DateFormat("HH:mm").parse(time);
    return DateFormat("hh:mm a").format(inputDate);
  }
}
