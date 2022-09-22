

// Custom request Class


import 'package:cloud_firestore/cloud_firestore.dart';

class Group{

  late final  String? author_uid;
  late final String? author;
  late final  Timeposted;
  late final String? ppurl;
  late final String Group_uid;

  Group(
      { required this.author_uid,
        required this.Group_uid,
        required this.author,
        required  this.Timeposted,
        this.ppurl,
      }
      );

  Map<String,dynamic> toJson()=>{
    "author uid":author_uid,
    "author":author,
    "Request Time":Timeposted,
    "Profile Pic":ppurl,
    "Request Uid":Group_uid,
  };

  static Group? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Group? Request12=Group(
      author_uid: snapshot['author uid'],
      author: snapshot['author'],
      Timeposted: snapshot['Request Time'],
      ppurl: snapshot['Profile Pic'],
      Group_uid: snapshot['Request Uid'],
    );

    return Request12;






  }
}