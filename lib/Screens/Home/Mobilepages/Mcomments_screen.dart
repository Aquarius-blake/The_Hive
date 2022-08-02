import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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


  commenting(String postid, String text,String author_uid,String author,String ppurl) async{
    String ress=await FirestoreMethods().postcomment(postid, text, author_uid, author, ppurl);
    if( ress=="Comment success"){
      Showsnackbar(ress, context);
    }else if(ress=="Empty field"){
      ress="Please Enter text";
      Showsnackbar(ress, context);
    }else{
      Showsnackbar(ress, context);
    }

  }
  TextEditingController text=TextEditingController();

  @override
  void dispose() {
text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title:const Text(
          "Comments",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Posts").doc(widget.snap['Post Uid']).collection("comments").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshots){
            if(snapshots.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) => Container(
                  child: Commentcard(
                    snap: snapshots.data!.docs[index].data(),
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
                    onPressed: ()=>commenting(widget.snap['Post Uid'], text.text, user1.UID!, user1.Username!, user1.ppurl!),
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
