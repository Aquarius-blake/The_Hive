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
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Card(
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width,),
                    Text("sdsafdsf")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
