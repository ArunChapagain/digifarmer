import 'dart:convert';
import 'package:digifarmer/constants/constants.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, dynamic>> fetchWeatherData(String location) async {
    final response = await http.get(
      Uri.parse('${weatherAPIBaseURL}forecast.json?key=$weatherAPIKey&days=7&q=$location'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 502) {
      throw Exception('No Internet Connection');
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
