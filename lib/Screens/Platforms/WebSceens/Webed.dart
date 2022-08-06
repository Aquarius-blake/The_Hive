import 'package:flutter/material.dart';
import 'package:forum3/Screens/Platforms/WebSceens/Webeditpost.dart';

class Webed extends StatefulWidget {
  final snap;
  const Webed({Key? key,this.snap}) : super(key: key);

  @override
  State<Webed> createState() => _WebedState();
}

class _WebedState extends State<Webed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        title: const Text(
            "Edit Post",
          style: TextStyle(

          ),
        ),
      ),
      body:SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(29),
            child: Webeditpost(
              snap: widget.snap,
            ),
          ),
        ),
      ),
    );
  }
}
