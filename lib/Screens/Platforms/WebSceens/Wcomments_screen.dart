import 'package:flutter/material.dart';

class Wcommentd extends StatefulWidget {
  final snap;
  const Wcommentd({Key? key,this.snap}) : super(key: key);

  @override
  State<Wcommentd> createState() => _WcommentdState();
}

class _WcommentdState extends State<Wcommentd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Discussion",
          style: TextStyle(

          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Card(
              elevation: 15.0,
              color: Colors.white,
              shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
              ),
              child: Column(
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
