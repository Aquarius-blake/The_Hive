import 'package:flutter/material.dart';

import '../../../Services/Upload.dart';

class Mobeditpost extends StatefulWidget {
  final snap;
  const Mobeditpost({Key? key,this.snap}) : super(key: key);

  @override
  State<Mobeditpost> createState() => _MobeditpostState();
}

class _MobeditpostState extends State<Mobeditpost> {
  dynamic _image;
  Upload Selection=Upload();
  final TextEditingController _title=TextEditingController();
  final TextEditingController _textEditingController2=TextEditingController();
  bool _isloading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme:const IconThemeData(
          color: Colors.black,
        ),
        title:const Text(
          "Edit Post",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
