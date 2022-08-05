
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Services/Upload.dart';


class Webeditpost extends StatefulWidget {
  final snap;
  const Webeditpost({Key? key,this.snap}) : super(key: key);

  @override
  State<Webeditpost> createState() => _WebeditpostState();
}

class _WebeditpostState extends State<Webeditpost> {
  dynamic _image;
  Upload Selection=Upload();


  _selectimage()async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: Text("Upload image"),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(15.0),
                child: Text("Choose from gallery"),
                onPressed: ()async{
                  Navigator.of(context).pop();
                  dynamic file=await Selection.uploadpic(ImageSource.gallery);
                  setState(() {
                    _image=file;
                  });
                },
              ),

            ],
          );
        }
    );
  }



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
            Post(_image),
            Divider(),
            Row(
              children: [
                IconButton(
                    onPressed: ()=>_selectimage(),
                    icon: Icon(
                        Icons.add_a_photo
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
