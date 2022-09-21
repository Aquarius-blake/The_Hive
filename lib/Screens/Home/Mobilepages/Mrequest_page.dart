import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/shared/Widgets/Requestcard.dart';

class Request_page extends StatefulWidget {
  const Request_page({Key? key}) : super(key: key);

  @override
  State<Request_page> createState() => _Request_pageState();
}

class _Request_pageState extends State<Request_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
appBar: AppBar(
  backgroundColor: Colors.black,
  centerTitle: true,
  iconTheme: IconThemeData(
    color: Colors.white
  ),
  title: Text(
    "Requests",
    style: TextStyle(
      color: Colors.white
    ),
  ),
),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Requests').orderBy('Request Time',descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Container(
                child: RequestCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              )
          );
        },
      ),
    );
  }
}
