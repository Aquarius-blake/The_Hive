import 'package:flutter/material.dart';

class Msearch extends StatefulWidget {
  const Msearch({Key? key}) : super(key: key);

  @override
  State<Msearch> createState() => _MsearchState();
}

class _MsearchState extends State<Msearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: Container(
              child: Text("Search")
          )
      ),
    );
  }
}
