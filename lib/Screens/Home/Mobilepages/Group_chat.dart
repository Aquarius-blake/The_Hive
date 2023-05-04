// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Services/Encryption.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:forum3/shared/Widgets/Groupchat_card.dart';
import 'package:provider/provider.dart';



class Gchatscreen extends StatefulWidget {
  final snap;
  final groupid;
  const Gchatscreen({ Key? key,this.snap,this.groupid }) : super(key: key);

  @override
  State<Gchatscreen> createState() => _GchatscreenState();
}

class _GchatscreenState extends State<Gchatscreen> {

TextEditingController text=TextEditingController();
var plaintext,enctext;
late ScrollController _scrollController;
bool _showBackToTopButton = true;

_options(BuildContext context,dynamic snap)async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text("More options"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text("Delete Message"),
                onPressed: ()async{
                String content=  await FirestoreMethods().Groupchatdelete(widget.groupid,snap['Message Uid']);
                Showsnackbar(content, context);
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text("Cancel"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
@override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        
      });
    super.initState();
  }

@override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        backgroundColor: Color(themedata.AppbarbackColor),
        centerTitle: true,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                widget.snap['Group Pic'],
              ),
            ),
          const  SizedBox(
            width: 10,
            ),
            Text(
              widget.snap['Group Name'],
              style:  TextStyle(
                color: Color(themedata.AppbartextColor),
              ),
              ),
          ],
        ),
          iconTheme: IconThemeData(
            color: Color(themedata.AppbariconColor),
          ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Groups").doc(widget.snap['Group Uid']).collection("Chats").orderBy('Message Time',descending: true).snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshots){
            if(snapshots.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.lightBlueAccent,
                ),
              );
            }
            return ListView.builder(
              reverse: true,
              controller: _scrollController,
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) => Container(
                  child: GestureDetector(
                    onTap:()async{
                      if(snapshots.data!.docs[index].data()['author uid']==user1.UID){
                        _options(context,snapshots.data!.docs[index]);
                      }
                    },
                    child: Gchatcard(
                      snap: snapshots.data!.docs[index].data(),
                    ),
                  ),
                )
            );
          }
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed:()=> _scrollToTop(),
              child: const Icon(
                Icons.arrow_downward
                ),
              backgroundColor: Colors.transparent,
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
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                      style:  TextStyle(
                        color: Color(themedata.BottomNavTextColor),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: ()async{
                    setState(() {
                      plaintext=text.text;
                      text.text="";
                    });
                    enctext= await Encryption.encrypt(plaintext);
                    String ress= await FirestoreMethods().Groupchat(widget.groupid, user1.UID!, enctext, user1.ppurl!,user1.Username!);
                    Showsnackbar(ress, context);
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