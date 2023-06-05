
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:forum3/shared/Widgets/Animatedtogglebutton.dart';
import 'package:provider/provider.dart';

//TODO: Link Custom Theme page for v1.0.2

class MSettings extends StatefulWidget {
  const MSettings({ Key? key }) : super(key: key);

  @override
  State<MSettings> createState() => _MSettingsState();
}

class _MSettingsState extends State<MSettings> {
  @override
  Widget build(BuildContext context) {
        late  User1 user1=  Provider.of<UserProvider>(context).getUser;
        late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
        
    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        backgroundColor: Color(themedata.AppbarbackColor),
        centerTitle: true,
        title:  Text(
          'Settings',
          style: TextStyle(
            color: Color(themedata.AppbartextColor)
            ),
        ),
        iconTheme:  IconThemeData(
          color: Color(themedata.AppbariconColor),
        ),    
        actions: [
          
          TextButton(
            onPressed: ()async{
             String content= await FirestoreMethods().UpdateSettings(user1.UID!);
             Showsnackbar(content, context);
            },
             child:  Text(
              "Save",
              style: TextStyle(
                color:Color(themedata.AppbartextbuttonColor!)
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
                      color: Color(themedata.ScaffoldtextColor),
                      fontSize: 20
                    ),
                    ),
                    Expanded(
                      child: SizedBox()
                    ),
                    Atogglebutton(uid: user1.UID!,mode: themedata.DarkMode,)
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
                 /* Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context)=>CustomThemePage(),
                              )
                          );*/
                          Showsnackbar("Feature not available for this version", context);
                },
                child: Row(
                  children: [
                    Text(
                      "Set Custom Colors",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(themedata.ScaffoldtextColor),
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