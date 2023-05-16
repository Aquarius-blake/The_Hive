
// Custom Notification Class

import 'package:cloud_firestore/cloud_firestore.dart';

class Notifs{
late final String notifid;
  late final  String? author_uid;
  late final String? author;
  late final String? message;
  late final  Timeposted;
  late final String? ppurl;
  late final String Eventuid;
  late final String? commentuid;
  late final String? owner;
  late final String owner_uid;
  late final String title;


  Notifs(
      { required this.author_uid,
        required this.notifid,
        required this.Eventuid,
        this.commentuid,
        required  this.message,
        required this.author,
        required  this.Timeposted,
        this.ppurl,
         this.owner,
        required this.owner_uid,
        required this.title,
      }
      );

  Map<String,dynamic> toJson()=>{
    "author uid":author_uid,
    "author":author,
    "Event Time":Timeposted,
    "Profile Pic":ppurl,
    "Event Uid":Eventuid,
    "message":message,
    "owner":owner,
    "owner uid":owner_uid,
    "Notifid":notifid,
    "Event Title":title,
    "Comment Uid":commentuid,
  };

  static Notifs? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Notifs? Notif12=Notifs(
      notifid: snapshot['Notifid'],
      message: snapshot['message'],
      author_uid: snapshot['author uid'],
      author: snapshot['author'],
      Timeposted: snapshot['Event Time'],
      ppurl: snapshot['Profile Pic'],
      Eventuid: snapshot['Event Uid'],
      owner_uid: snapshot['owner uid'],
      owner: snapshot['owner'],
      title: snapshot['Event Title'],
      commentuid: snapshot['Comment Uid'],


    );

    return Notif12;






  }
}