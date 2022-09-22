import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/shared/Widgets/Group_card.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatefulWidget {
  GroupPage({Key? key}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
        late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Group List",
          style: TextStyle(
            color:Colors.white,
          ),
          ),
          actions: [
            TextButton(
              onPressed: (){},
             child: const Text("Create New Group"),
             )
          ],
      ),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Groups').where('Members',arrayContains: user1.UID).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: (){},
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









