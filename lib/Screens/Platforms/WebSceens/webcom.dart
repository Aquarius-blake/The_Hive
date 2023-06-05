import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';
import '../../../Services/Firestoremethods.dart';
import '../../../shared/Pop_up.dart';
import '../../../shared/Widgets/Comment_card.dart';


class webcom extends StatefulWidget {
  final snap;
  const webcom({Key? key,this.snap}) : super(key: key);

  @override
  State<webcom> createState() => _webcomState();
}

class _webcomState extends State<webcom> {

  commenting(String postid, String textt,String author_uid,String author,String ppurl,String title,String owner_uid) async{
    String ress=await FirestoreMethods().postcomment(postid, textt, author_uid, author, ppurl,title,owner_uid);
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
  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: Colors.white10,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Posts").doc(widget.snap['Post Uid']).collection("comments").orderBy("Comment Time",descending: true).snapshots(),
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
                  onPressed: ()=>commenting(widget.snap['Post Uid'], text.text, user1.UID!, user1.Username!, user1.ppurl!,widget.snap['title'],widget.snap['author uid']),
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
