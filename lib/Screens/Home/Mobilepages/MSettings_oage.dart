import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:provider/provider.dart';

class MSettings extends StatefulWidget {
  const MSettings({ Key? key }) : super(key: key);

  @override
  State<MSettings> createState() => _MSettingsState();
}

class _MSettingsState extends State<MSettings> {
  @override
  Widget build(BuildContext context) {
        late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Settings'),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),    
        actions: [
          TextButton(
            onPressed: ()async{
             String content= await FirestoreMethods().UpdateSettings(user1.UID!);
             Showsnackbar(content, context);
            },
             child: Text(
              "Save",
              style: TextStyle(
                color:Colors.blue
              ),
              )
             )
        ], 
      ),
    );
  }
}