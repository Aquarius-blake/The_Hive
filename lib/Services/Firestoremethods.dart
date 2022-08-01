import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forum3/Models/Comments.dart';
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

    Future<void>likepost(String postid,String author_uid,List likes)async {
        try{
            if(likes.contains(author_uid)){
                await _firestore.collection("Posts").doc(postid).update(
                    {'likes':FieldValue.arrayRemove([author_uid])}
                );
            }else{
                await  _firestore.collection("Posts").doc(postid).update(
                    {'likes':FieldValue.arrayUnion([author_uid])}
                );
            }

        }catch(e){
            print(e.toString());
        }
    }


    Future<String> postcomment(String postid, String text,String author_uid,String author,String ppurl) async{
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
               ress="Comment success";
               return ress;
            }
            return "";
        }catch(e){
            return e.toString();
        }
    }




}