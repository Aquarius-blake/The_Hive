import 'package:flutter/material.dart';

class Netcon extends StatefulWidget {
  const Netcon({Key? key}) : super(key: key);

  @override
  State<Netcon> createState() => _NetconState();
}

class _NetconState extends State<Netcon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.wifi_off,
                  size: 40,
                  color: Colors.black,
                ),
                Text(
                    "Check Network Connection",
                  style: TextStyle(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
