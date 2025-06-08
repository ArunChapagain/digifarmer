import 'package:digifarmer/models/news_model.dart';
import 'package:digifarmer/services/news_service.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  final List<NewsModel> _news = [];
  bool _isLoading = false;
  final List newsJson = [];
  NewsService newsService = NewsService();
  Future<void> getNews(int page) async {
    final result = await newsService.fetchNews(1);

    result['articles'].forEach((value) {
      newsJson.add(value);
      _news.add(NewsModel(
        id: value['id'],
        author: value['author'],
        source: value['source']['name'],
        title: value['title'] as String,
        description: value['description'],
        urlToImage: value['urlToImage'],
        publishedAt: value['publishedAt'],
        content: value['content'],
      ));
    });
    // newsJson.forEach((element) {
    //   print(element['title']);
    // });
    _isLoading = false;
    notifyListeners();
  }

  List<NewsModel> get news => _news;
  bool get dataLoading => _isLoading;
}
