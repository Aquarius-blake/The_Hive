import 'package:flutter/material.dart';

class Commentcard extends StatefulWidget {
  final snap;
  const Commentcard({Key? key,this.snap}) : super(key: key);

  @override
  State<Commentcard> createState() => _CommentcardState();
}

class _CommentcardState extends State<Commentcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [

                ],
              ),
              Row(
                children: [

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
