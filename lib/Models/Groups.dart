

// Custom request Class


import 'package:cloud_firestore/cloud_firestore.dart';

class Group{

  late final  String? author_uid;
  late final String? author;
  late final  Timeposted;
  late final String? ppurl;
  late final String Group_uid;
  late final List members;
  late final String Group_name;
  

  Group(
      { required this.author_uid,
        required this.Group_uid,
        required this.author,
        required  this.Timeposted,
        this.ppurl,
        required this.members
      }
      );

  Map<String,dynamic> toJson()=>{
    "author uid":author_uid,
    "author":author,
    "Creation Time":Timeposted,
    "Profile Pic":ppurl,
    "Request Uid":Group_uid,
    "Members":members
  };

  static Group? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Group? Group12=Group(
      author_uid: snapshot['author uid'],
      author: snapshot['author'],
      Timeposted: snapshot['Creation Time'],
      ppurl: snapshot['Profile Pic'],
      Group_uid: snapshot['Request Uid'],
      members: snapshot['Members']
    );

    return Group12;






  }
}