import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:forum3/shared/error_handling.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController _textEditingController2=TextEditingController();
  bool _isloading=false;


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


  _selectimage(BuildContext context)async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: Text("Create Post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
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
                padding:const EdgeInsets.all(15.0),
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
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _textEditingController2.dispose();


  }

  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _isloading? const LinearProgressIndicator():Container(),
               const SizedBox(height: 10,),
                Card(
                  color:Color(themedata.CardBackgroundColor),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Avatar(user1),
                            SizedBox(width: 15,),
                            Text(
                              user1.Username!,
                              style: TextStyle(
                                color:Color(themedata.CardTextColor)
                              ),
                              ),
                          ],
                        ),
                       const SizedBox(height: 15,),
                        TextField(
                          controller: _textEditingController,
                          decoration:  InputDecoration(
                            hintText: "Title",
                            label: Text(
                              "Title",
                              style: TextStyle(
                                color: Color(themedata.CardTextColor)
                              ),
                              ),
                          ),
                          style: TextStyle(
                            color:Color(themedata.CardTextColor)
                          ),
                        ),
                        SingleChildScrollView(
                          child: TextField(
                            controller: _textEditingController2,
                            maxLines: 8,
                            decoration:  InputDecoration(
                              hintText: "Write Something.....",
                        hintStyle:const TextStyle(
                          color:Colors.grey
                        ),
                              border: InputBorder.none,
                              label:Text("Details",
                                style: TextStyle(
                                  color: Color(themedata.CardTextColor)
                                ),
                                ),
                                floatingLabelAlignment: FloatingLabelAlignment.start,
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                            style: TextStyle(
                              color:Color(themedata.CardTextColor),
                            ),
                          ),
                        ),
                        Post(),
                        Divider(
                          color:Color(themedata.DividerColor!)
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: ()=>_selectimage(context),
                              icon:  Icon(
                                Icons.add_a_photo,
                                color:Color(themedata.CardIconColor)
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  _image=null;
                                });
                              },
                              icon: Icon(
                                FontAwesomeIcons.xmark,
                                color:Color(themedata.CardIconColor)
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
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_posting(user1.UID!,user1.Username!,user1.ppurl),
        child: const FaIcon(
          FontAwesomeIcons.featherPointed,
        ),
      ),
    );
  }
}













