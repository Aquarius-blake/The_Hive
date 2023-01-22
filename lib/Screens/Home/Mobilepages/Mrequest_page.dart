import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/shared/Widgets/Requestcard.dart';
import 'package:provider/provider.dart';

class Request_page extends StatefulWidget {
  const Request_page({Key? key}) : super(key: key);

  @override
  State<Request_page> createState() => _Request_pageState();
}

class _Request_pageState extends State<Request_page> {
  @override
  Widget build(BuildContext context) {
        late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
appBar: AppBar(
  backgroundColor: Color(themedata.AppbarbackColor),
  centerTitle: true,
  iconTheme:  IconThemeData(
    color: Color(themedata.AppbariconColor)
  ),
  title: Text(
    "Requests",
    style: TextStyle(
      color: Color(themedata.AppbartextColor)
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
