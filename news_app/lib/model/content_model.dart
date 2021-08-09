
import 'package:intl/intl.dart';

class ContentModel {
  String? title;
  String? text;
  List<Images>? images;
  DateTime? addDate;

  ContentModel({this.title, this.text, this.images, this.addDate});

  ContentModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    if (json['imagess'] != null) {
      images = [];
      json['imagess'].forEach((v) {
        images?.add(new Images.fromJson(v));
      });
    }
    addDate = json['add_date'] == null ? null :DateTime.parse(json['add_date']) ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['text'] = this.text;
    if (this.images != null) {
      data['imagess'] = this.images?.map((v) => v.toJson()).toList();
    }
    data['add_date'] = this.addDate;
    return data;
  }
}

class Images {
  String? url;

  Images({this.url});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

// class ContentModel {
//   String title;
//   String text;
//   List<Null> imagess;
//   String addDate;

//   ContentModel({this.title, this.text, this.imagess, this.addDate});

//   ContentModel.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     text = json['text'];
//     if (json['imagess'] != null) {
//       imagess = new List<Null>();
//       json['imagess'].forEach((v) {
//         imagess.add(new Null.fromJson(v));
//       });
//     }
//     addDate = json['add_date'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['text'] = this.text;
//     if (this.imagess != null) {
//       data['imagess'] = this.imagess.map((v) => v.toJson()).toList();
//     }
//     data['add_date'] = this.addDate;
//     return data;
//   }
// }