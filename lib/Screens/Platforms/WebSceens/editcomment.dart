import 'package:flutter/material.dart';

class webcomedit extends StatefulWidget {
  final snap;
  const webcomedit({Key? key,this.snap}) : super(key: key);

  @override
  State<webcomedit> createState() => _webcomeditState();
}

class _webcomeditState extends State<webcomedit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Comment",
          style: TextStyle(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Card(
child: Container(
  child: Column(
    children: [

    ],
  ),
),
            ),
          ),
        ),
      ),
    );
  }
}
