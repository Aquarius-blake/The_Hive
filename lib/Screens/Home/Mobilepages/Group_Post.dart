// ignore: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

//TODO: implement theme for dialog options
class GrPost extends StatefulWidget {
  final snap;
  const GrPost({ Key? key,this.snap }) : super(key: key);

  @override
  State<GrPost> createState() => _GrPostState();
}

class _GrPostState extends State<GrPost> {
  dynamic _image;
  Upload Selection=Upload();
  bool _isloading=false;
  TextEditingController _textEditingController=TextEditingController();
  TextEditingController _textEditingController2=TextEditingController();


 _selectimage(BuildContext context)async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: Text("Add Picture"),
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
        backgroundColor: Colors.transparent,   
      )
       : CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(user1.ppurl!),
        backgroundColor: Colors.transparent,
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
        late  User1 user1=  Provider.of<UserProvider>(context).getUser;
        late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    return Scaffold(
      backgroundColor:Color(themedata.ScaffoldbackColor) ,
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Color(themedata.AppbarbackColor),
        iconTheme: IconThemeData(
          color: Color(themedata.AppbariconColor),
        ),
        title:  Text(
          "Create Colony Post",
          style: TextStyle(
            color:Color(themedata.AppbartextColor),
          ),
          ),
      ),
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
                          const SizedBox(width: 15,),
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
                          style:  TextStyle(
                            color:Color(themedata.CardTextColor)
                          ),
                        ),
                        SingleChildScrollView(
                          child: TextField(
                            controller: _textEditingController2,
                            maxLines: 8,
                            decoration: InputDecoration(
                              hintText: "Write Something.....",
                        hintStyle: TextStyle(
                          color:Color(themedata.CardTextColor)
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
                            style:  TextStyle(
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
                              icon:  Icon(
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
        onPressed: ()async{
          String ress= await FirestoreMethods().GroupPost(
            widget.snap["Group Uid"],
             user1.UID!,
              _textEditingController.text,
               _textEditingController2.text,
                _image,
                 user1.Username!,
                 user1.ppurl!);
                 Showsnackbar(ress, context);
                  setState(() {
          _isloading=false;
          _textEditingController.text="";
          _textEditingController2.text="";
          _image=null;
                            });
        },
        child: const FaIcon(
          FontAwesomeIcons.featherPointed,
        ),
      ),
    );
  }
}