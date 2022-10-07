import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Screens/Platforms/WebSceens/editcomment.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Models/Users1.dart';
import '../../Provider/user_provider.dart';
import '../../Screens/Home/Mobilepages/Meditcomment.dart';
import '../Pop_up.dart';

//TODO: Replace codes, that is edit comment page
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
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 16,
      ),
      child: Card(
        color:Colors.black,
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
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "   ${widget.snap['detail']}",
                                  style: const TextStyle(
                                    color: Colors.white,
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
                                builder: (context)=>Mobcomedit(
                                  snap: widget.snap,
                                  postid: widget.postid,
                                ),
                              )
                          );
                        }
                      },
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      )
                  ),
                  TextButton(
                      onPressed: ()async{
                        String ress= await FirestoreMethods().Deletegroupcomment(widget.groupid,widget.postid, widget.snap['Comment Uid']);
                        Showsnackbar(ress, context);
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      )
                  ),
                ],
              ):SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
