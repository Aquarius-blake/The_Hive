
import 'package:flutter/material.dart';


class GroupCard extends StatefulWidget {
  final snap;
  const GroupCard({ Key? key , this.snap}) : super(key: key);

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
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(widget.snap['Group Pic']),
                radius:20,
              ),
              Column(
                children: [
                  Text(
                    "${widget.snap['Group Name']}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    ),
                  Text(
                    "${widget.snap['Group Description']}",
                    style: const TextStyle(
                      color:Colors.white
                    ) ,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

