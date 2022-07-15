
import 'package:flutter/material.dart';

import '../Models/Users1.dart';

class UserProvider with ChangeNotifier{
  User1? _user1;

  User1 get getUser=> _user1!;

  Future<void> Refreshuser()async{

  }

}