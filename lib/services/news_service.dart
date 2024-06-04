import 'dart:convert';

import 'package:digifarmer/constants/constants.dart';
import 'package:http/http.dart' as http;

class NewsService{

  Future<Map<String,dynamic>> fetchNews(int page) async {
    final response = await http.get(
        // Uri.parse('$newsAPIBaseURL$newsAPIEndPoint&apiKey=$newsAPIKey'),
        Uri.parse(
            '$newsAPIBaseURL$newsAPIEndPoint?q=crops&sortBy=popularity&page=1&pageSize=2&apiKey=$newsAPIKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String,dynamic>;
    } else if (response.statusCode == 502) {
      throw Exception('No Internet Connection');
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}