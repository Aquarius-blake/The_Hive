
import 'package:flutter/material.dart';
import 'package:forum3/Services/auth.dart';

import '../Models/Users1.dart';

class UserProvider with ChangeNotifier{
  User1? _user1;
  final AuthService _auth=AuthService();

  User1 get getUser=> _user1!;

  Future<void> Refreshuser()async{

  }

}