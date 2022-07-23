
// Custom User Class


import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  late final  String? author_uid;
  late final String? author;
  late final String? title;
  late final String? detail;
  dynamic profilepic;
  late final String? Username;
  late final DateTime? DOB;
  late final String? imageurl;
  late final String? ppurl;
  late final String? Name;
  late final String? Gender;


  Post({ this.author_uid,
    this.profilepic,
    this.detail,
    this.Username,
    this.author,
    this.title,
    this.DOB,
    this.imageurl,
    this.ppurl,
    this.Name,
    this.Gender
  });

  Map<String,dynamic> toJson()=>{
    "username":Username,
    "author uid":author_uid,
    "author":author,
    "title":title,
    "DateofBirth":DOB,
    "profilepic":ppurl,
    "Full Name":Name,
    "Gender":Gender,
  };

  static Post? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Post? Post12=Post(
      Username: snapshot['username'],
      author_uid: snapshot['author uid'],
      author: snapshot['author'],
      DOB: snapshot['DateofBirth'],
      ppurl: snapshot['profilepic'],
      Name: snapshot['Full Name'],
      Gender: snapshot['Gender'],);

    return Post12;






  }
}