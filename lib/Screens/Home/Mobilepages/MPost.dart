import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';

class Mpost extends StatefulWidget {
  Mpost({Key? key}) : super(key: key);

  @override
  State<Mpost> createState() => _MpostState();
}

class _MpostState extends State<Mpost> {
  dynamic _image;
  Upload Selection=Upload();
  final TextEditingController _textEditingController=TextEditingController();

  void _posting(String uid,String author,dynamic profilepic)async{
    try{

    }catch(e){

    }
  }


  _selectimage(BuildContext context)async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: Text("Create Post"),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(15.0),
                child: Text("Take a Photo"),
                onPressed: ()async{
                  Navigator.of(context).pop();
                  dynamic file=await Selection.uploadpic(ImageSource.camera);
                  setState(() {
                    _image=file;
                  });
                },
              ),
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
              SimpleDialogOption(
                padding: EdgeInsets.all(15.0),
                child: Text("Cancel"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );

  }


  Widget Avatar(User1 user1){
    try{
      return CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(user1.ppurl!),
      );
    }catch(e){
      return CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage('Assets/hac.jpg'),
      );
    }
  }

  Widget Post(){
    return _image==null?SizedBox():SizedBox(
      width: MediaQuery.of(context).size.width*0.5,
      child:Image.memory(_image),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Avatar(user1),
                            SizedBox(width: 15,),
                            Text(user1.Username!),
                          ],
                        ),
                        SizedBox(height: 15,),
                        TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Title",
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          controller: _textEditingController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: "Write Something.....",
                            border: InputBorder.none,
                          ),
                        ),
                        Post(),
                        Divider(),
                        Row(
                          children: [
                            IconButton(
                                onPressed: ()=>_selectimage(context),
                                icon: Icon(Icons.add_a_photo
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_posting(user1.UID!,user1.Username!,user1.ppurl),
        child: LineIcon(LineIcons.earlybirds),
      ),









    );
  }
}













