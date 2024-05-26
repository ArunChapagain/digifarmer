import 'package:digifarmer/theme/constants.dart';
import 'package:digifarmer/view/weather/widgets/weather_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ForecastsScreen extends StatefulWidget {
  final dailyForecastWeather;

  const ForecastsScreen({super.key, required this.dailyForecastWeather});

  @override
  State<ForecastsScreen> createState() => _ForecastsScreenState();
}

class _ForecastsScreenState extends State<ForecastsScreen> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    Map getForecastWeather(int index) {
      var day = weatherData[index]["day"];
      int maxWindSpeed = day["maxwind_kph"].toInt();
      int avgHumidity = day["avghumidity"].toInt();
      int chanceOfRain = day["daily_chance_of_rain"].toInt();
      int minTemperature = day["mintemp_c"].toInt();
      int maxTemperature = day["maxtemp_c"].toInt();
      String weatherName = day["condition"]["text"];
      String weatherIcon =
          "${weatherName.replaceAll(' ', '').toLowerCase()}.png";
      String forecastDate = DateFormat('EEEE, d MMMM')
          .format(DateTime.parse(weatherData[index]["date"]));

      return {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature,
      };
    }

    Widget buildWeatherItemRow(Map forecast) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeatherItem(
            value: forecast["maxWindSpeed"],
            unit: "km/h",
            imageUrl: "assets/images/weather/windspeed.png",
          ),
          WeatherItem(
            value: forecast["avgHumidity"],
            unit: "%",
            imageUrl: "assets/images/weather/humidity.png",
          ),
          WeatherItem(
            value: forecast["chanceOfRain"],
            unit: "%",
            imageUrl: "assets/images/weather/lightrain.png",
          ),
        ],
      );
    }

    Widget buildTemperatureRow(
        Map forecast, TextStyle tempStyle, TextStyle degreeStyle) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            forecast["maxTemperature"].toString(),
            style: tempStyle,
          ),
          Text(
            'o',
            style: degreeStyle,
          ),
          Text(
            'C',
            style: tempStyle,
          ),
        ],
      );
    }

    Widget temperatureDisplay(String temperature) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: temperature,
              style: TextStyle(
                color: _constants.blackColor.withOpacity(.7),
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: '\u00B0C',
              style: TextStyle(
                color: _constants.blackColor.withOpacity(.7),
                fontSize: 22, // adjust the size to fit your needs
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    Widget cardWeatherItem(String imagePath, String prediction) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 5),
          Image.asset(imagePath, width: 35),
          Text(
            "$prediction%",
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      );
    }

    Widget buildForecastCard(Map forecast) {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 5,
                color: _constants.primaryColor.withOpacity(.4)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    forecast["forecastDate"],
                    style: TextStyle(
                      color: const Color(0xff6696f5),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      temperatureDisplay(forecast["minTemperature"].toString()),
                      Text('/',
                          style: TextStyle(
                            color: Colors.black.withOpacity(.7),
                            fontSize:
                                14.sp, // adjust the size to fit your needs
                            fontWeight: FontWeight.w600,
                          )),
                      temperatureDisplay(forecast["maxTemperature"].toString()),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          'assets/images/weather/${forecast["weatherIcon"]}',
                          width: 60),
                      const SizedBox(width: 5),
                      Text(
                        forecast["weatherName"] == 'Patchy rain nearby'
                            ? 'Partially cloudy'
                            : forecast["weatherName"],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      cardWeatherItem(
                        'assets/images/weather/windspeed.png',
                        forecast["maxWindSpeed"].toString(),
                      ),
                      const SizedBox(width: 10),
                      cardWeatherItem(
                        'assets/images/weather/humidity.png',
                        forecast["avgHumidity"].toString(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      cardWeatherItem(
                        'assets/images/weather/lightrain.png',
                        forecast["chanceOfRain"].toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _constants.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Forecasts',
          style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: size.height * .75,
                width: size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -100,
                      right: 20,
                      left: 20,
                      child: Container(
                        height: 290,
                        width: size.width * .7,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.center,
                              colors: [
                                Color(0xffa9c1f5),
                                Color(0xff6696f5),
                              ]),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(.1),
                              offset: const Offset(0, 15),
                              blurRadius: 3,
                              spreadRadius: -10,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 20,
                              width: 130,
                              child: Image.asset(
                                "assets/images/weather/${getForecastWeather(0)["weatherIcon"]}",
                                // width: 120,
                              ),
                            ),
                            Positioned(
                              top: 160,
                              left: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  getForecastWeather(0)["weatherName"],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                width: size.width * .8,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child:
                                    buildWeatherItemRow(getForecastWeather(0)),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: buildTemperatureRow(
                                getForecastWeather(0),
                                TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = _constants.shader,
                                ),
                                TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = _constants.shader,
                                ),
                              ),
                            ),
                            Positioned(
                                top: 320,
                                left: 0,
                                child: SizedBox(
                                  height: 700,
                                  width: size.width * .9,
                                  child: ListView.builder(
                                    itemCount: 3,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return buildForecastCard(
                                          getForecastWeather(index + 1));
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
