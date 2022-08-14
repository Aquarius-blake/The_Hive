import 'package:flutter/material.dart';



class Mprofile extends StatefulWidget {
  final snap;
  const Mprofile({Key? key,this.snap}) : super(key: key);

  @override
  State<Mprofile> createState() => _MprofileState();
}

class _MprofileState extends State<Mprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  iconTheme: IconThemeData(
color: Colors.black
  ),
  title: Text("Profile"),
  centerTitle: true,
),
    );
  }
}
