import 'package:flutter/material.dart';


class Gedit extends StatefulWidget {
  final snap;
  const Gedit({ Key? key ,this.snap}) : super(key: key);

  @override
  State<Gedit> createState() => _GeditState();
}

class _GeditState extends State<Gedit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
    );
  }
}