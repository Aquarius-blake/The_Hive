import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:provider/provider.dart';


class GroupCard extends StatefulWidget {
  final snap;
  const GroupCard({ Key? key , this.snap}) : super(key: key);

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  @override
  Widget build(BuildContext context) {
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    return Container(
      padding: const EdgeInsets.all(10.0),
      child:Card(
        elevation: 0.0,
        color:Color(themedata.CardBackgroundColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(widget.snap['Group Pic']),
                radius:20,
              ),
             const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text(
                        "${widget.snap['Group Name']}",
                        style:  TextStyle(
                          color: Color(themedata.CardTextColor),
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                    ),
                  ),
                 const  SizedBox(height: 5,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.7,
                      child: RichText(
                        text: TextSpan(
                          text:"${widget.snap['Group Description']}",
                          style: TextStyle(
                            color: Color(themedata.CardTextColor),
                          ),
                          ),
                          ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

