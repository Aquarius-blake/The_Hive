

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
  late final String Group_description;
  late final String? Header; 

  Group(
      { required this.author_uid,
        required this.Group_uid,
        required this.author,
        required  this.Timeposted,
        this.ppurl,
        required this.members,
        required this.Group_name,
        required this.Group_description,
        this.Header
      }
      );

  Map<String,dynamic> toJson()=>{
    "author uid":author_uid,
    "author":author,
    "Creation Time":Timeposted,
    "Group Pic":ppurl,
    "Group Uid":Group_uid,
    "Members":members,
    "Group Name":Group_name,
    "Group Description":Group_description,
    "Header":Header
  };

  static Group? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Group? Group12=Group(
      author_uid: snapshot['author uid'],
      author: snapshot['author'],
      Timeposted: snapshot['Creation Time'],
      ppurl: snapshot['Group Pic'],
      Group_uid: snapshot['Group Uid'],
      members: snapshot['Members'],
      Group_name: snapshot['Group Name'],
      Group_description: snapshot['Group Description'],
      Header: snapshot['Header']
    );

    return Group12;






  }
}