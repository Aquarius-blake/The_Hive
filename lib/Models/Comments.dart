
// Custom Post Class

import 'package:cloud_firestore/cloud_firestore.dart';

class Comments{

  late final  String? author_uid;
  late final String? author;
  late final String? title;
  late final String? detail;
  late final  Timeposted;
  late final String? ppurl;
  late final String commentuid;
  late final List likes;


  Comments(
      { required this.author_uid,
    required this.commentuid,
    required  this.detail,
    required this.author,
    this.title,
    required  this.Timeposted,
    this.ppurl,
    required this.likes,
  }
  );

  Map<String,dynamic> toJson()=>{

    "author uid":author_uid,
    "author":author,
    "title":title,
    "Post Time":Timeposted,
    "Profile Pic":ppurl,
    "Comment Uid":commentuid,
    "detail":detail,
    "likes":likes,
  };

  static Comments? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Comments? Comments12=Comments(
        detail: snapshot['detail'],
        author_uid: snapshot['author uid'],
        author: snapshot['author'],
        Timeposted: snapshot['Post Time'],
        ppurl: snapshot['Profile Pic'],
        commentuid: snapshot['Commment Uid'],
        likes: snapshot['likes'],
        title: snapshot['title']
    );

    return Comments12;






  }
}