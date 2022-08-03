import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../shared/Widgets/Comment_card.dart';


class webcom extends StatefulWidget {
  final snap;
  const webcom({Key? key,this.snap}) : super(key: key);

  @override
  State<webcom> createState() => _webcomState();
}

class _webcomState extends State<webcom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
