import 'package:flutter/material.dart';

class Mobeditpost extends StatefulWidget {
  final snap;
  const Mobeditpost({Key? key,this.snap}) : super(key: key);

  @override
  State<Mobeditpost> createState() => _MobeditpostState();
}

class _MobeditpostState extends State<Mobeditpost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Edit Post",
        ),
      ),
    );
  }
}
