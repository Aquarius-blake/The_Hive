import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';
import '../../../Services/Firestoremethods.dart';
import '../../../Services/Upload.dart';
import '../../../shared/Pop_up.dart';
import '../../../shared/error_handling.dart';

class wpost extends StatefulWidget {
  const wpost({Key? key}) : super(key: key);

  @override
  State<wpost> createState() => _wpostState();
}

class _wpostState extends State<wpost> {
  dynamic _image;
  bool _isloading=false;
  final TextEditingController _textEditingController=TextEditingController();
  final TextEditingController _textEditingController2=TextEditingController();
  Upload Selection=Upload();

  void _posting(String uid,String author,dynamic profilepic)async{
    setState(() {
      _isloading=true;
    });
    try{
      String res=await FirestoreMethods().Uploadpost(_textEditingController.text, _textEditingController2.text, _image, uid, author, profilepic);
      if(res=="success"){
        setState(() {
          _isloading=false;
          _textEditingController.text="";
          _textEditingController2.text="";
          _image=null;
        });
        Showsnackbar("Post Successful", context);
      }
      else{
        setState(() {
          _isloading=false;
        });
        Showsnackbar(res, context);
      }
    }catch(e){
      String err=e.toString();
      errormessage(err, context);
    }
  }

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
    User1? user1=  Provider.of<UserProvider>(context).getUser;

    return   SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      child: _isloading?SafeArea(
          child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,)
          )
      ):
      Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.lightBlueAccent,
                    backgroundImage: NetworkImage(user1.ppurl!),
                  ),
                  SizedBox(width: 20,),
                  Text(
                    user1.Username!,
                    style: const TextStyle(
                      fontSize: 19,
                    ),
                  )
                  ,
                ],
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText:"Title",
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextField(
                    controller: _textEditingController2,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText:"Write Something........",
                       border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Post(_image),
              SizedBox(height: 20,),
              const Divider(
                height: 20,
                thickness: 2,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: ()=>_selectimage(),
                      icon: Icon(Icons.add_a_photo)
                  ),
                  const Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox()
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: ()=>_posting(user1.UID!, user1.Username!, user1.ppurl),
                      child: Text("Post"),
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0, backgroundColor: Colors.blue[400],
                          shadowColor: Colors.black,
                          side: BorderSide(
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
