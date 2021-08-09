import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/helpers/news_exceptions.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/screens/news/bloc/category_bloc/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository repository = CategoryRepository();
  CategoryBloc(CategoryRepository categoryRepository) : super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
       if (event is GetCategoryEvent) {
      try {
                
         CategoryModel _all;
        List<CategoryModel> category = await repository.getCategories(event.lang, event.id);
        if(event.lang == 'ru'){
           _all= CategoryModel(name: 'Все', id: 999, active: true);
        }
        else _all= CategoryModel(name: 'Баары', id: 999, active: true);
        category.insert(0, _all);

        yield CategoryLoaded(category);
      } catch (e) {
        yield CategoryError(NewsExceptions.catchError(e));
      }
  }
}
}
