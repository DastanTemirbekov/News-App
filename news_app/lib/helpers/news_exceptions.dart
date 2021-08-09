import 'package:dio/dio.dart';

class NewsExceptions {
  String? message;

  NewsExceptions({this.message});

  static NewsExceptions catchError(dynamic error) {
    if (error is DioError) {
      if (error.type == DioErrorType.connectTimeout) {
        return NewsExceptions(message: "Время ожидания истекло");
      } else if (error.type == DioErrorType.response) {
        return NewsExceptions(message: "Ошибка в системе");
      }
      // else if(error.response!.statusCode == 404){
      //   return NewsExceptions(message: "404");
      // }
    } else {
      return NewsExceptions(message: "Произошла системная ошибка");
    }
    return NewsExceptions(message: "Произошла ошибка");
  }
}
