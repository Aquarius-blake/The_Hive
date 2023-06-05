import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Screens/Home/Mobilepages/Group_commentedit.dart';
import 'package:forum3/Screens/Platforms/WebSceens/editcomment.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Models/Users1.dart';
import '../../Provider/user_provider.dart';
import '../Pop_up.dart';

class GCommentcard extends StatefulWidget {
  final snap;
  final postid;
  final groupid;
  const GCommentcard({Key? key,this.snap,this.postid,this.groupid}) : super(key: key);

  @override
  State<GCommentcard> createState() => _GCommentcardState();
}

class _GCommentcardState extends State<GCommentcard> {
  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 16,
      ),
      child: Card(
        color:Color(themedata.CardBackgroundColor),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                children: [
                widget.snap['Profile Pic']==""?const CircleAvatar(
                  radius:16,
                  backgroundImage: AssetImage('Assets/hac.jpg'),
                ) : CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(widget.snap['Profile Pic']),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.snap['author'],
                                  style:  TextStyle(
                                    color: Color(themedata.CardTextColor),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "   ${widget.snap['detail']}",
                                  style:  TextStyle(
                                    color: Color(themedata.CardTextColor),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4.0,),
                            child: Text(
                              DateFormat.yMMMd().format(widget.snap['Comment Time'].toDate(),),
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
           widget.snap['author uid']==user1.UID?   Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: (){
                        if(kIsWeb){
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context)=>webcomedit(
                                  snap: widget.snap,
                                  postid: widget.postid,
                                ),
                              )
                          );
                        }else{
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context)=>Gcomedit(
                                  snap: widget.snap,
                                  postid: widget.postid,
                                  groupid: widget.groupid,
                                ),
                              )
                          );
                        }
                      },
                      child:  Text(
                        "Edit",
                        style: TextStyle(
                          color: Color(themedata.CardTextButtonColor!),
                        ),
                      )
                  ),
                  TextButton(
                      onPressed: ()async{
                        String ress= await FirestoreMethods().Deletegroupcomment(widget.groupid,widget.postid, widget.snap['Comment Uid']);
                        Showsnackbar(ress, context);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Color(themedata.CardTextButtonColor!),
                        ),
                      )
                  ),
                ],
              ):const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
