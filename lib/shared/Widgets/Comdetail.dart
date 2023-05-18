import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:provider/provider.dart';
import 'Comment_card.dart';

class Comdetail extends StatefulWidget {
  final snap;
  const Comdetail({Key? key,this.snap}) : super(key: key);

  @override
  State<Comdetail> createState() => _ComdetailState();
}

class _ComdetailState extends State<Comdetail> {
  @override
  Widget build(BuildContext context) {
  late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
  print(widget.snap);
    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Posts")
              .doc(widget.snap['Event Uid'])
              .collection("comments")
              .where('author uid',isEqualTo: widget.snap['author uid'])
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
                  child: Commentcard(
                    snap: snapshots.data!.docs[index].data(),
                    postid: widget.snap['Event Uid'],
                  ),
                )
            );
          }
      ),
    );
  }
}
