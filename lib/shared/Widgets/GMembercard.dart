import 'package:flutter/material.dart';


class Gmembercard extends StatefulWidget {
  final snap;
  const Gmembercard({ Key? key,this.snap }) : super(key: key);

  @override
  State<Gmembercard> createState() => _GmembercardState();
}

class _GmembercardState extends State<Gmembercard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Card()
    );
  }
}