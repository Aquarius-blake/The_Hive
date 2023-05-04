import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';
import '../../../Services/Firestoremethods.dart';
import '../../../shared/Pop_up.dart';

class Gcomedit extends StatefulWidget {
  final snap;
  final postid;
  final groupid;
  const Gcomedit({Key? key,this.snap,this.postid,this.groupid}) : super(key: key);

  @override
  State<Gcomedit> createState() => _GcomeditState();
}

class _GcomeditState extends State<Gcomedit> {
  TextEditingController text=TextEditingController();
  @override
  void initState() {
    text.text=widget.snap['detail'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(themedata.AppbariconColor),
        ),
        title:  Text(
          "Edit Comment",
          style: TextStyle(
            color: Color(themedata.AppbartextColor),
          ),
        ),
        backgroundColor:Color(themedata.AppbarbackColor) ,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
            color: Color(themedata.CardBackgroundColor),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 18,
                        backgroundImage: NetworkImage(user1.ppurl!),
                        backgroundColor:Colors.transparent,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.5,
                          child: Text(
                            user1.Username!,
                            style: TextStyle(
                              color: Color(themedata.CardTextColor),
                            ),
                            ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: text,
                    maxLines: 12,
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      hintText: "Edit comment as ${user1.Username}",
                      label: Text(
                        "Edit comment as ${user1.Username}",
                        style: TextStyle(
                          color: Color(themedata.CardTextColor),
                        ),
                        )
                    ),
                    style: TextStyle(
                      color: Color(themedata.CardTextColor),
                    ),
                  ),
                const Divider(
                    height: 20,
                    thickness: 2,
                  ),
                const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4.0,
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () async{
          String ress= await FirestoreMethods().Editgroupcomment(widget.groupid,widget.postid, widget.snap['Comment Uid'], text.text);
          await  Showsnackbar(ress, context);
          Navigator.of(context).pop();
        },
        child: const FaIcon(
            FontAwesomeIcons.comment
        ),
      ),
    );
  }
}

