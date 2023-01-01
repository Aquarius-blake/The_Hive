
// Custom User Class

import 'package:cloud_firestore/cloud_firestore.dart';

class User1{

  late final  String? UID;
  late final String? Email;
  late final bool? Guest;
  dynamic profilepic;
  late final String? Username;
  late  String? searchkey=Username!.substring(0,1);
  late final String? DOB;
  late final String? imageurl;
  late final String? ppurl;
  late final String? Name;
  late final String? Gender;
  late final String? Bio;
  late final bool? Admin;


  User1({ this.UID,
    this.profilepic,
    this.Guest,
    this.Username,
    this.Email,
    this.DOB,
    this.imageurl,
    this.ppurl,
    this.Name,
    this.Gender,
     this.searchkey,
     this.Bio,
     this.Admin
  });

  Map<String,dynamic> toJson()=>{
    "username":Username,
    "searchkey":searchkey,
    "uid":UID,
    "email":Email,
    "DateofBirth":DOB,
    "profilepic":ppurl,
    "Full Name":Name,
    "Gender":Gender,
    "Bio":Bio,
    "Admin":Admin,
    "Guest":Guest,
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
      Gender: snapshot['Gender'],
      searchkey: snapshot['searchkey'],
      Bio: snapshot['Bio'],
      Admin: snapshot['Admin'],
      Guest: snapshot['Guest'],
    );
    return User12;






  }
}