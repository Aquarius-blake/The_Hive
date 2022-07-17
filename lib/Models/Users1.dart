
// Custom User Class


import 'package:cloud_firestore/cloud_firestore.dart';

class User1{

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


  User1({ this.UID,
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

  static User1? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    User1? User12=User1(
      Username: snapshot['username'],
      UID: snapshot['uid'],
      Email: snapshot['Email'],
      DOB: snapshot['DateofBirth'],
      ppurl: snapshot['profilepic'],
      Name: snapshot['Full Name'],
      Gender: snapshot['Gender'],);

    return User12;






  }
}