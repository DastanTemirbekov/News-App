part of 'content_bloc.dart';

@immutable
abstract class ContentEvent {}

class GetContentEvent extends ContentEvent {
  String lang;
  int id;
  GetContentEvent(this.lang, this.id);
}
