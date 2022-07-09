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
      appBar: AppBar(
        centerTitle: true,
        title: Text(""),
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
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
Card()
                  ],
                ),
                Column(
                  children: <Widget>[

                  ],
                ),
                Column(
                  children: <Widget>[
Card()
                  ],
                ),

              ],
            ),
          )
      ),
    );
  }
}
