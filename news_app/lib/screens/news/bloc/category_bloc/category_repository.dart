import 'package:news_app/model/category_model.dart';
import 'package:news_app/screens/news/bloc/category_bloc/category_provider.dart';

class CategoryRepository {
  Future<List<CategoryModel>> getCategories(lang, id) {
    CategoryProvider provider = CategoryProvider();
    return provider.getCategories(lang, id);
  }
}
