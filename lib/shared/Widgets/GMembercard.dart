import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:provider/provider.dart';


class Gmembercard extends StatefulWidget {
  final snap;
  const Gmembercard({ Key? key,this.snap }) : super(key: key);

  @override
  State<Gmembercard> createState() => _GmembercardState();
}

class _GmembercardState extends State<Gmembercard> {
  @override
  Widget build(BuildContext context) {
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    return Container(
      child:Card(
        color: Color(themedata.CardBackgroundColor),
        child:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  widget.snap['profilepic']
                  ),
                  backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                width: 10,
                ),
              Text(
                "${widget.snap['username']}",
              style:  TextStyle(
                fontSize: 20,
                color:Color(themedata.CardTextColor),
                fontStyle: FontStyle.italic
              ),
              ),
            ]
            ),
        ),
      )
    );
  }
}