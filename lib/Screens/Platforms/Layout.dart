import 'package:flutter/material.dart';
import 'package:forum3/Screens/Home/home.dart';
import 'package:forum3/Screens/Platforms/Web.dart';
import 'package:forum3/shared/dim.dart';
import 'package:provider/provider.dart';

import '../../Provider/user_provider.dart';

//Seperates the view for android and web based on screen size.
class Layout extends StatefulWidget {


  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  void initState() {
    initial();
    super.initState();
  }
  void initial()async{
    /* DocumentSnapshot snap= await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username=(snap.data() as Map<String,dynamic>)['username'];
    });*/

    UserProvider _userprovider=Provider.of(context,listen: false);
    await _userprovider.Refreshuser();

    //TODO: Get Settings provider here and set the theme

  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth >websreensize){
            return Webview();
          }else{
            return Home();
          }
        }
        );

  }
}
