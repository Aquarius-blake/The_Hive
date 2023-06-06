import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/shared/Widgets/post_card.dart';
import 'package:provider/provider.dart';


class detailp extends StatefulWidget {
  final snap;
  const detailp({Key? key,this.snap}) : super(key: key);

  @override
  State<detailp> createState() => _detailpState();
}

class _detailpState extends State<detailp> {
  @override
  Widget build(BuildContext context) {
        late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Posts').where('Post Uid', isEqualTo: widget.snap['Event Uid']).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return  PostCard(
                  snap: snapshot.data!.docs[0].data(),
          );
        },
      ),
    );
  }
}
