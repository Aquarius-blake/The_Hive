import 'package:flutter/material.dart';



class GroupMembers extends StatefulWidget {
  const GroupMembers({ Key? key }) : super(key: key);

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
    );
  }
}