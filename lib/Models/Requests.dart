

// Custom request Class

import 'package:cloud_firestore/cloud_firestore.dart';

class Request{

  late final  String? author_uid;
  late final String? author;
  late final  Timeposted;
  late final String? ppurl;
  late final String requestuid;

  Request(
      { required this.author_uid,
        required this.requestuid,
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
    "Request Uid":requestuid,
  };

  static Request? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Request? Request12=Request(
      author_uid: snapshot['author uid'],
      author: snapshot['author'],
      Timeposted: snapshot['Request Time'],
      ppurl: snapshot['Profile Pic'],
      requestuid: snapshot['Request Uid'],
    );

    return Request12;
  }
}