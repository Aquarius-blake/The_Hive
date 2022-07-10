import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Services/auth.dart';
//import 'package:line_icons/line_icons.dart';


class Webview extends StatefulWidget {
  const Webview({Key? key}) : super(key: key);

  @override
  State<Webview> createState() => _WebviewState();
}
final  AuthService _auth=AuthService();


class _WebviewState extends State<Webview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Web"),
        actions: [
          ElevatedButton(
            onPressed: ()async{
              await _auth.SignOut();
            },
            child: Text("Sign Out"),
          ),
          /*ListTile(
            leading: Icon(LineIcons.alternateSignOut),
            title: Text("Sign Out"),
            onTap: (){},
          ),*/
        ],
      ),
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),

            child: Center(
              child: Row(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Card(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
Text("fsdg")
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[

                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Card(
                        child: Column(

                          children: <Widget>[
Text("dgdfgd")
                          ],
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          )
      ),
    );
  }
}
