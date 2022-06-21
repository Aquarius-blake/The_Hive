import 'package:flutter/material.dart';
import 'package:forum3/Screens/Home/home.dart';
import 'package:forum3/Screens/Platforms/Web.dart';
import 'package:forum3/shared/dim.dart';

class Layout extends StatelessWidget {

  const Layout({Key? key}) : super(key: key);

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
