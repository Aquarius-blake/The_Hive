import 'package:flutter/material.dart';

class Msearch extends StatefulWidget {
  const Msearch({Key? key}) : super(key: key);

  @override
  State<Msearch> createState() => _MsearchState();
}

class _MsearchState extends State<Msearch> {
  TextEditingController _search=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  elevation: 0.0,
  title: TextFormField(
    controller: _search,
  ),
),
    );
  }
}
