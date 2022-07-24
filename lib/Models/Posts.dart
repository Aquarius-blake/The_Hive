
// Custom User Class


import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  late final  String? author_uid;
  late final String? author;
  late final String? title;
  late final String? detail;
  dynamic profilepic;
  late final String? Username;
  late final DateTime? Timeposted;
  late final String? imageurl;
  late final String? ppurl;
  late final String? Name;
  late final String? imageUrl;
  late final String postuid;
late final List likes;
late final List posturl;

  Post({ this.author_uid,
    required this.postuid,
    this.profilepic,
    this.detail,
    this.Username,
    this.author,
    this.title,
    this.Timeposted,
    this.imageurl,
    this.ppurl,
   required this.posturl,
    this.imageUrl
  });

  Map<String,dynamic> toJson()=>{
    "username":Username,
    "author uid":author_uid,
    "author":author,
    "title":title,
    "Post Time":Timeposted,
    "profilepic":ppurl,
    "Post Url":posturl,
    "Imageurl":imageUrl,
  };

  static Post? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Post? Post12=Post(
      Username: snapshot['username'],
      author_uid: snapshot['author uid'],
      author: snapshot['author'],
      Timeposted: snapshot['Post Time'],
      ppurl: snapshot['profilepic'],
      posturl: snapshot['Post url'],
      imageUrl: snapshot['Imageurl'],);

    return Post12;






  }
}