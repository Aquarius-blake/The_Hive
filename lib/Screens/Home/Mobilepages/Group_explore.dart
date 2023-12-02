import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Screens/Home/Mobilepages/Group_home.dart';
import 'package:forum3/shared/Widgets/Group_card.dart';
import 'package:provider/provider.dart';

class GroupExplore extends StatefulWidget {

  @override
  State<GroupExplore> createState() => _GroupExploreState();
}

class _GroupExploreState extends State<GroupExplore> {
  @override
  Widget build(BuildContext context) {
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(themedata.AppbarbackColor),
        iconTheme:  IconThemeData(
          color:Color(themedata.AppbariconColor),
        ),
        title: Text(
          'Explore Groups',
          style:TextStyle(
            color:Color(themedata.AppbartextColor)
          ),
          ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Groups').where('Visibility',isEqualTo: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context)=>Ghome(
                snap: snapshot.data!.docs[index].data(),
              ),
            )
        );
                },
                child: GroupCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              )
          );
        },
      ),
    );
  }
}