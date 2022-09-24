
import 'package:flutter/material.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';


class Creation extends StatefulWidget {
  const Creation({ Key? key }) : super(key: key);

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  dynamic image;
  final Upload Selection=Upload();
  TextEditingController Group_name=TextEditingController();
    TextEditingController Group_desc=TextEditingController();
  final _formKey =GlobalKey<FormState>();



 _selectimage(BuildContext context)async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text("Set Group Profile Picture"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text("Take a Photo"),
                onPressed: ()async{
                  Navigator.of(context).pop();
                  dynamic file=await Selection.uploadpic(ImageSource.camera);
                  setState(() {
                    image=file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(15.0),
                child: const Text("Choose from gallery"),
                onPressed: ()async{
                  Navigator.of(context).pop();
                  dynamic file=await Selection.uploadpic(ImageSource.gallery);
                  setState(() {
                    image=file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text("Cancel"),
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
  Widget build(BuildContext context) {
            late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color:Colors.white,
        ),
        title: const Text(
          "Create New Group",
          style:TextStyle(
            color:Colors.white
          ),),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child:Stack(
                          children: [
                            image!=null? CircleAvatar(
                              radius: 60.0,
                              backgroundImage:MemoryImage(image) ,
                            ):const CircleAvatar(
                              radius: 60.0,
                              backgroundColor:Colors.lightBlueAccent,
                            ),
                            Positioned(
                                bottom: -5,
                                left: 65,
                                child: IconButton(
                                    onPressed: ()=>_selectimage(context),
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                    )
                                )
                            )
                          ],
                        ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: Group_name,
                       validator: (val)=>val!.isEmpty ? "Enter Your Group Name" : null,
                       decoration: InputDecoration(
                            label: const Text("Group Name"),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            hintText: "Enter Your Group Name",
                            filled: true,
                            fillColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.redAccent
                              ),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),

                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),

                      ),
                      TextFormField(
                  controller: Group_desc,
                   validator: (val)=>val!.isEmpty ? "Enter Your Group's description" : null,
                   decoration: InputDecoration(
                            label: const Text("Group Description"),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            hintText: "Enter Group Description",
                            filled: true,
                            fillColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.redAccent
                              ),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),

                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),

                ),
                Center(
                  child: ElevatedButton(
                    child: const Text(
                      "Create Group",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                      )
                      ),
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                                elevation: 6.0,
                                shadowColor: Colors.black,
                                primary: Colors.black,
                                side: const BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),

                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)
                                )
                            ),
                    ),
                ),
                    ],
                  ),
                ),
              ],
            )
            ),
        ),
        ),
    );
  }
}