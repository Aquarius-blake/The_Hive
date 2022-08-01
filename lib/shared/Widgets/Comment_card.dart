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
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                    left: 12,
                  ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
RichText(
    text: TextSpan(
  children: [
    TextSpan(
      text: "Username",
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    TextSpan(
      text: "Comment",
      style: const TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.italic,
      ),
    ),

  ],
),
),
                 Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,),
                   child: Text(
                     "Date",
                     style: const TextStyle(
                       color: Colors.grey,
                       fontSize: 10,
                       fontStyle: FontStyle.italic
                     ),
                   ),
                )
                    ],
                    ),
                  )
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
