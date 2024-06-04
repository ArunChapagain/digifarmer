import 'package:digifarmer/constants/constants.dart';
import 'package:digifarmer/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsProvider extends ChangeNotifier {
  List<NewsModel> _news = [];
  bool _isLoading = false;

  void fetchNews(int page) async {
    _isLoading = true;
    notifyListeners();
    final response = await http.get(
        // Uri.parse('$newsAPIBaseURL$newsAPIEndPoint&apiKey=$newsAPIKey'),
        Uri.parse(
            '$newsAPIBaseURL$newsAPIEndPoint?q=crops&sortBy=popularity&page=1&pageSize=2&apiKey=$newsAPIKey&page=$page&pageSize=5'));
    if (response.statusCode == 200) {
      // return json.decode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 502) {
      throw Exception('No Internet Connection');
    } else {
      throw Exception('Failed to load weather data');
    }
    _isLoading = false;
    notifyListeners();
  }
//  https://newsapi.org/v2/everything?q=farmers&sortBy=popularity&page=1&pageSize=5&apiKey=e13c1810209a4e6ca7997d39b797152c

  set news(List<NewsModel> news) {
    news = _news;
    notifyListeners();
  }

  List<NewsModel> get news => _news;
  bool get dataLoading => _isLoading;
}
