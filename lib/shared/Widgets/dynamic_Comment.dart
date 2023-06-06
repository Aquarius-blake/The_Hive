import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/shared/Widgets/dynamiccoms.dart';
import 'package:provider/provider.dart';


class dynamicCom extends StatefulWidget {
  final postid;
  const dynamicCom({Key? key,this.postid}) : super(key: key);

  @override
  State<dynamicCom> createState() => _dynamicComState();
}

class _dynamicComState extends State<dynamicCom> {
  @override
  Widget build(BuildContext context) {
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Posts")
              .doc(widget.postid)
              .collection("comments")
              .orderBy("Comment Time",descending: true)
              .snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshots){
            if(snapshots.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) => Container(
                  child: dycomcard(
                    snap: snapshots.data!.docs[index].data(),
                    postid: widget.postid,
                  ),
                )
            );
          }
      ),
    );
  }
}

