import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../shared/Widgets/post_card.dart';


class Profilepost extends StatefulWidget {
  final snap;
  const Profilepost({Key? key,this.snap}) : super(key: key);

  @override
  State<Profilepost> createState() => _ProfilepostState();
}

class _ProfilepostState extends State<Profilepost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Posts').where('author uid', isEqualTo: widget.snap['uid'] ).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
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
