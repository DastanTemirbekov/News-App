import 'package:dio/dio.dart';
import 'package:news_app/helpers/news_exceptions.dart';

class ApiRequester {
  static String url = "https://newsapphack2.herokuapp.com/api/v1/";

  Future<Dio> initDio() async {
    return Dio(BaseOptions(
     // headers: {'Accept-Language': 'ru'},
      baseUrl: url,
      responseType: ResponseType.json,
      receiveTimeout: 10000,
      connectTimeout: 10000,
    ));
  }

  Future<Response> toGet(String url, {Map<String, dynamic>? param}) async {
    Dio dio = await initDio();
    try {
      return dio.get(url, queryParameters: param);
    } catch (e) {
      print(e);
      throw NewsExceptions.catchError(e);
    }
  }

  Future<Response> toContentById(String url, {Map<String, dynamic>? param}) async {
    Dio dio = await initDio();
    try {
      return dio.get(url, queryParameters: param);
    } catch (e) {
      print(e);
      throw NewsExceptions.catchError(e);
    }
  }

  Future<Response> toGetNewsbyCategory(String url, {Map<String, dynamic>? param}) async {
    Dio dio = await initDio();
    try {
      return dio.get(url, queryParameters: param);
    } catch (e) {
      print(e);
      throw NewsExceptions.catchError(e);
    }
  }
}
