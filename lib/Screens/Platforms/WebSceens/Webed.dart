import 'package:flutter/material.dart';

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
      appBar: AppBar(),
    );
  }
}
