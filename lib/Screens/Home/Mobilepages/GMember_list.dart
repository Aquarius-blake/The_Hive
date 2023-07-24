import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:forum3/shared/Widgets/Alert.dart';
import 'package:forum3/shared/Widgets/GMembercard.dart';
import 'package:provider/provider.dart';



class GroupMembers extends StatefulWidget {
  final snap;
  const GroupMembers({ Key? key ,this.snap}) : super(key: key);

  

  @override
  State<GroupMembers> createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  @override
  Widget build(BuildContext context) {

    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(themedata.AppbarbackColor),
        iconTheme:  IconThemeData(
          color: Color(themedata.AppbariconColor),
        ),
        title:  Text(
          "Colony Members",
          style: TextStyle(
            color:Color(themedata.AppbartextColor),
          ),
          ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Groups").doc(widget.snap['Group Uid']).collection("Members").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshots){
            if(snapshots.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.lightBlueAccent,
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) => Container(
                  child: GestureDetector(
                    onLongPress: (){
                      if(user1.UID==widget.snap['author uid']){
                        print(snapshots.data!.docs[index].data()['username']);
                      showConfirmation("Kick "+ snapshots.data!.docs[index].data()['username'] +" out",
                       "Are you sure?",
                        KickOut(widget.snap['Group Uid'],snapshots.data!.docs[index].data()['uid'],context),
                         context
                                      );
                      }
                    },
                    child: Gmembercard(
                      snap: snapshots.data!.docs[index].data(),
                    ),
                  ),
                )
            );
          }
      ),
    );
  }
}

Widget KickOut(String groupid,String useruid,context){
  return TextButton(
    onPressed: ()async{
      String content= await FirestoreMethods().GroupKickout(groupid, useruid);
      Showsnackbar(content, context);
      Future.delayed(Duration(seconds: 2),(){
        Navigator.pop(context);
      });
    }, 
    child: Text("Yes")
    );
}