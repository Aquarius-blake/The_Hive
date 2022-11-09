import 'package:flutter/material.dart';

class Atogglebutton extends StatefulWidget {
  const Atogglebutton({ Key? key }) : super(key: key);

  @override
  State<Atogglebutton> createState() => _AtogglebuttonState();
}

class _AtogglebuttonState extends State<Atogglebutton> {
 
bool toggleValue=false;

toggleButton(){
  setState(() {
    toggleValue=!toggleValue;
  });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child:AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        height:20.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: toggleValue? Colors.greenAccent[100]: Colors.redAccent[100]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              curve: Curves.easeIn ,
              duration: Duration(milliseconds: 1000),
              top: 3.0,
              left: toggleValue? 30.0: 0.0,
              right: toggleValue? 0.0: 30.0,
              child: InkWell(
                onTap: toggleButton, 
              ),
              )
          ],
        ),
        )
    );
  }
}