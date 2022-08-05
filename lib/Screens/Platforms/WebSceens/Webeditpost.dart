
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';
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
  TextEditingController _title=TextEditingController();
  TextEditingController _detail=TextEditingController();


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
  void initState() {
    _title.text=widget.snap['title'];
    _detail.text=widget.snap['detail'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User1? user1=  Provider.of<UserProvider>(context).getUser;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(user1.ppurl!),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: Text(user1.Username!),
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.7,
              child: TextField(
                controller: _title,
                decoration: InputDecoration(
                  hintText: "Title",
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.7,
              child: TextField(
                controller: _detail,
                decoration: InputDecoration(
                  hintText: "Detals",
                ),
              ),
            ),
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
