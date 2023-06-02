
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';


class Creation extends StatefulWidget {
  const Creation({ Key? key }) : super(key: key);

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
    TextEditingController Group_desc=TextEditingController();
  TextEditingController Group_name=TextEditingController();
  final Upload Selection=Upload();
  dynamic image;

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
            late  User1 user1=  Provider.of<UserProvider>(context,listen: false).getUser;
            late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(themedata.AppbarbackColor),
        iconTheme:  IconThemeData(
          color:Color(themedata.AppbariconColor),
        ),
        title:  Text(
          "Create New Colony",
          style:TextStyle(
            color:Color(themedata.AppbartextColor)
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
                                    icon:  Icon(
                                      Icons.add_a_photo,
                                      color: Color(themedata.ScaffoldiconColor),
                                    )
                                )
                            )
                          ],
                        ),
                ),
                const SizedBox(height: 20,),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: Group_name,
                       validator: (val)=>val!.isEmpty ? "Enter Your Colony Name" : null,
                       decoration: InputDecoration(
                            label: const Text("Group Name"),
                            labelStyle:  TextStyle(
                              color: Color(themedata.ScaffoldtextColor),
                            ),
                            hintText: "Enter Your Colony Name",
                            filled: true,
                            fillColor: Colors.transparent,
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
                          style:  TextStyle(
                            color: Color(themedata.ScaffoldtextColor),
                          ),

                      ),
                     const SizedBox(height: 20,),
                      TextFormField(
                        maxLines: 8,
                  controller: Group_desc,
                   validator: (val)=>val!.isEmpty ? "Enter Your Colony's description" : null,
                   decoration: InputDecoration(
                            label: const Text("Colony Description"),
                            labelStyle:  TextStyle(
                              color: Color(themedata.ScaffoldtextColor),
                            ),
                            hintText: "Enter Colony Description",
                            filled: true,
                            fillColor: Colors.transparent,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.redAccent
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),

                            ),
                          ),
                          style:  TextStyle(
                            color: Color(themedata.ScaffoldtextColor),
                          ),

                ),
               const SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(
                    child: const Text(
                      "Create Colony",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                      )
                      ),
                    onPressed: ()async{
                      if(_formKey.currentState?.validate()!=null && image!=null){
                       String ress= await FirestoreMethods().CreateGroup(user1.UID!, user1.Username!, Group_name.text, Group_desc.text, image,user1);
                     await Showsnackbar(ress, context);
                     Navigator.of(context).pop();
                      }else{
                        Showsnackbar("Please fill all the fields", context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                                elevation: 6.0, 
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.black,
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