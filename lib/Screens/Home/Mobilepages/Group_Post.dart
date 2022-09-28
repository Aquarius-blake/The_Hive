import 'package:flutter/material.dart';


class GrPost extends StatefulWidget {
  final snap;
  const GrPost({ Key? key,this.snap }) : super(key: key);

  @override
  State<GrPost> createState() => _GrPostState();
}

class _GrPostState extends State<GrPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black ,
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Group Post",
          style: TextStyle(
            color:Colors.white,
          ),
          ),
      ),
      
    );
  }
}