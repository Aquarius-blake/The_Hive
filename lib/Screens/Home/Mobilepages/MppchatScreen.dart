import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Screens/Home/Mobilepages/MpChatbody.dart';
import 'package:forum3/Services/Encryption.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';


class MpchatScreen extends StatefulWidget {
  final snap;
  const MpchatScreen({Key? key,this.snap}) : super(key: key);

  @override
  State<MpchatScreen> createState() => _MpchatScreenState();
}

class _MpchatScreenState extends State<MpchatScreen> {
  TextEditingController text=TextEditingController();
  var plaintext,enctext;


  @override
  void dispose() {
    text.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;   
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(themedata.AppbarbackColor),
        iconTheme: IconThemeData(
          color: Color(themedata.AppbariconColor),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.snap['profilepic']),
            ),
          const SizedBox(width: 20,),
            Text(
              "${widget.snap['username']}",
              style:  TextStyle(
                  color: Color(themedata.AppbartextColor)
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height*0.8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chatbody(
              snap: widget.snap,
            ),
          )
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
                        hintText: "Chat as ${user1.Username}",
                        hintStyle:  TextStyle(
                            color: Color(themedata.BottomNavTextColor)
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          color: Color(themedata.BottomNavTextColor)
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: ()async{
                    if(text.text!=""){
                      setState(() {
                        plaintext=text.text;
                        enctext=Encryption.encrypt(plaintext);
                      });
                    String? ress= await FirestoreMethods().Sendmessage(user1.Username!, user1.UID!, widget.snap['username'], widget.snap['uid'], enctext,widget.snap['profilepic'],user1.ppurl!);
                    Showsnackbar(ress!, context);
                    }
                  },
                  child: const FaIcon(
                      FontAwesomeIcons.featherPointed
                  ),
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















