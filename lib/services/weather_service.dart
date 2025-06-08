import 'dart:convert';
import 'package:digifarmer/constants/constants.dart';
import 'package:digifarmer/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  // Future<Map<String, dynamic>> fetchWeatherDataViaCity(String location) async {
  //   final response = await http.get(
  //     Uri.parse(
  //       '$weatherAPIBaseURL$weatherAPIEndPoint?key=$weatherAPIKey&days=7&q=$location',
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body) as Map<String, dynamic>;
  //   } else if (response.statusCode == 502) {
  //     throw Exception('No Internet Connection');
  //   } else {
  //     throw Exception('Failed to load weather data');
  //   }
  // }

  Future<Map<String, dynamic>> fetchWeatherDataViaGps(
    double lat,
    double lon,
  ) async {
    final response = await http.get(
      Uri.parse(
        '$weatherAPIBaseURL$weatherAPIEndPoint?key=$weatherAPIKey&days=7&q=$lat,$lon',
      ),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 502) {
      throw Exception('No Internet Connection');
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<WeatherModel> fetchWeatherDataViaCity(String location) async {
    final response = await http.get(
      Uri.parse(
        '$weatherAPIBaseURL$weatherAPIEndPoint?key=$weatherAPIKey&days=7&q=$location',
      ),
    );
    if (response.statusCode == 200) {
      return weatherModelFromJson(response.body);
    } else if (response.statusCode == 502) {
      throw Exception('No Internet Connection');
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
// https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

/*
{"location":{"name":"Pokhara","region":"","country":"Nepal","lat":28.19,"lon":84.03,"tz_id":"Asia/Kathmandu","localtime_epoch":1722345928,"localtime":"2024-07-30 19:10"},"current":{"last_updated_epoch":1722345300,"last_updated":"2024-07-30 19:00","temp_c":22.8,"temp_f":73.0,"is_day":0,"condition":{"text":"Light rain shower","icon":"//cdn.weatherapi.com/weather/64x64/night/353.png","code":1240},"wind_mph":2.2,"wind_kph":3.6,"wind_degree":34,"wind_dir":"NE","pressure_mb":1002.0,"pressure_in":29.6,"precip_mm":0.62,"precip_in":0.02,"humidity":92,"cloud":95,"feelslike_c":25.1,"feelslike_f":77.2,"windchill_c":22.8,"windchill_f":73.0,"heatindex_c":25.1,"heatindex_f":77.2,"dewpoint_c":21.5,"dewpoint_f":70.7,"vis_km":10.0,"vis_miles":6.0,"uv":1.0,"gust_mph":3.9,"gust_kph":6.3},"forecast":{"forecastday":[{"date":"2024-07-30","date_epoch":1722297600,"day":{"maxtemp_c":28.8,"maxtemp_f":83.9,"mintemp_c":21.5,"mintemp_f":70.8,"avgtemp_c":24.7,"avgtemp_f":76.4,"maxwind_mph":4.0,"maxwind_kph":6.5,"totalprecip_mm":22.78,"tot
*/

/*
{"location":{"name":"Pokhara","region":"","country":"Nepal","lat":28.23,"lon":83.98,"tz_id":"Asia/Kathmandu","localtime_epoch":1722346019,"localtime":"2024-07-30 19:11"},"current":{"last_updated_epoch":1722345300,"last_updated":"2024-07-30 19:00","temp_c":20.5,"temp_f":68.9,"is_day":0,"condition":{"text":"Light drizzle","icon":"//cdn.weatherapi.com/weather/64x64/night/266.png","code":1153},"wind_mph":2.2,"wind_kph":3.6,"wind_degree":39,"wind_dir":"NE","pressure_mb":1003.0,"pressure_in":29.6,"precip_mm":0.49,"precip_in":0.02,"humidity":93,"cloud":100,"feelslike_c":20.5,"feelslike_f":68.9,"windchill_c":20.5,"windchill_f":68.9,"heatindex_c":20.5,"heatindex_f":68.9,"dewpoint_c":19.2,"dewpoint_f":66.6,"vis_km":2.0,"vis_miles":1.0,"uv":1.0,"gust_mph":3.8,"gust_kph":6.0},"forecast":{"forecastday":[{"date":"2024-07-30","date_epoch":1722297600,"day":{"maxtemp_c":28.4,"maxtemp_f":83.2,"mintemp_c":20.2,"mintemp_f":68.4,"avgtemp_c":23.9,"avgtemp_f":75.0,"maxwind_mph":4.0,"maxwind_kph":6.5,"totalprecip_mm":22.43,"totalpr
*/
