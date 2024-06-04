import 'package:digifarmer/models/news_model.dart';
import 'package:digifarmer/services/news_service.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  final List<NewsModel> _news = [];
  bool _isLoading = false;

  NewsService newsService = NewsService();
  Future<void> getNews(int page) async {
    final result = await newsService.fetchNews(1);

    result['articles'].forEach((value) {
      _news.add(NewsModel.fromJson(value));
    });
    _isLoading = false;
    notifyListeners();
  }

  set news(List<NewsModel> news) {
    news = _news;
    notifyListeners();
  }

  List<NewsModel> get news => _news;
  bool get dataLoading => _isLoading;
}
