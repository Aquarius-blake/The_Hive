import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/shared/Widgets/Comdetail.dart';
import 'package:forum3/shared/Widgets/Detailpost.dart';
import 'package:provider/provider.dart';
import '../../Models/Users1.dart';
import '../../Provider/user_provider.dart';



class Forumdetail extends StatefulWidget {
  final snap;
  const Forumdetail({Key? key,this.snap}) : super(key: key);

  @override
  State<Forumdetail> createState() => _ForumdetailState();
}

class _ForumdetailState extends State<Forumdetail> {
  TextEditingController text=TextEditingController();

  @override
  Widget build(BuildContext context) {

    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(themedata.ScaffoldbackColor),
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Color(themedata.AppbariconColor)
          ),
          title: Text(
            "Details",
            style: TextStyle(
                color: Color(themedata.AppbartextColor)
            ),
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height*0.4,
                width: MediaQuery.of(context).size.width,
                child: detailp(snap:widget.snap,)
            ),
            Divider(
              color: Color(themedata.DividerColor!),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.width,
              child: Comdetail(
                snap: widget.snap,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
            color: Color(themedata.BottomNavBackColor),
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
                  backgroundImage: NetworkImage(
                      user1.ppurl!
                  ),
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
                        hintStyle: TextStyle(
                          color: Color(themedata.BottomNavTextColor)
                        )
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: const Text("Post"),
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0, 
                      backgroundColor: Colors.lightBlueAccent,
                      shadowColor: Colors.black,
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
