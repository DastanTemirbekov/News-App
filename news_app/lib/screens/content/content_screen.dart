import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/content_model.dart';
import 'package:news_app/screens/content/bloc/content_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'bloc/content_repository.dart';

class Content extends StatefulWidget {
  Content({Key? key, required this.id, required this.lang}) : super(key: key);
  final int id;
  String lang;
  @override
  _ContentState createState() => _ContentState();
}

List<Widget> imgList = [
  Image(
      image: NetworkImage(
          'https://st-0.akipress.org/st_gallery/11/1186111.0cd46e7db7a80c54b78694c684856e88.jpg')),
  Image(
      image: NetworkImage(
          'https://st-0.akipress.org/st_gallery/11/1186111.0cd46e7db7a80c54b78694c684856e88.jpg')),
  Image(
      image: NetworkImage(
          'https://st-0.akipress.org/st_gallery/68/1203168.7086208666554f58d3fe9b4029152b9e.jpg')),
  Image(
      image: NetworkImage(
          'https://static.akipress.org/st_gallery/23/576223.a9da9c5e8cd1d2941471f640036bcfaa.jpg')),
];

class _ContentState extends State<Content> {
  final bloc = ContentBloc(ContentRepository());
  int activeIndex = 0;
  @override
  void initState() {
    bloc.add(GetContentEvent(widget.lang, widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentBloc, ContentState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is ContentLoaded) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                    )),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //height: 84,
                        child: Center(
                          child: Text(
                            state.contentModel.title.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(height: 18),
                      Container(
                        height: 21,
                        child: Text(
                          DateFormat('dd.MM.yyyy')
                              .format(state.contentModel.addDate!),
                          style:
                              TextStyle(color: Color(0xffAEAEAE), fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 18),

                      // Swiper(
                      //   itemCount: imgList.length,
                      //   pagination: SwiperPagination(),
                      //   controller: SwiperController(),
                      //   control: SwiperControl(),
                      //                         itemBuilder: (BuildContext context, int index) {
                      //     return Image.network(imgList[index].toString());

                      //   },
                      //   transformer:,
                      // ),
                      Column(children: [
                        Stack(children: [
                          CarouselSlider(
                            // items:imgList,
                            items:
                                getCaruselWidgets(state.contentModel.images!),
                            options: CarouselOptions(
                              height: 200,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              //reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayCurve: Curves.easeIn,
                              scrollDirection: Axis.horizontal,
                              enlargeCenterPage: true,

                              onPageChanged: (index, reason) =>
                                  setState(() => activeIndex = index),
                            ),
                          ),
                          Positioned(
                            right: 40,
                            top: 25,
                            // bottom: 0,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "${activeIndex + 1}/${state.contentModel.images?.length}",
                                style: TextStyle(color: Colors.white),
                              ),
                              height: 30,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSmoothIndicator(
                              activeIndex: activeIndex,
                              count: state.contentModel.images!.length,
                              effect: SwapEffect(dotColor: Colors.green),
                            ),
                          ],
                        )
                      ]),

                      SizedBox(height: 18),
                      Container(
                        child: Text(
                          state.contentModel.text.toString(),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        } else if (state is ContentError) {
          return Text(state.message.message.toString());
        }
        return Center(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget>? getCaruselWidgets(List<Images> listImages) {
    List<Widget> imgList = [];
    print(listImages);
    for (var i in listImages) {
      imgList.add(
        Image(image: NetworkImage(i.url!)),
      );
    }
    return imgList;
  }
}
