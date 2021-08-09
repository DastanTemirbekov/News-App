part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}
class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categoryModel;
  CategoryLoaded(this.categoryModel);
}


class CategoryError extends CategoryState {
  final NewsExceptions message;
  CategoryError(this.message);
}