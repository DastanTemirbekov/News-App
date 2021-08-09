import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:news_app/helpers/news_exceptions.dart';
import 'package:news_app/model/content_model.dart';
import 'package:news_app/screens/content/bloc/content_repository.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentRepository repository = ContentRepository();
  ContentBloc(ContentRepository contentRepository) : super(ContentInitial());

  @override
  Stream<ContentState> mapEventToState(
    ContentEvent event,
  ) async* {
    if (event is GetContentEvent) {
      try {
        ContentModel data = await repository.getContent(id:event.id, lang:event.lang);
        
        print(data.images);
        yield ContentLoaded(data);
      } catch (e) {
        yield ContentError(NewsExceptions.catchError(e));
      }
    }
  }
}
