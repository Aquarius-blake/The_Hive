import 'package:flutter/material.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';

class webcomedit extends StatefulWidget {
  final snap;
  final postid;
  const webcomedit({Key? key,this.snap,this.postid}) : super(key: key);

  @override
  State<webcomedit> createState() => _webcomeditState();
}

class _webcomeditState extends State<webcomedit> {

  TextEditingController _comment=TextEditingController();

  @override
  void initState() {
    _comment.text=widget.snap['detail'];
    super.initState();
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Text(
          "Edit Comment",
          style: TextStyle(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding:const EdgeInsets.all(60),
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0)
              ),
              child: Container(
                padding: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.snap['Profile Pic']),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.01,
                        ),
                        SizedBox(
                          child: Text(widget.snap['author']),
                        )
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.7,
                      child: TextField(
                        maxLines: 8,
                        controller: _comment,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Edit comment",
                        ),
                      ),
                    ),

                    const  Divider(
                      thickness: 2,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: ()async{
                          String ress=await FirestoreMethods().Editcomment(widget.postid, widget.snap['Comment Uid'], _comment.text);
                        await  Showsnackbar(ress, context);
                        Navigator.of(context).pop();
                        },
                        child: Text(
                          "Edit Comment",
                          style: TextStyle(

                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 2.0, 
                            backgroundColor: Colors.lightBlueAccent,
                            shadowColor: Colors.black,
                            side: const BorderSide(
                              color: Colors.white70,
                              width: 2.0,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0)
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
