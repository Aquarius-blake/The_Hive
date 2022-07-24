import 'package:flutter/material.dart';

class Mmessages extends StatefulWidget {
  const Mmessages({Key? key}) : super(key: key);

  @override
  State<Mmessages> createState() => _MmessagesState();
}

class _MmessagesState extends State<Mmessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SafeArea(
    child: Container(

    )
),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
      child: Icon(Icons.chat),),
    );
  }
}
