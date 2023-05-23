import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:provider/provider.dart';

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
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
    body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Posts').where('author uid', isEqualTo: widget.snap['uid'] ).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child:  CircularProgressIndicator(),
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
