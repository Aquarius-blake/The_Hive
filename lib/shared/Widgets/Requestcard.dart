import 'package:flutter/material.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';

class RequestCard extends StatefulWidget {
  final snap;
  const RequestCard({Key? key,this.snap}) : super(key: key);

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color:Colors.black,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.snap['Profile Pic']),
                    backgroundColor: Colors.lightBlueAccent,
                    radius: 20,
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.snap['author'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                    color:Colors.white,
                                )
                              ),
                            const  TextSpan(
                                text: " Requested for Administrative permissions, ",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white
                                ),
                              ),
                            const  TextSpan(
                                  text: "Approve or Deny request?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                      child: const Text(
                          "Approve",
                      style: TextStyle(
                        color: Colors.lightBlueAccent
                      ),
                      )
                  ),
                  SizedBox(width: 15,),
                  TextButton(
                      onPressed: ()async{
                        String content=await FirestoreMethods().DenyRequest(widget.snap['author uid']);
                        Showsnackbar(content, context);
                      },
                      child: const Text(
                          "Deny",
                      style: TextStyle(
                        color: Colors.lightBlueAccent
                      ),
                      )
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

