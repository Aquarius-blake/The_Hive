
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:forum3/Models/Posts.dart';
import 'package:forum3/Services/Storagemethods.dart';
import 'package:forum3/shared/Pop_up.dart';

class FirestoreMethods{
    final FirebaseFirestore _firestore=FirebaseFirestore.instance;

    //Upload post
Future <String> Uploadpost(
    BuildContext context,
    String Title,
    String Details,
    dynamic file,
    String uid,
    String author,
    )async{
    String photourl;
    try{
        if(file!=null){
             photourl=await StorageMethods().Storageip("Posts", file, true);
        }
        else{
            photourl="";
        }
        Post post=Post(
            author_uid: uid,
            postuid: postuid,
            detail: Details,
            author: author,
            Timeposted: DateTime.now(),
            posturl: photourl
        )
    }
    catch(e){
     String  err=e.toString();
     Showsnackbar(err,context);
    }
}
}