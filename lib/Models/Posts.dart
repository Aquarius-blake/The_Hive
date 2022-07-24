
// Custom Post Class

import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  late final  String? author_uid;
  late final String? author;
  late final String? title;
  late final String? detail;
  late final DateTime? Timeposted;
  late final String? ppurl;
  late final String? imageUrl;
  late final String postuid;
  late final String category;
  late final List likes;
  late final List posturl;

  Post({ required this.author_uid,
    required this.postuid,
    required  this.detail,
    required this.author,
    this.title,
    required  this.Timeposted,
    this.ppurl,
    required this.posturl,
    this.imageUrl,
    required this.category,

  });

  Map<String,dynamic> toJson()=>{

    "author uid":author_uid,
    "author":author,
    "title":title,
    "Post Time":Timeposted,
    "Profile Pic":ppurl,
    "Post Url":posturl,
    "Image Url":imageUrl,
    "Post Uid":postuid,
    "detail":detail,
    "Category":category
  };

  static Post? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Post? Post12=Post(
        detail: snapshot['detail'],
        author_uid: snapshot['author uid'],
        author: snapshot['author'],
        Timeposted: snapshot['Post Time'],
        ppurl: snapshot['Profile Pic'],
        posturl: snapshot['Post url'],
        imageUrl: snapshot['Image Url'],
        postuid: snapshot['Post Uid'],
      category: snapshot['Category']
    );

    return Post12;






  }
}