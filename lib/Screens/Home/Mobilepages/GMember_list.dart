import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
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
                    onLongPress: (){},
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