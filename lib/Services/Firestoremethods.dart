
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forum3/Models/Chats.dart';
import 'package:forum3/Models/Comments.dart';
import 'package:forum3/Models/Notifs.dart';
import 'package:forum3/Models/Posts.dart';
import 'package:forum3/Services/Storagemethods.dart';

import 'package:uuid/uuid.dart';

class FirestoreMethods{
    final FirebaseFirestore _firestore=FirebaseFirestore.instance;

    //Upload post
    Future <String> Uploadpost(
        String Title,
        String Details,
        dynamic file,
        String uid,
        String author,
        String ppurl
        )async{
        String photourl;
        String err;
        try{
            if(file!=null){
                photourl=await StorageMethods().Storageip("Posts", file, true);
            }
            else{
                photourl="";
            }
            String postid= const Uuid().v1();
            Post post=Post(
                author_uid: uid,
                postuid: postid,
                title: Title,
                searchkey: Title.substring(0,1),
                detail: Details,
                author: author,
                Timeposted: DateTime.now(),
                imageUrl: photourl,
                ppurl: ppurl,
                likes: [],
            );

            _firestore.collection("Posts").doc(postid).set(
                post.toJson(),
                SetOptions(merge: true),
            );
            err="success";
            return err;
        }
        catch(e){err=e.toString();
        return err;
        }
    }

    Future<void>likepost(String postid,String author_uid,List likes,String owneruid,String author,String ppurl,String title )async {
        try{
            if(likes.contains(author_uid)){
                await _firestore.collection("Posts").doc(postid).update(
                    {'likes':FieldValue.arrayRemove([author_uid])}
                );
            }else{
                await  _firestore.collection("Posts").doc(postid).update(
                    {'likes':FieldValue.arrayUnion([author_uid])}
                );

                String message=" Liked your post: ";
                String notifid=const Uuid().v1();
                Notifs nots=  Notifs(title: title,ppurl: ppurl,author_uid: author_uid, Eventuid: postid, message: message, author: author, Timeposted: DateTime.now(), owner_uid: owneruid, notifid: notifid);
                await _firestore.collection("Notification").doc(owneruid).collection("Notifs").doc(notifid).set(
                    nots.toJson(),
                    SetOptions(merge: true)
                );
            }

        }catch(e){
            print(e.toString());
        }
    }


    Future<String> postcomment(String postid, String text,String author_uid,String author,String ppurl,String title,String owner_uid) async{
        String ress;
        try{
            if(text.isNotEmpty){
                String commentid=const Uuid().v1();
                Comments comments=Comments(
                    author_uid: author_uid,
                    commentuid: commentid,
                    detail: text,
                    author: author,
                    Timeposted: DateTime.now(),
                    ppurl: ppurl
                );
                await _firestore.collection("Posts").doc(postid).collection("comments").doc(commentid).set(
                    comments.toJson(),
                    SetOptions(merge: true)
                );

                //TODO: Write comment Notification code here
                String notifid=const Uuid().v1();
                String message=" Commented on your post: ";
                Notifs notifs=Notifs(commentuid: commentid,ppurl: ppurl,author_uid: author_uid, notifid: notifid, Eventuid: postid, message: message, author: author, Timeposted: DateTime.now(), owner_uid: owner_uid, title: title);
                await _firestore.collection("Notification").doc(owner_uid).collection("Notifs").doc(notifid).set(
                    notifs.toJson(),
                    SetOptions(merge: true)
                );
                ress="Comment success";
                return ress;
            }
            return "Empty field";
        }catch(e){
            ress=e.toString();
            return ress;
        }
    }

    //Delete post
    Future<String>Deletepost(String postid)async {
        String ress="";
        try{
            await  _firestore.collection("Posts").doc(postid).delete();
            ress="Post Deleted";
            return ress;
        }
        catch(e){
            ress=e.toString();
            return ress;
        }
    }

    Future<String>Deletecomment(String postid,String commentid)async {
        String ress="";
        try{
            await  _firestore.collection("Posts").doc(postid).collection('comments').doc(commentid).delete();
            ress="Comment Deleted";
            return ress;
        }
        catch(e){
            ress=e.toString();
            return ress;
        }
    }

//Edit post
    Future<String>Editpost(String postid,String? title,String? details,dynamic image,bool upload)async{
        String ress;
        String photourl;
        try{
            if(image!=null && upload){
                photourl=await StorageMethods().Storageip("Posts", image, true);
                await  _firestore.collection("Posts").doc(postid).update({
                    'Post Time':DateTime.now(),
                    'Image Url':photourl,
                    'detail':details
                }
                );
                if(title!=""){
                    await   _firestore.collection("Posts").doc(postid).update({
                        'title':title,
                        'searchkey':title!.substring(0,1)
                    });
                }

            }else{
                photourl="";
                await  _firestore.collection("Posts").doc(postid).update({
                    'Post Time':DateTime.now(),
                    'Image Url':photourl,
                    'detail':details
                }
                );
                if(title!=""){
                    await    _firestore.collection("Posts").doc(postid).update({
                        'title':title,
                        'searchkey':title!.substring(0,1)

                    });
                }
            }
            ress="Edit Succesful";
            return ress;
        }catch(e){
            ress=e.toString();
            return ress;
        }
    }

//editcomment
    Future<String>Editcomment(String postid,String commentid,String details)async{
        String ress;
        try{
            await  _firestore.collection("Posts").doc(postid).collection('comments').doc(commentid).update({
                'detail':details,
                'Comment Time':DateTime.now()
            });
            ress="Comment Successfully Edited";
            return ress;
        }catch(e){
            ress=e.toString();
            return ress;
        }

    }

    //Edit Profile
    Future<String> EditProfile(String userid,String Fname,String Username,String DOB,String Bio,String Gender,dynamic image,String Profileurl)async{
        String ress;
        try{
            String ppurl;
            if(image!=null){
                ppurl =await StorageMethods().Storageip("Profilepic", image, false);
            }else{
                ppurl=Profileurl;
            }

            await _firestore.collection('users').doc(userid).update({
                "profilepic":ppurl,
                "Gender":Gender,
                "Full Name":Fname,
                "DateofBirth":DOB,
                "username":Username,
                "Bio":Bio,
            });


            ress="Success";
            return ress;
        }catch(e){
            ress=e.toString();
            return ress;
        }
    }


    Future<void> Updatepostpic(String postid,String ppurl)async{

        await _firestore.collection("Posts").doc(postid).update({
            "profile Pic":ppurl,
        });
    }

    Future<void> Updatecommentpic(String postid,String ppurl,String commentid)async{

        await _firestore.collection("Posts").doc(postid).collection("comments").doc(commentid).update({
            "profile Pic":ppurl,
        });
    }

    Future<String?> Sendmessage(
        String author,
        String author_uid,
        String receiver,
        String receiver_uid,
        String message,
        String ppurl,
        String appurl,
        )async{
        String ress;
        try{

            dynamic Timeposted=DateTime.now();
            String  message_uid= Uuid().v1();

            Chats chats=Chats(
                author_uid: author_uid,
                message_uid: message_uid,
                message: message,
                receiver_uid: receiver_uid,
                author: author,
                Timeposted: Timeposted,
                ppurl: ppurl,
                appurl: appurl,
                receiver: receiver);

            await _firestore
                .collection("Chats")
                .doc(author_uid)
                .collection("Chathead")
                .doc(receiver_uid)
                .collection("message")
                .doc(message_uid)
                .set(
                    chats.toJson(),
                    SetOptions(merge: true)
            );
            await _firestore
                .collection("Chats")
                .doc(author_uid)
                .collection("Chathead")
                .doc(receiver_uid).set(
                {
                    "Sender uid":author_uid,
                    "Sender":author,
                    "Receiver":receiver,
                    "Receiver uid":receiver_uid,
                    "Last Message":message,
                    "Profile Pic":ppurl,
                    "Chat Time":Timeposted,
                    "author pic":appurl,
                },
                SetOptions(merge: true)
            );

//Receiver Side
            Chats chatr=Chats(author_uid: author_uid, message_uid: message_uid, message: message, receiver_uid: receiver_uid, author: author, Timeposted: Timeposted, ppurl: appurl, receiver: receiver, appurl: ppurl);
            await _firestore
                .collection("Chats")
                .doc(receiver_uid)
                .collection("Chathead")
                .doc(author_uid)
                .collection("message")
                .doc(message_uid)
                .set(
                chatr.toJson(),
                SetOptions(merge: true)
            );
            await _firestore
                .collection("Chats")
                .doc(receiver_uid)
                .collection("Chathead")
                .doc(author_uid).set(
                {
                    "Sender uid":receiver_uid,
                    "Sender":receiver,
                    "Receiver":author,
                    "Receiver uid":author_uid,
                    "Last Message":message,
                    "Profile Pic":appurl,
                    "author pic":ppurl,
                    "Chat Time":Timeposted
                },
                SetOptions(merge: true)
            );


            ress="Message Sent";
            return ress;
        }catch(e){
            ress=e.toString();
            return ress;
        }
    }


    Future<String>Deletemessage(  String author,
        String author_uid,
        String receiver,
        String receiver_uid,
        String message_uid,
        )async {
        String ress;
        try{
            //Sender Side
            await _firestore
                .collection("Chats")
                .doc(author_uid)
                .collection("Chathead")
                .doc(receiver_uid)
                .collection("message")
                .doc(message_uid)
                .delete();

            await _firestore
                .collection("Chats")
                .doc(author_uid)
                .collection("Chathead")
                .doc(receiver_uid).update(
                {
                    "Sender uid":author_uid,
                    "Sender":author,
                    "Receiver":receiver,
                    "Receiver uid":receiver_uid,
                    "Last Message":"This message was deleted",
                },
            );

            //Receiver Side
            await _firestore
                .collection("Chats")
                .doc(receiver_uid)
                .collection("Chathead")
                .doc(author_uid)
                .collection("message")
                .doc(message_uid)
                .delete();

            await _firestore
                .collection("Chats")
                .doc(receiver_uid)
                .collection("Chathead")
                .doc(author_uid).update(
                {
                    "Sender uid":receiver_uid,
                    "Sender":receiver,
                    "Receiver":author,
                    "Receiver uid":author_uid,
                    "Last Message":"This message was deleted",
                },
            );

            ress="Message Deleted";
            return ress;
        }catch(e){
            ress=e.toString() ;
            return ress;
        }
    }




}




