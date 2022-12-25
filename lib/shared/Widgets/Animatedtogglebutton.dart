import 'package:flutter/material.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';


class Atogglebutton extends StatefulWidget {
  const Atogglebutton({ Key? key }) : super(key: key);

  @override
  State<Atogglebutton> createState() => _AtogglebuttonState();
}

class _AtogglebuttonState extends State<Atogglebutton> {
 
bool toggleValue=false;

toggleButton(String uid)async{

String content=await FirestoreMethods().UpdateThemeMode(uid,true);
await Showsnackbar(content,context);

  setState(() {
    toggleValue=!toggleValue;
  });
}

  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    return Container(
      child:AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height:32.0,
        width: 80.0,
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
              left: toggleValue? 40.0: 0.0,
              right: toggleValue? 0.0: 40.0,
              child: InkWell(
                onTap: toggleButton(User1.UID),
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