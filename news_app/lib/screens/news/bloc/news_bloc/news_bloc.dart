import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:news_app/helpers/news_exceptions.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/screens/news/bloc/category_bloc/category_repository.dart';
import 'package:news_app/screens/news/bloc/news_bloc/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepository repository = NewsRepository();
  List<NewsModel> data = [];

  NewsBloc(NewsRepository newsRepository) : super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is GetNewsEvent) {
      try {
        yield NewsLoading();
        data = await repository.getNews(event.lang);
        yield NewsLoaded(data);
      } catch (e) {
        yield NewsError(NewsExceptions.catchError(e));
      }
    } else if (event is GetNewsByCategoryEvent) {
      try {
        yield NewsLoading();
        data = [];
        int counter = 0;
        for (var category in event.categoryList) {
          if (category.id == 999 && event.categoryList.first.active == true) {
            category.id == 999 &&
                event.categoryList.first.active == true &&
                category.active! == false;
            data = await repository.getNewsByCategory(event.lang, 999);
          } else if (category.id != 999 && category.active! == true) {
            event.categoryList.first.active = false;
            List<NewsModel> newsList =
                await repository.getNewsByCategory(event.lang, category.id);
            data += newsList;
            counter++;
            print('222');
          }
        }
        if (counter == 0) {
          event.categoryList.first.active = true;
          data = await repository.getNews(event.lang);
        }
        yield NewsLoaded(data);
      } catch (e) {
        yield NewsError(NewsExceptions.catchError(e));
      }
    }
  }
}
