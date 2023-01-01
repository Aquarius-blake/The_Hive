
import 'package:flutter/material.dart';
import 'package:forum3/Services/auth.dart';
import '../Models/Users1.dart';

//User Provider

class UserProvider with ChangeNotifier{
  User1? _user1;
  final AuthService _auth=AuthService();

  User1 get getUser=> _user1!;

  Future<void> Refreshuser()async{
    User1? user1 = await _auth.CurrentUserDetails();
    _user1=user1;
    notifyListeners();
  }

}