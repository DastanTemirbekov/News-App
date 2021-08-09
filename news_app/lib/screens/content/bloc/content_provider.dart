   import 'package:dio/dio.dart';
import 'package:news_app/helpers/api_requester.dart';
import 'package:news_app/helpers/news_exceptions.dart';
import 'package:news_app/model/content_model.dart';


class ContentProvider {
Future<ContentModel> getContent(id, lang) async {
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toGet("news/$id", param: {"lang": lang});
      if (response.statusCode == 200) {
        print(response);
         return ContentModel.fromJson(response.data);
      }
      throw NewsExceptions.catchError(response);
    } catch (e) {
      print(e);
      throw NewsExceptions.catchError(e);
    }
  }
  }