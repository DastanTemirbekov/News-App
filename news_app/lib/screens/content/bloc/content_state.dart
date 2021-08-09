part of 'content_bloc.dart';

@immutable
abstract class ContentState {}

class ContentInitial extends ContentState {}
class ContentLoading extends ContentState {}

class ContentLoaded extends ContentState {
  final ContentModel contentModel;
  ContentLoaded(this.contentModel);
}


class ContentError extends ContentState {
  final NewsExceptions message;
  ContentError(this.message);
}