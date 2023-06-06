import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:forum3/shared/Widgets/dynamiccard.dart';


class dynamicp extends StatefulWidget {
  final postid;
  const dynamicp({Key? key,this.postid}) : super(key: key);

  @override
  State<dynamicp> createState() => _dynamicpState();
}

class _dynamicpState extends State<dynamicp> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Posts').where('Post Uid', isEqualTo: widget.postid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return  dynamicCard(
            snap: snapshot.data!.docs[0].data(),
          );
        },
      ),
    );
  }
}
