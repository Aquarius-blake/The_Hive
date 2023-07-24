import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Services/Encryption.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Models/Users1.dart';
import '../../Provider/user_provider.dart';


class chatcard extends StatefulWidget {
  final snap;
  const chatcard({Key? key,this.snap}) : super(key: key);

  @override
  State<chatcard> createState() => _chatcardState();
}

class _chatcardState extends State<chatcard> {
  late bool recever;
  late int timehr;
  late int timemin;
  var plaintext;
  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    final Timestamp timestamp = widget.snap['Message Time'] as Timestamp;
    final DateTime dateTime = timestamp.toDate();
    final dateString = DateFormat('K:mm a').format(dateTime);
    final dateday=DateFormat('E').format(dateTime);
     final date=DateFormat('d/M/y').format(dateTime);
    String restate;

    plaintext=Encryption.decrypt(widget.snap['Message']);

    if(widget.snap['Receiver Uid']!=user1.UID){
      recever=false;
      restate="Sent";
    }else{
      recever=true;
      restate="Recceived";
    }
    if(recever){
      return Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          alignment: Alignment.centerRight,
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(15)
                )
            ),
            color: Colors.lightBlueAccent[100],
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    softWrap: true,
                      text: TextSpan(
                        text: plaintext,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      )
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "$restate $date $dateday $dateString",
                        style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 12
                        ),
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }else{
      return Align(
        alignment: Alignment.bottomRight,
        child: Container(
          alignment: Alignment.bottomRight,
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(10)
              )
            ),
            color: Colors.white,
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    softWrap: true,
                      text: TextSpan(
                        text: plaintext,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      )
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "$restate $date $dateday $dateString",
                        style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 12
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
