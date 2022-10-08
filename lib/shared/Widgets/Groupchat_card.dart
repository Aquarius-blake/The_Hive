import 'package:flutter/material.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Services/Encryption.dart';
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
        plaintext=Encryption.decrypt(widget.snap['Message']);
    if(widget.snap['author uid']==user1.UID){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.5,
            child: Card(
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
                          radius: 10,
                          backgroundImage: NetworkImage(user1.ppurl!),
                        ),
                       const SizedBox(
                          width: 10,
                        ),
                        const Text("Me")
                      ],
                    ),
                    const SizedBox(height: 2,),
                    RichText(
                      text: TextSpan(
                        text:plaintext,
                        style: const TextStyle(
                          color: Colors.white,  
                          fontSize: 15,
                          )
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
            Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(widget.snap['Profile Pic']),
                      ),
                     const SizedBox(width: 10,),
                     Text("${widget.snap['author']}"),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  RichText(
                  text: TextSpan(
                    text:plaintext,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}