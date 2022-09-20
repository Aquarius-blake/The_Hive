import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/shared/Widgets/post_card.dart';


class Mhome extends StatefulWidget {
  const Mhome({Key? key}) : super(key: key);

  @override
  State<Mhome> createState() => _MhomeState();
}

class _MhomeState extends State<Mhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors. black, 
appBar:AppBar(
  backgroundColor: Colors.black,
  elevation: 0.0,
),
  body: StreamBuilder(
    stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
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
