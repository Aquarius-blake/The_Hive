import 'package:flutter/material.dart';



class Splashscreen extends StatefulWidget {
  

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.5,
        height: MediaQuery.of(context).size.height*0.7,
        child:Image.asset(
          'Assets/icon.png',
          width: MediaQuery.of(context).size.width*0.5,
          height: MediaQuery.of(context).size.height*0.7, 
          fit: BoxFit.fill,
          ),
      )
      );
  }
}