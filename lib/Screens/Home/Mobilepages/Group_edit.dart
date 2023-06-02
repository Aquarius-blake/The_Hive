import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';

//TODO:implement theme for simple dialog
class Gedit extends StatefulWidget {
  const Gedit({ Key? key ,this.snap}) : super(key: key);

  final snap;

  @override
  State<Gedit> createState() => _GeditState();
}

class _GeditState extends State<Gedit> {
  final Upload Selection=Upload();
  TextEditingController groupdesc=TextEditingController();
  TextEditingController groupname=TextEditingController();
dynamic image;
dynamic image2;
  TextEditingController memalias=TextEditingController();
bool pop=false;
  TextEditingController postalias=TextEditingController();

  @override
  void initState() {
    super.initState();
     widget.snap["Group Name"]!=null?groupname.text=widget.snap["Group Name"]:groupname.text="";
    widget.snap["Group Description"]!=null?groupdesc.text=widget.snap["Group Description"]:groupdesc.text="";
    widget.snap["Identity"]!=null?memalias.text=widget.snap["Identity"]:memalias.text="";
    widget.snap["Post Name"]!=null?postalias.text=widget.snap["Post Name"]:postalias.text="";
  }

_selectimage2(BuildContext context)async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text("Set Colony Profile Picture"),
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

_deleteconfirm(BuildContext context)async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text("Are you sure you want to delete this Colony?"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text("Yes, Delete"),
                onPressed: ()async{
                  await FirestoreMethods().Deletegroup(widget.snap["Group Uid"]);
                  setState(() {
                    pop=true;
                  });
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(15.0),
                child: const Text("No, this was a mistake"),
                onPressed: ()async{
                  Navigator.of(context).pop();
                  setState(() {
                    pop=false;
                  });
                },
              ),
              
            ],
          );
        }
    );
  }

_selectimage(BuildContext context)async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text("Set Colony Header Picture"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text("Take a Photo"),
                onPressed: ()async{
                  Navigator.of(context).pop();
                  dynamic file=await Selection.uploadpic(ImageSource.camera);
                  setState(() {
                    image2=file;
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
                    image2=file;
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
            late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(themedata.AppbarbackColor),
        iconTheme:  IconThemeData(
          color: Color(themedata.AppbariconColor),
        ),
        title:  Text(
          "Edit Colony",
          style: TextStyle(
            color:Color(themedata.AppbartextColor),
          ),
          ),
          actions: [
            TextButton(
              onPressed: ()async{
               await _deleteconfirm(context);
               if(pop==true){
                Navigator.of(context).pop();
                }
              },
              child:  Text(
                "Delete Colony",
                style: TextStyle(
                  color: Color(themedata.AppbartextbuttonColor!),
                ),
                ),
            )
          ],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
             Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.3,
                    child: widget.snap['Header']!=""? Image.network(
                      "${widget.snap['Header']}",
                      fit: BoxFit.cover,
                      ):Container(
                        color: Colors.grey,
                        ),
                      ),
                      Positioned(
                        bottom: 90,
                        left: 150,
                        child: IconButton(
                          onPressed: ()async{
                           await _selectimage2(context);
                           if(image!=null){
                           String content= await FirestoreMethods().UpdateHeader(widget.snap['Group Uid'], image2);
                           Showsnackbar(content, context);
                           setState(() {
                             
                           });
                           }else{
                             Showsnackbar("No image selected", context);
                           }
                          },
                          icon:  FaIcon(
                            FontAwesomeIcons.camera,
                            size: 50,
                            color:  Color(themedata.ScaffoldiconColor),
                            ),
                          ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: -50,
                        child: GestureDetector(
                          onTap: ()async{
                            await _selectimage(context);
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.lightBlueAccent,
                            backgroundImage: image==null? NetworkImage(widget.snap['Group Pic']):Image.memory(image).image,
                            ),
                        ),
                        ),
                       
                ],
              ),
            const  SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: groupname,
                  style:  TextStyle(
                    color: Color(themedata.ScaffoldtextColor),
                  ),
                  decoration:  InputDecoration(
                    hintText: "Enter Colony Name here",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    label: Text(
                      "Colony Name",
                      style: TextStyle(
                        color: Color(themedata.ScaffoldtextColor),
                      ),
                      ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 5,
                  controller: groupdesc,
                  style:  TextStyle(
                    color: Color(themedata.ScaffoldtextColor),
                  ),
                  decoration:  InputDecoration(
                    hintText: "Enter Colony description here",
                    hintStyle:  TextStyle(
                      color: Colors.grey,
                    ),
                    label: Text(
                      "Colony Description",
                      style: TextStyle(
                        color: Color(themedata.ScaffoldtextColor),
                      ),
                      ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: memalias,
                  style:  TextStyle(
                    color: Color(themedata.ScaffoldtextColor),
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter Member Alias here",
                    hintStyle:const TextStyle(
                      color: Colors.grey,
                    ),
                    label: Text(
                      "Member Alias",
                      style: TextStyle(
                        color: Color(themedata.ScaffoldtextColor),
                      ),
                      ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: postalias,
                  style:  TextStyle(
                    color: Color(themedata.ScaffoldtextColor),
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter Post Alias here",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    label: Text(
                      "Post Alias",
                      style: TextStyle(
                        color: Color(themedata.ScaffoldtextColor),
                      ),
                      ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
             const SizedBox(
                height: 20,
                ),
              Center(
                child: ElevatedButton(
                  onPressed: ()async{
                    
                    if(groupdesc.text==""|| groupname.text==""|| memalias.text==""|| postalias.text==""){
                      Showsnackbar("Please fill all the fields", context);
                    }else{
                       String content=await FirestoreMethods().UpdateGroup(widget.snap['Group Uid'], groupname.text, groupdesc.text, memalias.text, postalias.text,image);
                    Showsnackbar(content, context);
                    Navigator.of(context).pop();
                    }
                  },
                  child:  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:  Text(
                      "Update",
                      style: TextStyle(
                        color: Color(themedata.ScaffoldbuttonTextColor),
                      ),
                      ),
                  ),
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
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                ),     
          ],
        ),
        )
    );
  }
}