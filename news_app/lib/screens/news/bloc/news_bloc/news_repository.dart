
import 'package:news_app/model/news_model.dart';
import 'package:news_app/screens/news/bloc/news_bloc/news_provider.dart';


class NewsRepository {
  Future<List<NewsModel>> getNews(lang) {
    NewsProvider provider = NewsProvider();
    return provider.getNews(lang);
  }

  Future<List<NewsModel>> getNewsByCategory(lang, int id) {
    NewsProvider provider = NewsProvider();
    return provider.getNewsByCategory(lang, id);
  }



}

