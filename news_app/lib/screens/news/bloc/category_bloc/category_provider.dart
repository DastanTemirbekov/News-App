import 'package:dio/dio.dart';
import 'package:news_app/helpers/api_requester.dart';
import 'package:news_app/helpers/news_exceptions.dart';
import 'package:news_app/model/category_model.dart';

class CategoryProvider {
  Future<List<CategoryModel>> getCategories(lang, id) async {
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toGet("category", param: {"lang": lang, "id": id});
      if (response.statusCode == 200) {
        response.data.map((val) => print(val));
        return response.data
            .map<CategoryModel>((val) => CategoryModel.fromJson(val))
            .toList();
      }
      throw NewsExceptions.catchError(response);
    } catch (e) {
      print(e);
      throw NewsExceptions.catchError(e);
    }
  }
}
