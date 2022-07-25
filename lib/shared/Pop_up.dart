import 'package:flutter/material.dart';


Showsnackbar(String content,BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(content)
      )
  );
}

