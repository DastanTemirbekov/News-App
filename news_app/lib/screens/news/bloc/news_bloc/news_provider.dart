import 'package:dio/dio.dart';
import 'package:news_app/helpers/api_requester.dart';
import 'package:news_app/helpers/news_exceptions.dart';

import 'package:news_app/model/news_model.dart';

class NewsProvider {
  Future<List<NewsModel>> getNews(lang) async {
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toGet("news",  param: {"lang": lang});
      if (response.statusCode == 200) {
        response.data.map((val) => print(val));
        return response.data.map<NewsModel>((val) => NewsModel.fromJson(val)).toList();
      }
      throw NewsExceptions.catchError(response);
    } catch (e) {
      print(e);
      throw NewsExceptions.catchError(e);
    }
  }
 Future<List<NewsModel>> getNewsByCategory(String lang, int id) async {
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toGetNewsbyCategory("news", param:{'lang': lang, "search": id});
      if (response.statusCode == 200) {
        response.data.map((val) => print(val));
        return response.data.map<NewsModel>((val) => NewsModel.fromJson(val)).toList();
      }
      throw NewsExceptions.catchError(response);
    } catch (e) {
      print(e);
      throw NewsExceptions.catchError(e);
    }
  }

}