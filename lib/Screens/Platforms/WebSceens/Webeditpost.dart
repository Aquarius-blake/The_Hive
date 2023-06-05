
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';
import '../../../Services/Firestoremethods.dart';
import '../../../Services/Upload.dart';
import '../../../shared/Pop_up.dart';


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
  bool memoryimage=false;


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
                    memoryimage=true;
                  });
                },
              ),

            ],
          );
        }
    );
  }



  Widget Post(dynamic image){
    if(memoryimage){
      return _image!=null? SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        child: Image.memory(_image),
      ):const SizedBox();
    }else{
      return _image==null || _image==""?SizedBox():SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        child:Image.network(_image),
      );}
  }

  @override
  void dispose() {
    _title.dispose();
    _detail.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _title.text=widget.snap['title'];
    _detail.text=widget.snap['detail'];
    _image=widget.snap['Image Url'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User1? user1=  Provider.of<UserProvider>(context).getUser;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
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
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: "Detals",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Post(_image),
              Divider(
                height: 20,
                thickness: 2,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: ()=>_selectimage(),
                      icon: const Icon(
                          Icons.add_a_photo
                      )
                  ),
                  IconButton(onPressed: (){
                    setState(() {
                      _image=null;
                    });
                  },
                      icon: const Icon(
                          Icons.remove_circle
                      )
                  ),
                  const Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox()
                  ),
                  Align(
                    child: ElevatedButton(
                      onPressed: ()async{
                        String ress=await FirestoreMethods().Editpost(widget.snap['Post Uid'], _title.text, _detail.text, _image, memoryimage);
                      await  Showsnackbar(ress, context);
                        Navigator.of(context).pop();
                      },
                      child: Text("Edit Post"),
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0, 
                          backgroundColor: Colors.blue[400],
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
