import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String API_KEY = '73f49df9790a4edabce175946242105';
  static const String baseURL = 'https://api.weatherapi.com/v1/';

  Future<Map<String, dynamic>> fetchWeatherData(String location) async {
    final response = await http.get(
      Uri.parse('${baseURL}forecast.json?key=$API_KEY&days=7&q=$location'),
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
