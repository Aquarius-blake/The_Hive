import 'package:flutter/material.dart';


class Wsearch extends StatefulWidget {
  const Wsearch({Key? key}) : super(key: key);

  @override
  State<Wsearch> createState() => _WsearchState();
}

class _WsearchState extends State<Wsearch> {
  TextEditingController _search=TextEditingController();

  @override
  void dispose() {
_search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.white,
  title: TextFormField(
    controller: _search,
    decoration: InputDecoration(),
  ),
),
    );
  }
}
