import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';

class Mobcomedit extends StatefulWidget {
  final snap;
  final postid;
  const Mobcomedit({Key? key,this.snap,this.postid}) : super(key: key);

  @override
  State<Mobcomedit> createState() => _MobcomeditState();
}

class _MobcomeditState extends State<Mobcomedit> {
  TextEditingController text=TextEditingController();
  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
            "Edit Comment",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor:Colors.white ,
      ),
      body: SafeArea(
        child: Container(

        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
            height: kToolbarHeight,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            padding: const EdgeInsets.only(
              left: 16,
              right: 8,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user1.ppurl!),
                  radius: 18,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 1.0
                    ),
                    child: TextField(
                      controller: text,
                      decoration: InputDecoration(
                        hintText: "Comment as ${user1.Username}",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: const Text("Post"),
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      shadowColor: Colors.black,
                      primary: Colors.lightBlueAccent,
                      side: const BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)
                      )
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}