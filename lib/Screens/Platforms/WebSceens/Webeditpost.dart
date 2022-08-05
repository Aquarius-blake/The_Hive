import 'package:flutter/material.dart';


class Webeditpost extends StatefulWidget {
  final snap;
  const Webeditpost({Key? key,this.snap}) : super(key: key);

  @override
  State<Webeditpost> createState() => _WebeditpostState();
}

class _WebeditpostState extends State<Webeditpost> {
 dynamic image;
  Widget Post(dynamic image){
    return image==null?SizedBox():SizedBox(
      width: MediaQuery.of(context).size.width*0.3,
      child: Image.memory(image),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [

              ],
            ),
            SizedBox(),
            Post(image),
            Divider(),
            Row(
              children: [

              ],
            )
          ],
        ),
      ),
    );
  }
}
