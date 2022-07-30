import 'package:flutter/material.dart';

import '../../../Services/Firestoremethods.dart';
import '../../../Services/Upload.dart';
import '../../../shared/Pop_up.dart';
import '../../../shared/error_handling.dart';

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

  void _posting(String uid,String author,dynamic profilepic)async{
    setState(() {
      _isloading=true;
    });
    try{
      String res=await FirestoreMethods().Uploadpost(_textEditingController.text, _textEditingController2.text, _image, uid, author, profilepic);
      if(res=="success"){
        setState(() {
          _isloading=false;
        });
        Showsnackbar("Post Successful", context);
      }
      else{
        setState(() {
          _isloading=false;
        });
        Showsnackbar(res, context);
      }
    }catch(e){
      String err=e.toString();
      errormessage(err, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
