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
  void initState() {
    initial();
    super.initState();
  }
  void initial()async{

  }
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
            padding: EdgeInsets.all(60),

            child: Center(
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Card(
                        color: Colors.white,
                        shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50,50,50,50),
                          child: SingleChildScrollView(
                            child: Column(

                              children: <Widget>[
                                Text("fsdg"),
                                CircleAvatar(
                                  radius: 50.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                        onPressed: (){},
                                        icon: Icon(Icons.wifi),
                                      iconSize: 20.0,

                                    ),
                                    GestureDetector(
                                      onTap: (){},
                                      child: Text("profile",
                                        style: TextStyle(

                                        ),
                                      ),
                                    )
                                  ],
                                )

                              ],
                            ),
                          ),
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
