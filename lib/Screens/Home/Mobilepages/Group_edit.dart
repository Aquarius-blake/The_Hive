import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../Models/Users1.dart';


class Gedit extends StatefulWidget {
  final snap;
  const Gedit({ Key? key ,this.snap}) : super(key: key);

  @override
  State<Gedit> createState() => _GeditState();
}

class _GeditState extends State<Gedit> {

dynamic image;
  final Upload Selection=Upload();
  TextEditingController groupname=TextEditingController();
  TextEditingController groupdesc=TextEditingController();
  TextEditingController memalias=TextEditingController();
  TextEditingController postalias=TextEditingController();


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
          color: Colors.white,
        ),
        title: const Text(
          "Edit Group",
          style: TextStyle(
            color:Colors.white,
          ),
          ),
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
                           await _selectimage(context);
                           if(image!=null){
                           String content= await FirestoreMethods().UpdateHeader(widget.snap['Group Uid'], image);
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
                            color:  Colors.white,
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
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Enter Group Name here",
                    hintStyle:  TextStyle(
                      color: Colors.white,
                    ),
                    label: Text(
                      "Group Name",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
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
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Enter Group description here",
                    hintStyle:  TextStyle(
                      color: Colors.white,
                    ),
                    label: Text(
                      "Group Description",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: memalias,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Enter Member Alias here",
                    hintStyle:  TextStyle(
                      color: Colors.white,
                    ),
                    label: Text(
                      "Member Alias",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: postalias,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Enter Post Alias here",
                    hintStyle:  TextStyle(
                      color: Colors.white,
                    ),
                    label: Text(
                      "Post Alias",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: ()async{
                    String content=await FirestoreMethods().UpdateGroup(widget.snap['Group Uid'], groupname.text, groupdesc.text, memalias.text, postalias.text,image);
                    Showsnackbar(content, context);
                  },
                  child: const Text("Update"),
                  ),
              ),     
          ],
        ),
        )
    );
  }
}