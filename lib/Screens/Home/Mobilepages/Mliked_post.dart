import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../shared/Widgets/post_card.dart';

class Likedposts extends StatefulWidget {
  final snap;
  const Likedposts({Key? key,this.snap}) : super(key: key);

  @override
  State<Likedposts> createState() => _LikedpostsState();
}

class _LikedpostsState extends State<Likedposts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Posts').where('likes',arrayContains: widget.snap['uid']).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Container(
                child: PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              )
          );
        },
      ),
    );
  }
}
