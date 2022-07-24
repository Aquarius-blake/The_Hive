
// Custom Post Class

import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  late final  String? author_uid;
  late final String? author;
  late final String? title;
  late final String? detail;
  late final String? Username;
  late final DateTime? Timeposted;
  late final String? ppurl;
  late final String? imageUrl;
  late final String postuid;
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
    this.imageUrl
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
        postuid: snapshot['Post Uid']
    );

    return Post12;






  }
}