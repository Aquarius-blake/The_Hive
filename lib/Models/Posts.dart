
// Custom Post Class

import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  late final  String? author_uid;
  late final String? author;
  late final String? title;
  late final String? detail;
  late String? searchkey=title!.substring(0,1);
  late final  Timeposted;
  late final String? ppurl;
  late final String? imageUrl;
  late final String postuid;
  late final List likes;
  late final int nol;
  late final int? noc;


  Post({ required this.author_uid,
    required this.postuid,
    required  this.detail,
    required this.author,
    this.title,
    this.searchkey,
    required  this.Timeposted,
    this.ppurl,
    this.imageUrl,
    required this.likes,
    required this.nol,
     this.noc

  });

  Map<String,dynamic> toJson()=>{

    "author uid":author_uid,
    "author":author,
    "title":title,
    "searchkey":searchkey,
    "Post Time":Timeposted,
    "Profile Pic":ppurl,
    "Image Url":imageUrl,
    "Post Uid":postuid,
    "detail":detail,
    "likes":likes,
    "nol":nol,
    "nocomments":noc
  };

  static Post? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Post? Post12=Post(
        detail: snapshot['detail'],
        author_uid: snapshot['author uid'],
        author: snapshot['author'],
        Timeposted: snapshot['Post Time'],
        ppurl: snapshot['Profile Pic'],
        imageUrl: snapshot['Image Url'],
        postuid: snapshot['Post Uid'],
        likes: snapshot['likes'],
      title: snapshot['title'],
      searchkey: snapshot['searchkey'],
      nol: snapshot['nol'],
      noc: snapshot['nocomments']
    );

    return Post12;






  }
}