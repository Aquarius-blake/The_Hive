import 'package:flutter/material.dart';

class Atogglebutton extends StatefulWidget {
  const Atogglebutton({ Key? key }) : super(key: key);

  @override
  State<Atogglebutton> createState() => _AtogglebuttonState();
}

class _AtogglebuttonState extends State<Atogglebutton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        height:20.0,
        width: 50.0,
        )
    );
  }
}