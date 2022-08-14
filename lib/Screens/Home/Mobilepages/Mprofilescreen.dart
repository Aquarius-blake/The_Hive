import 'package:flutter/material.dart';



class Mprofile extends StatefulWidget {
  final snap;
  const Mprofile({Key? key,this.snap}) : super(key: key);

  @override
  State<Mprofile> createState() => _MprofileState();
}

class _MprofileState extends State<Mprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
CircleAvatar(
backgroundImage: NetworkImage(widget.snap['profilepic']),
  radius: 50,
),
                    SizedBox(width: MediaQuery.of(context).size.width*0.3,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text("20"),
                            SizedBox(width: 10,),
                            Text(
                              "Posts",
                            style: TextStyle(
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                            ),
                            )
                          ],
                        ),
                        Row()
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
