import 'package:flutter/material.dart';
import 'package:forum3/Screens/Platforms/WebSceens/webcom.dart';

class Wcommentd extends StatefulWidget {
  final snap;
  const Wcommentd({Key? key,this.snap}) : super(key: key);

  @override
  State<Wcommentd> createState() => _WcommentdState();
}

class _WcommentdState extends State<Wcommentd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Discussion",
          style: TextStyle(

          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Card(
              elevation: 15.0,
              color: Colors.white,
              shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
              ),
              child: PageView(
                children:  [
                  webcom(
                    snap: widget.snap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
