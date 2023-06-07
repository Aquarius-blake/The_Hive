import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//theme implemented
class RequestCard extends StatefulWidget {
  final snap;
  const RequestCard({Key? key,this.snap}) : super(key: key);

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
        late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
         final Timestamp timestamp = widget.snap['Request Time'] as Timestamp;
    final DateTime dateTime = timestamp.toDate();
    final dateString = DateFormat('K:mm a').format(dateTime);
    final dateday=DateFormat('E').format(dateTime);
    final date=DateFormat('d/M/y').format(dateTime);

    return Container(
      child: Card(
        color:Color(themedata.CardBackgroundColor),
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.snap['Profile Pic']),
                    backgroundColor: Colors.transparent,
                    radius: 20,
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.snap['author'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                    color:Color(themedata.CardTextColor),
                                )
                              ),
                              TextSpan(
                                text: " Requested for Administrative permissions, ",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color(themedata.CardTextColor)
                                ),
                              ),
                              TextSpan(
                                  text: "Approve or Deny request?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(themedata.CardTextColor),
                                ),
                              ),
                            ]
                        )
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: ()async{
                        String ress= await FirestoreMethods().Approval(widget.snap['author uid']);
                        Showsnackbar(ress, context);
                      },
                      child:  Text(
                          "Approve",
                      style: TextStyle(
                        color: Color(themedata.CardTextButtonColor!)
                      ),
                      )
                  ),
                 const SizedBox(width: 15,),
                  TextButton(
                      onPressed: ()async{
                        String content=await FirestoreMethods().DenyRequest(widget.snap['author uid']);
                        Showsnackbar(content, context);
                      },
                      child: Text(
                          "Deny",
                      style: TextStyle(
                        color: Color(themedata.CardTextButtonColor!)
                      ),
                      )
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "$date $dateday $dateString",
                  style: TextStyle(
                    color: Color(themedata.CardTextColor),
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

