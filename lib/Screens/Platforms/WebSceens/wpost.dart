import 'package:flutter/material.dart';

import '../../../Services/Upload.dart';

class wpost extends StatefulWidget {
  const wpost({Key? key}) : super(key: key);

  @override
  State<wpost> createState() => _wpostState();
}

class _wpostState extends State<wpost> {
  dynamic _image;
  bool _isloading=false;
  final TextEditingController _textEditingController=TextEditingController();
  final TextEditingController _textEditingController2=TextEditingController();
  Upload Selection=Upload();

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
