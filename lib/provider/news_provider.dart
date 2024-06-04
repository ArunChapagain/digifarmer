import 'package:digifarmer/models/news_model.dart';
import 'package:digifarmer/services/news_service.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel> _news = [];
  bool _isLoading = false;
  NewsService newsService = NewsService();
  Future<void> getNews(int page) async {
    final result = await newsService.fetchNews(1);
  //  _news= result.map((value) {
  //     return NewsModel.fromJson(value);
  //   });
  }

  set news(List<NewsModel> news) {
    news = _news;
    notifyListeners();
  }

  List<NewsModel> get news => _news;
  bool get dataLoading => _isLoading;
}


//  {
//       "source": {
//         "id": "business-insider",
//         "name": "Business Insider"
//       },
//       "author": "Lauren Edmonds",
//       "title": "No bean coffee made from things like date seeds may be in our near future",
//       "description": "The popularity of coffee is devastating the environment. So some companies are developing lab grown coffee, or coffee made from other ingredients.",
//       "url": "https://www.businessinsider.com/lab-grown-coffee-beanless-alternatives-date-seeds-atomo-climate-crisis-2024-5",
//       "urlToImage": "https://i.insider.com/663695b70dfb1341e902a98b?width=1200&format=jpeg",
//       "publishedAt": "2024-05-05T14:20:30Z",
//       "content": "Coffee production has several downfalls.Michelle Lee Photography/Getty Images\r\n\u003Cul\u003E\u003Cli\u003ECoffee is so popular that bean-growing crops are devastating the environment.\u003C/li\u003E\u003Cli\u003ESo some companies are usin… [+1845 chars]"
//     }