import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';


class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.lightBlueAccent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SpinKitHourGlass(
                      color: Colors.white,
                          size: 110.0,
                  ),
                  const SizedBox(height: 5.0,),
                  Text(
                      "Loading, Please Wait A Moment",
                    style: GoogleFonts.abel(
                      textStyle: const TextStyle(
                                color: Colors.white,
                      ),
                      fontStyle: FontStyle.italic,
                      fontSize: 25.0,
                    ),
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
