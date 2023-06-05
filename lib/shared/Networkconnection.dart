import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Netcon extends StatefulWidget {
  const Netcon({Key? key}) : super(key: key);

  @override
  State<Netcon> createState() => _NetconState();
}

class _NetconState extends State<Netcon> {

  late String message="Slow Internet Connection";

  Future delay()async{
    await Future.delayed(
      const Duration(
          minutes: 1
      ),
    );
    setState(() {
      message="Check Network Connection";
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    delay();
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const SizedBox(height: 50,),
                const Icon(
                  Icons.wifi_off,
                  size: 40,
                  color: Colors.black,
                ),
                Text(
                  message,
                  style: TextStyle(),
                ),
                const SizedBox(height: 200,),
                const SpinKitPouringHourGlassRefined(
                    color: Colors.black,
                size: 100,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
