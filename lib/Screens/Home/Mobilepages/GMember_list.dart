import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/shared/Widgets/GMembercard.dart';



class GroupMembers extends StatefulWidget {
  final snap;
  const GroupMembers({ Key? key ,this.snap}) : super(key: key);

  

  @override
  State<GroupMembers> createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Group Members",
          style: TextStyle(
            color:Colors.white,
          ),
          ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Groups").doc(widget.snap['Group Uid']).collection("Members").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshots){
            if(snapshots.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) => Container(
                  child: Gmembercard(
                    snap: snapshots.data!.docs[index].data(),
                  ),
                )
            );
          }
      ),
    );
  }
}