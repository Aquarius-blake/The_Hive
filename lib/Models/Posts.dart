
// Custom User Class


import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  late final  String? UID;
  late final String? Email;
  late final String? Password;
  late final bool? Guest;
  dynamic profilepic;
  late final String? Username;
  late final DateTime? DOB;
  late final String? imageurl;
  late final String? ppurl;
  late final String? Name;
  late final String? Gender;


  Post({ this.UID,
    this.profilepic,
    this.Guest,
    this.Username,
    this.Email,
    this.Password,
    this.DOB,
    this.imageurl,
    this.ppurl,
    this.Name,
    this.Gender
  });

  Map<String,dynamic> toJson()=>{
    "username":Username,
    "uid":UID,
    "email":Email,
    "password":Password,
    "DateofBirth":DOB,
    "profilepic":ppurl,
    "Full Name":Name,
    "Gender":Gender,
  };

  static Post? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Post? Post12=Post(
      Username: snapshot['username'],
      UID: snapshot['uid'],
      Email: snapshot['Email'],
      DOB: snapshot['DateofBirth'],
      ppurl: snapshot['profilepic'],
      Name: snapshot['Full Name'],
      Gender: snapshot['Gender'],);

    return Post12;






  }
}