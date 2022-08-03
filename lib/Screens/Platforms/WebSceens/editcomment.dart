import 'package:flutter/material.dart';

class webcomedit extends StatefulWidget {
  final snap;
  const webcomedit({Key? key,this.snap}) : super(key: key);

  @override
  State<webcomedit> createState() => _webcomeditState();
}

class _webcomeditState extends State<webcomedit> {

  TextEditingController _comment=TextEditingController();

  @override
  void initState() {
    _comment.text=widget.snap['detail'];
    super.initState();
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Text(
          "Edit Comment",
          style: TextStyle(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(50),
            child: Card(
child: Container(
  padding: EdgeInsets.all(50),
  child: Column(
    children: [
      CircleAvatar(
        backgroundImage: NetworkImage(widget.snap['Profile Pic']),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width*0.7,
        child: TextField(
          controller: _comment,
          decoration: const InputDecoration(
            hintText: "Edit comment",
          ),
        ),
      ),

    ],
  ),
),
            ),
          ),
        ),
      ),
    );
  }
}
