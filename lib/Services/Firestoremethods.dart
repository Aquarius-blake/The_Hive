
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Comments.dart';
import 'package:forum3/Models/Group_chat.dart';
import 'package:forum3/Models/Groups.dart';
import 'package:forum3/Models/Notifs.dart';
import 'package:forum3/Models/Posts.dart';
import 'package:forum3/Models/Requests.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Services/Storagemethods.dart';
import 'package:uuid/uuid.dart';
import '../Models/Chats.dart';

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
                photourl=await StorageMethods().Storageip("Posts", file, false,null);
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
                nol: 0,
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
                    {'likes':FieldValue.arrayRemove([author_uid]),
                        'nol':FieldValue.increment(-1),
                    }
                );
            }else{
                await  _firestore.collection("Posts").doc(postid).update(
                    {'likes':FieldValue.arrayUnion([author_uid]),
                        'nol':FieldValue.increment(1),
                    }
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
                photourl=await StorageMethods().Storageip("Posts", image, true,null);
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
                ppurl =await StorageMethods().Storageip("Profilepic", image, false,null);
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

Future<String> Makerequest(String author,String uid,String ppurl)async{
        String ress;
        try{
            String requestuid=Uuid().v1();
            Request request=Request(ppurl: ppurl,author_uid: uid, requestuid: requestuid, author: author, Timeposted: DateTime.now());
            await _firestore.collection("Requests").doc(uid).set(
                request.toJson(),
                SetOptions(
                    merge: true
                )
            );

            ress='Request Sent';
            return ress;
        }catch(e){
            ress=e.toString();
            return ress;
        }
    }

    Future<String> Approval(String uid)async{
        String ress;
        try{
            await _firestore.collection("users").doc(uid).update(
                {"Admin":true},
            );

            await _firestore.collection("Requests").doc(uid).delete();
            ress="Request Approved";
            return ress;
        }catch(e){
            ress=e.toString();
            return ress;
        }
    }

    Future<String> DenyRequest(String uid)async{
        String ress;
        try{
            await _firestore.collection("Requests").doc(uid).delete();
            ress="Request Denied Successfully";
            return ress;
        }catch(e){
            ress=e.toString();
            return ress;
        }
    }

    Future<String> RemoveAdmin(String uid)async{
        String ress;
        try{
            await _firestore.collection("users").doc(uid).update(
                {"Admin":false},
            );
            ress="Admin removed successfully";
            return ress;
        }catch(e){
            ress=e.toString();
            return ress;
        }
    }

    Future<String> CreateGroup(String uid,String author,String grpname,String grpdesc,dynamic file,User1 user)async{
      String ress;
      String photourl;
      List members=[];
      String groupid= const Uuid().v1();

      try{

        if(file!=null){
                photourl=await StorageMethods().Storageip("Group Profile", file, true,groupid);
            }
            else{
                photourl="";
            }
            members.add(uid);

            Group group= Group(searchkey: grpname.substring(0,1).toUpperCase(),Post_name: "Posts",noP: 0,Header: "",author_uid: uid, Group_uid: groupid, author: author, Timeposted: DateTime.now(), members: members, Group_name: grpname.substring(0,1).toUpperCase()+grpname.substring(1), Group_description: grpdesc,ppurl: photourl,Identity: "Members");

          _firestore.collection("Groups").doc(groupid).set(
            group.toJson(),
            SetOptions(merge: true)
            );

            _firestore.collection("Groups").doc(groupid).collection("Members").doc(uid).set(
              user.toJson(),
              SetOptions(merge: true)
            );

        ress="Group Created Successfully";
        return ress;
      }catch(e){
        ress=e.toString();
        return ress;
      }
    }

    Future<String> UpdateHeader(String Groupid,dynamic file)async{
      String photourl;
      String ress;
      try{
        if(file!=null){
          photourl=await StorageMethods().Storageip("Group Header", file, true,Groupid);
        }
        else{
          photourl="";
        }
        _firestore.collection("Groups").doc(Groupid).update(
          {"Header":photourl},
        );
        ress="Header Updated Successfully";
        return ress;
      }catch(e){
        ress=e.toString();
        return ress;
      }

    }

  Future<String> GroupPost(String Groupid,String uid,String Title,String Detail,dynamic file,String author , String ppurl)async{
      String ress;
      String photourl;
    try{
        if(file!=null){
                photourl=await StorageMethods().Storageip("GroupPosts", file, true,Groupid);
            }
            else{
                photourl="";
            }
            String postid= const Uuid().v1();
        Post gpost=Post(noc: 0,searchkey: Title.substring(0,1),author_uid: uid, postuid: postid, detail: Detail, author: author, Timeposted: DateTime.now(), likes:[], nol: 0,ppurl: ppurl,imageUrl: photourl,title: Title);

        _firestore.collection("Groups").doc(Groupid).collection("Posts").doc(postid).set(
            gpost.toJson(),
            SetOptions(merge: true)
            );
             _firestore.collection("Groups").doc(Groupid).update(
              { 
               "noP":FieldValue.increment(1),
               }
            );
      
      ress="Post Successfully";
      return ress;
    }catch(e){
      ress=e.toString();
      return ress;
    }

  }

  Future likedgroupost(String postid,String author_uid,List likes,String Groupid)async{
    try{
            if(likes.contains(author_uid)){
                await _firestore.collection("Groups").doc(Groupid).collection("Posts").doc(postid).update(
                    {'likes':FieldValue.arrayRemove([author_uid]),
                        'nol':FieldValue.increment(-1),
                    }
                );
            }else{
                await  _firestore.collection("Groups").doc(Groupid).collection("Posts").doc(postid).update(
                    {'likes':FieldValue.arrayUnion([author_uid]),
                        'nol':FieldValue.increment(1),
                    }
                );

               
            }

        }catch(e){
            print(e.toString());
        }
  }

  Future<String> UpdateGroup(String uid,String Groupname,String Groupdesc,String memberalias,String postalias,dynamic file)async{
    String ress;
    String photourl;
    String key=Groupname.substring(0,1);
    try{
      if(file!=null){
        photourl=await StorageMethods().Storageip("Group Profile", file, true,uid);
      }else{
        photourl="";
      }
      if(photourl!=""){
        _firestore.collection("Groups").doc(uid).update(
        { 
        "Group Name":Groupname,
        "Group Description":Groupdesc,
        "Identity":memberalias,
        "Post Name":postalias,
        "Group Pic":photourl,
        "searchkey":key,
        },
      );
      }else{
        _firestore.collection("Groups").doc(uid).update(
        { 
        "Group Name":Groupname,
        "Group Description":Groupdesc,
        "Identity":memberalias,
        "Post Name":postalias,
        "searchkey":key,
        },
      );
      }
      
      ress="Group Updated Successfully";
      return ress;
    }catch(e){
      ress=e.toString();
      return ress;
    }

  }

  Future<String> JoinGroup(String Groupid,User1 user)async{
    String ress;
    try{
      _firestore.collection("Groups").doc(Groupid).collection("Members").doc(user.UID).set(
        user.toJson(),
        SetOptions(merge: true)
      );

      _firestore.collection("Groups").doc(Groupid).update(
        {"Members":FieldValue.arrayUnion([user.UID])},
      );

      ress="Group Joined Successfully";
      return ress;
    }
    catch(e){
      ress=e.toString();
      return ress;
    }
  }

  Future<String> Leavegroup(String Groupid,User1 user)async{
    String ress;
    try{
      _firestore.collection("Groups").doc(Groupid).update(
        {"Members":FieldValue.arrayRemove([user.UID])},
      );

      _firestore.collection("Groups").doc(Groupid).collection("Members").doc(user.UID).delete();
      ress="Successfully Left Group";
      return ress;
    }
    catch(e){
      ress=e.toString();
      return ress;
    }
  }

  Future<String> Groupcomment(String groupid,String postid, String text,String author_uid,String author,String ppurl)async{
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
                await _firestore.collection("Groups").doc(groupid).collection("Posts").doc(postid).collection("Comments").doc(commentid).set(
                    comments.toJson(),
                    SetOptions(merge: true)
                );
                await _firestore.collection("Groups").doc(groupid).collection("Posts").doc(postid).update(
                    {
                        'nocomments':FieldValue.increment(1),
                    }
                );

                ress="Commented Successfully";
                return ress;
                }else{
                  ress="Empty field";
                  return ress;
                }
    }
    catch(e){
      print(e.toString());
      ress=e.toString();
      return ress;

    }
  }

  Future<String> Deletegroupost(String groupid,String postid)async{
    String ress;
    try{
      await _firestore.collection("Groups").doc(groupid).collection("Posts").doc(postid).delete();
      await _firestore.collection("Groups").doc(groupid).update(
        {"noP":FieldValue.increment(-1)},
      );
      ress="Post Deleted Successfully";
      return ress;
    }catch(e){
      print(e.toString());
      ress=e.toString();
      return ress;
    }
  }

  Future<String> EditGroupPost(String groupid,String postid,String title,String details,dynamic image, bool upload)async{
    String ress;
    String photourl;
    try{
      if(image!=null && upload){
                photourl=await StorageMethods().Storageip("GroupPosts", image, true,null);
                await  _firestore.collection("Groups").doc(groupid).collection("Posts").doc(postid).update({
                    'Post Time':DateTime.now(),
                    'Image Url':photourl,
                    'detail':details
                }
                );
                if(title!=""){
                    await   _firestore.collection("Groups").doc(groupid).collection("Posts").doc(postid).update({
                        'title':title,
                        'searchkey':title.substring(0,1)
                    });
                }

            }else{
                photourl="";
                await  _firestore.collection("Groups").doc(groupid).collection("Posts").doc(postid).update({
                    'Post Time':DateTime.now(),
                    'Image Url':photourl,
                    'detail':details
                }
                );
                if(title!=""){
                    await    _firestore.collection("Groups").doc(groupid).collection("Posts").doc(postid).update({
                        'title':title,
                        'searchkey':title.substring(0,1)

                    });
                }
            }
      ress="Post Edited Successfully";
      return ress;
    }catch(e){
      print(e.toString());
      ress=e.toString();
      return ress;
    }
  }

  Future<String> Deletegroup(String groupid)async{
    String ress;
    try{
      await _firestore.collection("Groups").doc(groupid).delete();
      ress="Group Deleted Successfully";
      return ress;
    }catch(e){
      print(e.toString());
      ress=e.toString();
      return ress;
    }
  }

  Future<String> Deletegroupcomment(String groupid,String postid,String commentid)async{
    String ress;
    try{
      await _firestore.collection("Groups").doc(groupid).collection("Posts").doc(postid).collection("Comments").doc(commentid).delete();
      await _firestore.collection("Groups").doc(groupid).collection("Posts").doc(postid).update(
        {"nocomments":FieldValue.increment(-1)},
      );
      ress="Comment Deleted Successfully";
      return ress;
    }catch(e){
      print(e.toString());
      ress=e.toString();
      return ress;
    }
  }

  Future <String> Editgroupcomment(String groupid,String postid,String commentid,String text)async{
    String ress;
    try{
      await _firestore.collection("Groups").doc(groupid).collection("Posts").doc(postid).collection("Comments").doc(commentid).update(
        {"detail":text},
      );
      ress="Comment Edited Successfully";
      return ress;
    }catch(e){
      print(e.toString());
      ress=e.toString();
      return ress;
    }
  }

  Future <String> Groupchat(String groupid,String author_uid,String message,String ppurl,String author)async{
    String ress;
    try{
      String message_uid=const Uuid().v1();
      GChats groupchat1=GChats(
        author_uid: author_uid,
        message_uid: message_uid,
        message: message,
        Timeposted: DateTime.now(),
        ppurl: ppurl,
        groupid: groupid,
        author: author
        );
      await _firestore.collection("Groups").doc(groupid).collection("Chats").doc(message_uid).set(
        groupchat1.toJson(),
        SetOptions(merge: true)
      );





      ress="Message Sent";
      return ress;
    }catch(e){
      print(e.toString());
      ress=e.toString();
      return ress;
    }
  }

  Future <String> Groupchatdelete(String groupid,String message_uid)async{
    String ress;
    try{
      await _firestore.collection("Groups").doc(groupid).collection("Chats").doc(message_uid).delete();
      ress="Message Deleted Successfully";
      return ress;
    }catch(e){
      print(e.toString());
      ress=e.toString();
      return ress;
    }
  }

  Future<String> UpdateSettings(String uid)async{
    String ress;
    try{
      ress="Settings Updated Successfully";
      return ress;
    }catch(e){
      ress=e.toString();
      return ress;
    }
  }

  Future<String?> UpdateThemeMode(String uid,bool Mode)async{
    String ress;
    try{
      if(Mode==true){
        //Dark Theme
        UserThemeData themedata=UserThemeData(
          UID: uid,
          DarkMode: true  
          );
        await _firestore.collection("Settings").doc(uid).collection("Theme").doc(uid).set(
          themedata.toJson(),
          SetOptions(merge: true)
        );
      }else{
        //Store colors in hex code as int
        //Light Theme
        UserThemeData themedata=UserThemeData(
          UID: uid,
          AppbarShadowColor: 0xFF000000,
          AppbariconColor: Colors.black.value,
          AppbartextColor: Colors.black.value,
          AppbarbackColor: Colors.white.value,
          AppbartextbuttonColor: Colors.lightBlueAccent.value,
          DrawerBackColor: Colors.white.value,
          DrawerIconColor: Colors.black.value,
          DrawerTextColor: Colors.black.value,
          DrawerTextbuttonColor: Colors.lightBlueAccent.value,
          DividerColor: Colors.black.value,
          ScaffoldbackColor: Colors.white.value,
          ScaffoldiconColor: Colors.black.value,
          ScaffoldtextColor: Colors.black.value,
          ScaffoldbuttonColor: Colors.lightBlueAccent.value,
          ScaffoldbuttonTextColor:Colors.black.value,
          ScaffoldbuttonIconColor: Colors.black.value,
          ScaffoldbuttonborderColor: Colors.white.value,
          CardBackgroundColor: Colors.white.value,
          CardTextColor: Colors.black.value,
          CardIconColor: Colors.black.value,
          CardShadowColor: Colors.black.value,
          CardBorderColor: Colors.transparent.value, 
          CardTextButtonColor: Colors.lightBlueAccent.value,
          BottomNavBackColor: Colors.white.value,
          BottomNavTextColor: Colors.black.value,
          BottomNavIconColor: Colors.black.value,
          DarkMode: false
          );
          await _firestore.collection("Settings").doc(uid).collection("Theme").doc(uid).set(
          themedata.toJson(),
          SetOptions(merge: true)
        );
      }

      ress="Theme Updated Successfully, Restart App to Apply changes";
      return ress;
      }catch(e){
        ress=e.toString();
        return ress;
      }
  }

 Future<String> GroupKickout(String Groupid,String uid)async{
    String ress;
    try{
      _firestore.collection("Groups").doc(Groupid).update(
        {"Members":FieldValue.arrayRemove([uid])},
      );

      _firestore.collection("Groups").doc(Groupid).collection("Members").doc(uid).delete();
      ress="Successfully kicked out of Group";
      return ress;
    }
    catch(e){
      ress=e.toString();
      return ress;
    }
  }


}




