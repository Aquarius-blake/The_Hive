import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:forum3/shared/error_handling.dart';
import 'package:image_picker/image_picker.dart';


class Medprofile extends StatefulWidget {
  final snap;
   bool drawer;
   User1? user1;
   Medprofile({Key? key,this.snap,required this.drawer,this.user1}) : super(key: key);

  @override
  State<Medprofile> createState() => _MedprofileState();
}

class _MedprofileState extends State<Medprofile> {
  dynamic image;
  final Upload Selection=Upload();
  TextEditingController Fname=TextEditingController();
  TextEditingController Bio=TextEditingController();
  TextEditingController username=TextEditingController();
  TextEditingController DOB=TextEditingController();
  TextEditingController gender=TextEditingController();
late DateTime? _dateTime;

  final _formKey =GlobalKey<FormState>();


  _selectimage(BuildContext context)async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text("Update Profile Picture"),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(15.0),
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
                padding: EdgeInsets.all(15.0),
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
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    try {
     !widget.drawer? Fname.text = widget.snap['Full Name']:Fname.text=widget.user1!.Name!;
     !widget.drawer? Bio.text=widget.snap['Bio']:Bio.text=widget.user1!.Bio!;
     !widget.drawer? username.text=widget.snap['username']:username.text=widget.user1!.Username!;
     !widget.drawer? gender.text=widget.snap['Gender']:gender.text=widget.user1!.Gender!;
     !widget.drawer? DOB.text=widget.snap['DateofBirth']:DOB.text=widget.user1!.DOB!;

    }catch(e){
      errormessage(e.toString(), context);
    }    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Fname.dispose();
    Bio.dispose();
    username.dispose();
    DOB.dispose();
    gender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            image!=null? CircleAvatar(
                              radius: 60.0,
                              backgroundImage:MemoryImage(image) ,
                            ):CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(
                                  !widget.drawer? widget.snap['profilepic']:
                                  widget.user1!.ppurl!),
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: Fname,
                          validator: (val)=>val!.isEmpty ? "Enter Your Full Name" : null,
                          onChanged: (val){
                            setState(() {
                            //  Fname.text=val;
                            });
                          },
                          decoration: InputDecoration(
                            label: const Text("Full Name"),
                            hintText: "Enter Full Name",
                            filled: true,
                            fillColor: Colors.white70,
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

                          style: const TextStyle(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: username,
                          validator: (val)=>val!.isEmpty ? "Enter Your Username" : null,
                          onChanged: (val){
                            setState(() {
                           //   username.text=val;
                            });
                          },
                          decoration: InputDecoration(
                            label: const Text("Username"),
                            hintText: "Enter Nick Name",
                            filled: true,
                            fillColor: Colors.white70,
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
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: gender,
                          validator: (val)=>val!.isEmpty ? "Enter Your Username" : null,
                          onChanged: (val){
                            setState(() {
                            //  gender.text=val;
                            });
                          },
                          decoration: InputDecoration(
                            label: const Text("Gender"),
                            hintText: "Enter Gender",
                            filled: true,
                            fillColor: Colors.white70,
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

                          style: const TextStyle(),
                        ),
                        const SizedBox(height: 10,),
                        ListTile(
                          leading: GestureDetector(
                            onTap: (){
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now()
                              ).then((value){
                                setState(() {
                                  _dateTime=value;
                                if(_dateTime!=null) {
                                  DOB.text = " ${_dateTime!.year}  /  ${_dateTime!.month}  /  ${_dateTime!.day}";
                                }
                                  });
                              });
                            },
                            child: const FaIcon(
                                FontAwesomeIcons.calendar
                            ),
                          ),
                          horizontalTitleGap: 0.0,
                          title: TextFormField(
                            textAlign: TextAlign.center,
                            controller: DOB,
                            validator: (val)=>val!.isEmpty ? "Enter Your Date of Birth" : null,
                            onChanged: (val){
                              setState(() {
                            //    DOB.text=val;
                              });
                            },
                            decoration: InputDecoration(
                              label: const Text("Date of Birth"),
                              hintText: "Enter Date of Birth",
                              filled: true,
                              fillColor: Colors.white70,
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

                            style: const TextStyle(),
                          ),
                        ),
                        const SizedBox( height: 10,),
                        TextFormField(
                          maxLines: 8,
                          controller: Bio,
                          onChanged: (val){
                            setState(() {
                            //  Bio.text=val;
                            });
                          },
                          decoration: InputDecoration(
                            label: const Text(
                              "Bio",
                              textAlign: TextAlign.start,
                            ),
                            floatingLabelAlignment: FloatingLabelAlignment.start,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Write Something about yourself",
                            filled: true,
                            fillColor: Colors.white70,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.redAccent
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),

                            ),
                          ),

                          style: const TextStyle(),
                        ),
                        const SizedBox(height: 20,),
                        Center(
                          child: ElevatedButton(
                              onPressed: ()async{
                                if(!widget.drawer){
                                String ress= await FirestoreMethods().EditProfile(widget.snap['uid'], Fname.text, username.text, DOB.text, Bio.text, gender.text, image, widget.snap['profilepic']);
                              Showsnackbar(ress, context);
                                }else{
                                  String ress= await FirestoreMethods().EditProfile(widget.user1!.UID!, Fname.text, username.text, DOB.text, Bio.text, gender.text, image, widget.user1!.ppurl!);
                                  Showsnackbar(ress, context);
                                }
                                },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left:32.0,
                                  right: 32.0
                                ),
                                child: Text(
                                    "Save",
                                  style: TextStyle(
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                              ),
                            style: ElevatedButton.styleFrom(
                                elevation: 6.0,
                                shadowColor: Colors.black,
                                primary: Colors.white,
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
                        const SizedBox(height: 20,),
                      ],
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}








