
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
late List likes;

  Post({ this.author_uid,
    this.profilepic,
    this.detail,
    this.Username,
    this.author,
    this.title,
    this.Timeposted,
    this.imageurl,
    this.ppurl,
    this.Name,
    this.imageUrl
  });

  Map<String,dynamic> toJson()=>{
    "username":Username,
    "author uid":author_uid,
    "author":author,
    "title":title,
    "Post Time":Timeposted,
    "profilepic":ppurl,
    "Full Name":Name,
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
      Name: snapshot['Full Name'],
      imageUrl: snapshot['Imageurl'],);

    return Post12;






  }
}