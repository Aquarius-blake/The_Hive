import 'package:flutter/material.dart';
import 'package:forum3/Screens/Home/home.dart';
import 'package:forum3/Screens/Platforms/Web.dart';
import 'package:forum3/shared/dim.dart';

//Seperates the view for android and web based on screen size.
class Layout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth >websreensize){
            return Webview();
          }else{
            return Home();
          }
        }
        );

  }
}
