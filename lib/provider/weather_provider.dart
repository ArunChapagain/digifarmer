import 'package:digifarmer/db/preference_db.dart';
import 'package:digifarmer/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  bool _isLoading = false;
  String location = '';
  String weatherIcon = '';
  double temperature = 0.0;
  int windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  String currentDate = '';
  String currentTime = '';
  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];
  String currentWeatherStatus = '';
  String ?currentIcon ;

  Future<void> getWeather() async {
    location = await PreferencesDB.db.getLocation();
    await fetchWeatherData(location);
    notifyListeners();
  }

  Future<void> setAndGetweather(String location) async {
    await PreferencesDB.db.setLocation(location);
    await fetchWeatherData(location);
  }

  Future<void> fetchWeatherData(String searchText) async {
    try {
      _isLoading = true;
      final weatherData = await _weatherService.fetchWeatherData(searchText);
      final locationData = weatherData["location"];
      final currentWeather = weatherData["current"];
      location = getShortLocationName(locationData["name"]);
      currentDate = formatDate(locationData["localtime"]);
      currentTime = get12HourTime(locationData["localtime"].substring(11, 16));
      currentWeatherStatus = currentWeather["condition"]["text"];
      currentIcon = currentWeather["condition"]["icon"];
      print(currentIcon);
      weatherIcon =
          "${currentWeatherStatus.replaceAll(' ', '').toLowerCase()}.png";
      temperature = (currentWeather["temp_c"]).toDouble();
      windSpeed = currentWeather["wind_kph"].toInt();
      humidity = currentWeather["humidity"].toInt();
      cloud = currentWeather["cloud"].toInt();

      dailyWeatherForecast = weatherData["forecast"]["forecastday"];
      hourlyWeatherForecast = dailyWeatherForecast[0]["hour"];

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  String get12HourTime(String time) {
    final inputDate = DateFormat("HH:mm").parse(time);
    return DateFormat("hh:mm a").format(inputDate);
  }

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date.substring(0, 10));
    return DateFormat('MMMMEEEEd').format(parsedDate);
  }

  static String getShortLocationName(String location) {
    final words = location.split(" ");
    return words.length > 1 ? "${words[0]} ${words[1]}" : words[0];
  }

  bool get isLoading => _isLoading;
}
