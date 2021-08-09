import 'package:news_app/model/content_model.dart';
import 'package:news_app/screens/content/bloc/content_provider.dart';

class ContentRepository {

    Future<ContentModel> getContent({id, lang}) {
    ContentProvider provider = ContentProvider();
    return provider.getContent(id, lang);
  }
  
}
