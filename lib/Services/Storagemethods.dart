import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMethods{
  final FirebaseStorage _Storage= FirebaseStorage.instance;


  Future <String?> Storageip(String name,dynamic file,bool isPost){
_Storage.ref().child(name)
    return ;
  }
}