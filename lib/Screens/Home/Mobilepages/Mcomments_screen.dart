import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:forum3/shared/Widgets/Comment_card.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';

class McommentsScreen extends StatefulWidget {
  final snap;
  const McommentsScreen({Key? key,this.snap}) : super(key: key);

  @override
  State<McommentsScreen> createState() => _McommentsScreenState();
}

class _McommentsScreenState extends State<McommentsScreen> {
dynamic image;

  commenting(String postid, String textt,String author_uid,String author,String ppurl,String title,String onweruid) async{
    String ress=await FirestoreMethods().postcomment(postid, textt, author_uid, author, ppurl,title,onweruid);
    if( ress=="Comment success"){
      Showsnackbar(ress, context);
    }else if(ress=="Empty field"){
      ress="Please Enter text";
      Showsnackbar(ress, context);
    }else{
      Showsnackbar(ress, context);
    }
    setState(() {
      text.text="";
    });

  }
  TextEditingController text=TextEditingController();

  @override
  void dispose() {
text.dispose();
    super.dispose();
  }

  Widget Avatar(dynamic image,User1 user1){
    try{
      return image!=null?  CircleAvatar(
        radius: 20,
        backgroundImage: MemoryImage(image),
      ):user1.ppurl!=""? CircleAvatar(
        backgroundImage: NetworkImage(user1.ppurl!),
        radius: 20,
      ):const CircleAvatar(
        backgroundImage: AssetImage('Assets/hac.jpg'),
        radius: 20,
      );
    }
    catch(e){
      return const CircleAvatar(
        backgroundImage: AssetImage('Assets/hac.jpg'),
        radius: 20,
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        iconTheme:  IconThemeData(
          color: Color(themedata.AppbarbackColor),
        ),
        backgroundColor: Color(themedata.AppbarbackColor),
        title: Text(
          "Discussion",
          style: TextStyle(
            color: Color(themedata.AppbartextColor),
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Posts").doc(widget.snap['Post Uid']).collection("comments").orderBy("Comment Time",descending: true).snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshots){
            if(snapshots.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) => Container(
                  child: Commentcard(
                    snap: snapshots.data!.docs[index].data(),
                    postid: widget.snap['Post Uid'],
                  ),
                )
            );
          }
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
               Avatar(image, user1) ,
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
                        hintStyle:  TextStyle(
                          color: Color(themedata.ScaffoldtextColor),
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Color(themedata.ScaffoldtextColor),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: ()async{
                     try {
                       commenting(
                           widget.snap['Post Uid'],
                           text.text,
                           user1.UID!,
                           user1.Username!,
                           user1.ppurl!,
                           widget.snap['title'],
                           widget.snap['author uid']);
                     }catch(e){
                       Showsnackbar(e.toString(), context);
                     }
                      },
                    child: const Text("Post"),
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0, 
                      backgroundColor: Color(themedata.ScaffoldbuttonColor),
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
