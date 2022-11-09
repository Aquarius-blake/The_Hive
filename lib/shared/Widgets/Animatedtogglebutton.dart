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
        duration: Duration(milliseconds: 500),
        height:40.0,
        width: 100.0,
        decoration: BoxDecoration(
          color: toggleValue? Colors.lightBlueAccent: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              curve: Curves.easeIn ,
              duration: Duration(milliseconds: 500),
              top: 3.0,
              left: toggleValue? 60.0: 0.0,
              right: toggleValue? 0.0: 60.0,
              child: InkWell(
                onTap: toggleButton,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation){
                    return RotationTransition(
                      turns: animation,
                      child: child,
                    );
                  },
                  child: toggleValue? Icon(Icons.check_circle, color: Colors.blue, size: 30.0, key: UniqueKey(),): Icon(Icons.remove_circle_outline, color: Colors.white, size: 30.0, key: UniqueKey(),),
                ), 
              ),
              )
          ],
        ),
        )
    );
  }
}