import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/model/language_model.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/screens/content/bloc/content_bloc.dart';
import 'package:news_app/screens/content/bloc/content_repository.dart';
import 'package:news_app/screens/content/content_screen.dart';
import 'package:news_app/screens/news/bloc/category_bloc/category_bloc.dart';
import 'package:news_app/screens/news/bloc/news_bloc/news_repository.dart';
import 'bloc/category_bloc/category_repository.dart';
import 'bloc/news_bloc/news_bloc.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({Key? key}) : super(key: key);
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedIndex = 0;
  List<bool> isSelected = [];
  
//String appbarName = 'Новости';
  void _changeLanguage(Language? language) {
    print(language?.languageCode);
  }

  final bloc = NewsBloc(NewsRepository());
  final categoryBloc = CategoryBloc(CategoryRepository());
  final contentBloc = ContentBloc(ContentRepository());

  @override
  void initState() {
    super.initState();

    bloc.add(GetNewsEvent('ru'));
    categoryBloc.add(GetCategoryEvent('ru', 0));
    contentBloc.add(GetContentEvent('ru', 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE5E5E5),
        elevation: 0,
        title: Text(
          //appbarName,
           Language.code == "ru"?
           'Новости':'Жанылыктар',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: [
          DropdownButton(
            onChanged: (Language? language) {
              _changeLanguage(language);
            },
            underline: SizedBox(),
            icon: Icon(
              Icons.language,
              color: Colors.black,
            ),
            items: Language.languageList()
                .map<DropdownMenuItem<Language>>(
                  (lang) => DropdownMenuItem(
                    onTap: () {
                      setState(() {
                        Language.code = lang.languageCode;
                      });
                      bloc.add(GetNewsEvent(lang.languageCode.toString()));
                      Language.code = lang.languageCode;
                      
                      categoryBloc.add(GetCategoryEvent(lang.languageCode.toString(), 0));
                      contentBloc.add(GetContentEvent(lang.languageCode.toString(), 0));

                    },
                    value: lang,
                    child: Row(
                      children: [Text(lang.flag), Text(lang.name)],
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        color: Color(0xffE5E5E5),
        child: Column(
          children: [
            BlocBuilder<CategoryBloc, CategoryState>(
                bloc: categoryBloc,
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is CategoryLoaded) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categoryModel.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                            //  print(state.categoryModel[index].active!);

                              state.categoryModel[index].active =
                                  !state.categoryModel[index].active!;
                                  // print(state.categoryModel[index].active!);
                              
                              bloc.add(GetNewsByCategoryEvent(
                                  'ru',
                                  state.categoryModel[index].id,
                                  state.categoryModel)); 
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            padding: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              color: state.categoryModel[index].active!
                                  ? Color(0xff71C343)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                                state.categoryModel[index].name.toString()),
                          ),
                        ),
                      ),
                    );
                  } else if (state is CategoryError) {
                    return Text(state.message.message.toString());
                  }
                  return Text('Идет загрузка, пожалуйста подождите...');
                }),
            SizedBox(height: 20),
            BlocBuilder<NewsBloc, NewsState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is NewsLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is NewsLoaded) {
                  return Container(
                    
                    height: MediaQuery.of(context).size.height * 0.79,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemExtent: 240,
                      //padding: EdgeInsets.only(bottom: 10),
                      itemCount: state.model.length,
                      itemBuilder: (_, index) => ListTile(
                        
                        title: Container(
                         // padding: EdgeInsets.only(bottom: 40),
                            color: Colors.white,
                            height: 156,
                            child: Image(
                              image: NetworkImage(
                                  state.model[index].firstImage.toString()),
                              fit: BoxFit.cover,
                            )),
                        subtitle: Container(
                          
                          color: Colors.white,
                          height: 60,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Center(
                                  child: Text(
                                    state.model[index].title.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                height: 60,
                                width: 300,
                                // color: Colors.red,
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          Content(id: state.model[index].id!, lang: Language.code),
                                    ));
                                  },
                                  icon: Icon(Icons.keyboard_arrow_right))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is NewsError) {
                  return Container(
                      color: Colors.yellow,
                      height: 50,
                      width: 200,
                      child: Text(state.message.message.toString()));
                }
                return Text('Ошибка в новостях');
              },
            ),
          ],
        ),
      ),
    );
  }
}
