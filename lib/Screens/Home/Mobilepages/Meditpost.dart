import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';
import '../../../Services/Upload.dart';

class Mobeditpost extends StatefulWidget {
  final snap;
  const Mobeditpost({Key? key,this.snap}) : super(key: key);

  @override
  State<Mobeditpost> createState() => _MobeditpostState();
}

class _MobeditpostState extends State<Mobeditpost> {
  dynamic _image;
  Upload Selection=Upload();
  final TextEditingController _title=TextEditingController();
  final TextEditingController _detail=TextEditingController();
  bool _isloading=false;
  bool memorypost=false;

  @override
  void initState() {
_image=widget.snap['Image Url'];
    super.initState();
  }
  Widget Avatar(User1 user1){
    try{
      return CircleAvatar(
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
    if(memorypost){
      return SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        child: Image.memory(_image),
      );
    }else{
    return _image==null || _image==""?SizedBox():SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      child:Image.network(_image),
    );}
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
                    memorypost=true;
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
                    memorypost=true;

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



  @override
  void dispose() {
    _title.dispose();
    _detail.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme:const IconThemeData(
          color: Colors.black,
        ),
        title:const Text(
          "Edit Post",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _isloading? const LinearProgressIndicator():Container(),
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
                          controller: _title,
                          decoration: const InputDecoration(
                            hintText: "Title",
                          ),
                        ),
                        SizedBox(height: 10,),
                        SingleChildScrollView(
                          child: TextField(
                            controller: _detail,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              hintText: "Write Something.....",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Post(),
                        Divider(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: ()=>_selectimage(context),
                              icon: const Icon(
                                Icons.add_a_photo,
                              ),
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
    );
  }
}
