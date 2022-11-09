import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Screens/Home/Mobilepages/MSettings_Colors.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:forum3/shared/Widgets/Animatedtogglebutton.dart';
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
             child: const Text(
              "Save",
              style: TextStyle(
                color:Colors.blue
              ),
              )
             )
        ], 
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top:5.0,
                left:12.0
                ),
              child: Row(
                children: [
                  Text(
                    "Enable Dark Mode",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                    ),
                    Expanded(
                      child: SizedBox()
                    ),
                    Atogglebutton()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top:20.0,
                left:12.0
                ),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context)=>CustomThemePage(),
                              )
                          );
                },
                child: Row(
                  children: [
                    Text(
                      "Set Custom Colors",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20  ,
                      )
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}