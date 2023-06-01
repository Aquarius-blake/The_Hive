import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Services/Encryption.dart';
import 'package:forum3/shared/error_handling.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Models/Users1.dart';
import '../../Provider/user_provider.dart';


class CHcard extends StatefulWidget {
  final snap;
  const CHcard({Key? key,this.snap}) : super(key: key);

  @override
  State<CHcard> createState() => _CHcardState();
}

class _CHcardState extends State<CHcard> {
  var plaintext;
  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    plaintext=Encryption.decrypt(widget.snap['Last Message']);

    try{
    final Timestamp timestamp = widget.snap['Chat Time'] as Timestamp;
    final DateTime dateTime = timestamp.toDate();
    final dateString = DateFormat('K:mm').format(dateTime);
    late String sent;
    if(widget.snap['Receiver uid']==user1.UID){

      sent="Received";
    }else{
      sent="Sent";
    }
    return Container(
      padding: const EdgeInsets.only(
        top: 5.0,
      ),
      child: Card(
        color: Color(themedata.CardBackgroundColor),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:   Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.snap['Profile Pic']),
                backgroundColor: Colors.lightBlueAccent,
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.snap['Receiver']}",
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color:Color(themedata.CardTextColor),
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                            text: plaintext.substring(0,plaintext.length/2),
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 const SizedBox(height: 15,),
                  Text(
                      "$sent  $dateString",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10,)
            ],
          ),
        ),
      ),
    );
    }catch(e){
      print(e.toString());
      String error="An error occurred: ${e.toString()}";
      errormessage(error, context);
      return const Center(
          child: CircularProgressIndicator()
      );
    }
  }
}







