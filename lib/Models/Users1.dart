
// Custom User Class
import 'package:flutter/material.dart';

class User1{

  late final  String UID;
  late final String? Email;
  late final String? Password;
  late final bool? Guest;
  late final AssetImage? profilepic;


  User1({required this.UID, this.profilepic,this.Guest,this.Email,this.Password});

}