
// Custom Chat/message Class
import 'package:cloud_firestore/cloud_firestore.dart';

class Chats{

  late final  String? author_uid;
  late final String? author;
  late final String? message;
  late final  Timeposted;
  late final String receiver;
  late final String receiver_uid;
  late final String? ppurl;
  late final String message_uid;
  late final String appurl;

  Chats(
      { required this.author_uid,
        required this.message_uid,
        required  this.message,
        required this. receiver_uid,
        required this.author,
        required  this.Timeposted,
        required this.ppurl,
        required this.receiver,
        required this.appurl
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
  };


  static Chats? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Chats? Chats12=Chats(
      message: snapshot['Message'],
      author_uid: snapshot['author uid'],
      author: snapshot['author'],
      Timeposted: snapshot['Message Time'],
      ppurl: snapshot['Profile Pic'],
      message_uid: snapshot['Message Uid'],
      receiver: snapshot['Receiver'],
      receiver_uid: snapshot['Receiver Uid'],
      appurl: snapshot['author pic']
    );

    return Chats12;






  }
}
