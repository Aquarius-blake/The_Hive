import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';



class Mprofile extends StatefulWidget {
  final snap;
  const Mprofile({Key? key,this.snap}) : super(key: key);

  @override
  State<Mprofile> createState() => _MprofileState();
}

class _MprofileState extends State<Mprofile> {
  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
CircleAvatar(
backgroundImage: NetworkImage(widget.snap['profilepic']),
  radius: 50,
),
                    SizedBox(width: MediaQuery.of(context).size.width*0.15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "20",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Posts",
                            style: TextStyle(
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold
                            ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            widget.snap['uid']!=user1.UID? ElevatedButton(
                                onPressed: (){},
                                child: Text("Message")
                            ):ElevatedButton(
                                onPressed: (){},
                                child: Text("Edit Profile"))
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
