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
                            Text("fsdg"),
                            CircleAvatar(),
                            ListView(
                              children: <Widget>[
                                SizedBox(height: 10,),
                                ListTile(
                                  leading: Icon(Icons.person,
                                    color: Colors.black, size:50.0,),
                                  title: Text(
                                    "Profile",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,

                                    ),

                                  ),
                                  onTap: () async{
                                    Navigator.pushNamed(context, '/wprofile');
                                  },
                                ),
                              ],
                            )

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
