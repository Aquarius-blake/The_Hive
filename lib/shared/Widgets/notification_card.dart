import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:provider/provider.dart';
import '../Pop_up.dart';

class NotifCard extends StatefulWidget {
  final snap;
  const NotifCard({Key? key,this.snap}) : super(key: key);

  @override
  State<NotifCard> createState() => _NotifCardState();
}

class _NotifCardState extends State<NotifCard> {
 late bool loading;
 dynamic image;
 Widget Avatar(dynamic image){
   try{
     return image!=null?  CircleAvatar(
       radius: 20,
       backgroundImage: MemoryImage(image),
     ):widget.snap['Profile Pic']!=""? CircleAvatar(
       backgroundImage: NetworkImage(widget.snap['Profile Pic']),
       radius: 20,
     ):const CircleAvatar(
       backgroundImage: AssetImage('Assets/hac.jpg'),
       radius: 20,
     );
   }
   catch(e){
     Showsnackbar(e.toString(), context);
     return const CircleAvatar(
       backgroundImage: AssetImage('Assets/hac.jpg'),
       radius: 20,
     );
   }
 }

 @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
Future.delayed(const Duration(
    microseconds: 100
)
);
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    return Container(
      child:  Card(
        color:Color(themedata.CardBackgroundColor),
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  Avatar(image),
                  const SizedBox(width: 5,),
                  Expanded(
                    child:   Padding(
                      padding: const EdgeInsets.only(
                          left:8.0
                      ),
                      child:   Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: widget.snap['author'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        color: Color(themedata.CardTextColor),
                                        fontSize: 18,
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.snap['message'],
                                      style:  TextStyle(
                                        color: Color(themedata.CardTextColor),
                                        fontStyle: FontStyle.italic,
                                      )
                                    ),
                                    TextSpan(
                                      text: widget.snap['Event Title'],
                                      style:  TextStyle(
                                        fontWeight: FontWeight.bold,
                                            color:Color(themedata.CardTextColor),
                                      )
                                    )
                                  ]
                              )
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              /* Row(
                children: [
                  Text(
                    widget.snap['message'],
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                //TODO: Fix null value bug
                /*  Text(
                    widget.snap['Event Title'],
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),*/
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}




