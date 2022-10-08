
// Custom Post Class
import 'package:cloud_firestore/cloud_firestore.dart';

class GChats{

  late final  String? author_uid;
  late final String groupid;
  late final String? author;
  late final String? message;
  late final  Timeposted;
  late final String receiver;
  late final String receiver_uid;
  late final String? ppurl;
  late final String message_uid;
  late final String appurl;

  GChats(
      { required this.author_uid,
        required this.message_uid,
        required  this.message,
        required this. receiver_uid,
        required this.author,
        required  this.Timeposted,
        required this.ppurl,
        required this.receiver,
        required this.appurl,
        required this.groupid
      }
      );

  Map<String,dynamic> toJson()=>{
    "author uid":author_uid,
    "author":author,
    "Message Time":Timeposted,
    "Profile Pic":ppurl,
    "Message Uid":message_uid,
    "Message":message,
    "Receiver":receiver,
    "Receiver Uid":receiver_uid,
    "author pic":appurl,
    "Group Uid":groupid
  };


  static GChats? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    GChats? Chats12=GChats(
      message: snapshot['Message'],
      author_uid: snapshot['author uid'],
      author: snapshot['author'],
      Timeposted: snapshot['Message Time'],
      ppurl: snapshot['Profile Pic'],
      message_uid: snapshot['Message Uid'],
      receiver: snapshot['Receiver'],
      receiver_uid: snapshot['Receiver Uid'],
      appurl: snapshot['author pic'],
      groupid: snapshot['Group Uid']
    );

    return Chats12;






  }
}
