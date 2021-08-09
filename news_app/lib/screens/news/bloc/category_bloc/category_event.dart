part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class GetCategoryEvent extends CategoryEvent {
  String lang;
  int id;
  GetCategoryEvent(this.lang, this.id);
}

