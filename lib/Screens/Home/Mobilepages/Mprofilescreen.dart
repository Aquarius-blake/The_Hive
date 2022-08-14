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
                    SizedBox(width: MediaQuery.of(context).size.width*0.05,),
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
                           const Text(
                              "Posts",
                            style: TextStyle(
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold
                            ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            widget.snap['uid']!=user1.UID? ElevatedButton(
                                onPressed: (){},
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0,
                                  right: 16.0),
                                  child: Text(
                                    "Message",
                                  style: TextStyle(
                                    color: Colors.lightBlueAccent
                                  ),
                                  ),
                                ),
                              style: ElevatedButton.styleFrom(
                                  elevation: 6.0,
                                  shadowColor: Colors.black,
                                  primary: Colors.white,
                                  side: const BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.0)
                                  )
                              ),
                            ):ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 6.0,
                                  shadowColor: Colors.black,
                                  primary: Colors.white,
                                  side: const BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.0)
                                  )
                              ),
                                onPressed: (){},
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left:18.0,
                                    right: 18.0,
                                  ),
                                  child: Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        color: Colors.lightBlueAccent
                                    ),
                                  ),
                                ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15.0,),
                Container(
alignment: Alignment.centerLeft,
                  child: Text(
                      widget.snap['username'],
                    style: TextStyle(
fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
