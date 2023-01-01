
import 'package:flutter/material.dart';
import 'package:forum3/Screens/Authenticate/signin.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignin=true;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Singin(),
    );
  }
}
