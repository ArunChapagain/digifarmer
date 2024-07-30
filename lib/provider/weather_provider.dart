import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:digifarmer/db/preference_db.dart';
import 'package:digifarmer/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  // WeatherProvider(this.latitude, this.longitude);

  // final double? latitude;
  // final double? longitude;
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
  String? currentIcon;

  bool get isLoading => _isLoading;

  Future<void> getWeather() async {
    location = await PreferencesDB.db.getLocation();
    await fetchWeatherDataViaCity(location);
    notifyListeners();
  }

  Future<void> setAndGetWeather(String location) async {
    await setLocation(location);
    await fetchWeatherDataViaCity(location);
  }

  Future<void> setLocation(String location) async {
    this.location = location;
    await PreferencesDB.db.setLocation(location);
  }

  Future<void> setWeatherData(dynamic weatherData) async {
    print('weatherData: $weatherData');

    final locationData = weatherData["location"];
    final currentWeather = weatherData["current"];
    location = getShortLocationName(locationData["name"]);
    await setLocation(location);
    currentDate = formatDate(locationData["localtime"]);
    currentTime = get12HourTime(locationData["localtime"].substring(11, 16));
    currentWeatherStatus = currentWeather["condition"]["text"];
    currentIcon = currentWeather["condition"]["icon"];
    weatherIcon =
        "${currentWeatherStatus.replaceAll(' ', '').toLowerCase()}.png";
    temperature = (currentWeather["temp_c"]).toDouble();
    windSpeed = currentWeather["wind_kph"].toInt();
    humidity = currentWeather["humidity"].toInt();
    cloud = currentWeather["cloud"].toInt();

    dailyWeatherForecast = weatherData["forecast"]["forecastday"];
    hourlyWeatherForecast = dailyWeatherForecast[0]["hour"];
    notifyListeners();
  }

  Future<void> fetchWeatherDataViaCity(String searchText) async {
    try {
      _isLoading = true;
      notifyListeners();
      final weatherData =
          await _weatherService.fetchWeatherDataViaCity(searchText);
      await setWeatherData(weatherData);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      // Handle error
    }
  }

  Future<void> fetchWeatherDataViaGps(double latitude, double longitude) async {
    // Future<void> fetchWeatherDataViaGps( ) async {
    try {
      _isLoading = true;
      notifyListeners();
      if (latitude == null || longitude == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      final weatherData =
          await _weatherService.fetchWeatherDataViaGps(latitude!, longitude!);
      await setWeatherData(weatherData);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
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
}
