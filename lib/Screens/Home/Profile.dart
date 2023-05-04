import 'package:flutter/material.dart';


//Profile Screen

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text("Profile"),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[

          ],
        ),

      ),
    );
  }
}
