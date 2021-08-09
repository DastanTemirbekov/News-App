part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}



class GetNewsEvent extends NewsEvent {
  String lang;
  GetNewsEvent(this.lang);
}

class GetNewsByCategoryEvent extends NewsEvent {
  List<CategoryModel> categoryList;
  String lang;
  int id;
   GetNewsByCategoryEvent(this.lang, this.id, this.categoryList);
}

