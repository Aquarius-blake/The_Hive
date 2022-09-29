import 'package:flutter/material.dart';


class Gmembercard extends StatefulWidget {
  final snap;
  const Gmembercard({ Key? key,this.snap }) : super(key: key);

  @override
  State<Gmembercard> createState() => _GmembercardState();
}

class _GmembercardState extends State<Gmembercard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Card(
        color: Colors.black,
        child:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  widget.snap['profilepic']
                  ),
                  backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                width: 10,
                ),
              Text("${widget.snap['username']}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:Colors.white
              ),
              ),
            ]
            ),
        ),
      )
    );
  }
}