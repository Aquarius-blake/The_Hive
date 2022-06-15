
//Taking a slightly long break

/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class StorageMethods{
  final FirebaseStorage _Storage= FirebaseStorage.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;



  Future <String?> Storageip(String name,dynamic file,bool isPost) async{
    Reference ref=_Storage.ref().child(name).child(_auth.currentUser!.uid)
    UploadTask uploadTask= ref.putFile(file);
    TaskSnapshot snap= await uploadTask;
    snap.ref.getDownloadURL() ;

    return ;
  }
}*/