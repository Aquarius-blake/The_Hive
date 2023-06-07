import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Services/Encryption.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class Gchatcard extends StatefulWidget {
  final snap;
  const Gchatcard({ Key? key,this.snap }) : super(key: key);

  @override
  State<Gchatcard> createState() => _GchatcardState();
}

class _GchatcardState extends State<Gchatcard> {
  var plaintext;
  @override
  Widget build(BuildContext context) {
        late  User1 user1=  Provider.of<UserProvider>(context).getUser;
       late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
  //theme not implemented 
  //TODO:create new fields (next Version -v1.0.2)
  //TODO:replace current theme with new fields for sender and receiver cards

        plaintext=Encryption.decrypt(widget.snap['Message']);
            final Timestamp timestamp = widget.snap['Message Time'] as Timestamp;
    final DateTime dateTime = timestamp.toDate();
    final dateString = DateFormat('K:mm').format(dateTime);
    final dateday=DateFormat('E').format(dateTime);
    final date=DateFormat('d/M/y').format(dateTime);

    if(widget.snap['author uid']==user1.UID){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.6,
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 4,
              color: Colors.blue,
              shadowColor: Colors.grey,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left:15.0,
                  right:15.0,
                  top: 5,
                  bottom: 5, 
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 11,
                          backgroundImage: NetworkImage(user1.ppurl!),
                        ),
                       const SizedBox(
                          width: 2,
                        ),
                        const Text(
                          "Me",
                          style: TextStyle(
                            color: Colors. white,
                            )
                          ),
                      ],
                    ),
                    const SizedBox(height: 2,),
                    RichText(
                      text: TextSpan(
                        text:plaintext,
                        style: const TextStyle(
                          color: Colors. white,  
                          fontSize: 15,
                          )
                        ),
                      ),
                    const SizedBox(height: 2,),
                    Text(
                      "$date $dateday $dateString",
                      style: const TextStyle(
                        color: Colors.grey ,
                        fontSize: 10,
                        ),
                      ),
                  ]
                  ),
              ),
            ),
          ),
        ],
      ),
    );}else{
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.6,
              child: Card(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                  top: 5,
                  bottom: 5,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left:15.0,
                  right:15.0,
                  top: 5,
                  bottom: 5, 
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 11,
                            backgroundImage: NetworkImage(widget.snap['Profile Pic']),
                          ),
                         const SizedBox(width: 10,),
                         Text("${widget.snap['author']}"),
                        ],
                      ),
                      const SizedBox(height: 2,),
                      RichText(
                      text: TextSpan(
                        text:plaintext,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          )
                        ),
                      ),
                      const SizedBox(height: 2,),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "$date $dateday $dateString",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          ),
                        ),
                    ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}