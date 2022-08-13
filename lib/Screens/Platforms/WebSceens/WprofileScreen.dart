import 'package:flutter/material.dart';


class Wprofile extends StatefulWidget {
  final snap;
  const Wprofile({Key? key,this.snap}) : super(key: key);

  @override
  State<Wprofile> createState() => _WprofileState();
}

class _WprofileState extends State<Wprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Card(
              child: Column(),
            ),
          ),
        ),
      ),
    );
  }
}
