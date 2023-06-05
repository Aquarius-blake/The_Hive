
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/shared/Widgets/post_card.dart';


class WebHome extends StatefulWidget {
  const WebHome({Key? key}) : super(key: key);
  @override
  State<WebHome> createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {



  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.9,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return  const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
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
      ),
    );
  }
}
