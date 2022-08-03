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

          ),
        ),
      ),
    );
  }
}
