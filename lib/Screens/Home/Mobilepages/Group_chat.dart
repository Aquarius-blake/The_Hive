import 'package:flutter/material.dart';



class Gchatscreen extends StatefulWidget {
  final snap;
  const Gchatscreen({ Key? key,this.snap }) : super(key: key);

  @override
  State<Gchatscreen> createState() => _GchatscreenState();
}

class _GchatscreenState extends State<Gchatscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.snap['Group Name'],
          style: const TextStyle(
            color: Colors.white,
          ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
      ),
    );
  }
}