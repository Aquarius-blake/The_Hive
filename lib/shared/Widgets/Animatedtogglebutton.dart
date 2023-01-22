import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:provider/provider.dart';


class Atogglebutton extends StatefulWidget {
  final uid;
  final mode;
   Atogglebutton({ Key? key, this. uid,this.mode }) : super(key: key);

  @override
  State<Atogglebutton> createState() => _AtogglebuttonState();
}

class _AtogglebuttonState extends State<Atogglebutton> {
 
late bool toggleValue;

toggleButton(String uid,bool mode)async{

String? content=await FirestoreMethods().UpdateThemeMode(uid,!mode);
await Showsnackbar(content!,context);

  setState(() {
    toggleValue=!toggleValue;
  });
}

  @override
  Widget build(BuildContext context) {
        late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    toggleValue=themedata.DarkMode;
    return Container(
      child:AnimatedContainer(
        duration:const Duration(milliseconds: 500),
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
                onTap:()async{
                  toggleButton(widget.uid,toggleValue);
                },
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