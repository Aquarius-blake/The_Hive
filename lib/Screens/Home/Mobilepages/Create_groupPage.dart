
import 'package:flutter/material.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';


class Creation extends StatefulWidget {
  const Creation({ Key? key }) : super(key: key);

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  @override
  Widget build(BuildContext context) {
            late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color:Colors.white,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
        ),
        ),
    );
  }
}