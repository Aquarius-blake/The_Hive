
// Custom Post Class

import 'package:cloud_firestore/cloud_firestore.dart';

class Notifs{

  late final  String? author_uid;
  late final String? author;
  late final String? detail;
  late final  Timeposted;
  late final String? ppurl;
  late final String commentuid;

  Notifs(
      { required this.author_uid,
        required this.commentuid,
        required  this.detail,
        required this.author,
        required  this.Timeposted,
        this.ppurl,
      }
      );

  Map<String,dynamic> toJson()=>{
    "author uid":author_uid,
    "author":author,
    "Comment Time":Timeposted,
    "Profile Pic":ppurl,
    "Comment Uid":commentuid,
    "detail":detail,
  };

  static Notifs? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Notifs? Notif12=Notifs(
      detail: snapshot['detail'],
      author_uid: snapshot['author uid'],
      author: snapshot['author'],
      Timeposted: snapshot['Comment Time'],
      ppurl: snapshot['Profile Pic'],
      commentuid: snapshot['Comment Uid'],
    );

    return Notif12;






  }
}