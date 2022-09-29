import 'package:flutter/material.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:image_picker/image_picker.dart';


class GrPost extends StatefulWidget {
  final snap;
  const GrPost({ Key? key,this.snap }) : super(key: key);

  @override
  State<GrPost> createState() => _GrPostState();
}

class _GrPostState extends State<GrPost> {
  dynamic _image;
  Upload Selection=Upload();


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
      return user1.ppurl==""?const CircleAvatar(
           radius: 20,
        backgroundImage: AssetImage('Assets/hac.jpg'),     
      )
       : CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(user1.ppurl!),
      );
    }catch(e){
      return const CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage('Assets/hac.jpg'),
      );
    }
  }

  Widget Post(){
    return _image==null?SizedBox():SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      child:Image.memory(_image),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black ,
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Group Post",
          style: TextStyle(
            color:Colors.white,
          ),
          ),
      ),
      
    );
  }
}