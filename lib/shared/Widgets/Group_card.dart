
import 'package:flutter/material.dart';


class GroupCard extends StatefulWidget {
  const GroupCard({ Key? key }) : super(key: key);

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Card(
        color:Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(),
        ),
      ),
    );
  }
}

