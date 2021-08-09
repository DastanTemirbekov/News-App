part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState{}

class NewsLoaded extends NewsState {
  final List<NewsModel> model;
  NewsLoaded(this.model);
}

class NewsError extends NewsState {
  final NewsExceptions message;
  NewsError(this.message);
}