import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Screens/Home/Mobilepages/GMember_list.dart';
import 'package:forum3/Screens/Home/Mobilepages/Group_Post.dart';
import 'package:forum3/Screens/Home/Mobilepages/Group_chat.dart';
import 'package:forum3/Screens/Home/Mobilepages/Group_edit.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:forum3/shared/Widgets/Gpostcard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';


class Ghome extends StatefulWidget {
  final snap;
  Ghome({Key? key,this.snap}) : super(key: key);

  @override
  State<Ghome> createState() => _GhomeState();
}

class _GhomeState extends State<Ghome> {
dynamic image;
late bool memstate;
  final Upload Selection=Upload();

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  setState(() {
    
  });
}

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
        late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Color(themedata.AppbarbackColor),
        iconTheme: IconThemeData(
          color: Color(themedata.AppbariconColor)
          ),
          title: Text(
            "${widget.snap['Group Name']}",
            style: TextStyle(
              color:Color(themedata.AppbartextColor)
            ),
            ),
            actions: [
              IconButton(
                onPressed: (){
                  if(widget.snap['Members'].contains(user1.UID)==true){
            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context)=>Gchatscreen(
                                  snap: widget.snap,
                                  groupid: widget.snap['Group Uid'],
                                ),
                              )
                          );
          }else{
            Showsnackbar("Access Denied, please join colony first", context);
          }
                },
                icon: const FaIcon(
                  FontAwesomeIcons.message
                  ),
                ),
            ],
      ),
      body:Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
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
                            color: widget.snap['author uid']==user1.UID && widget.snap['Header']==""? Color(themedata.ScaffoldbuttonIconColor):Colors.transparent,
                            ),
                          ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: -50,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.lightBlueAccent,
                          backgroundImage: NetworkImage(widget.snap['Group Pic']),
                          ),
                        ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.snap['author uid']==user1.UID? IconButton(
                    onPressed: ()async{
                          Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context)=>Gedit(
                                    snap: widget.snap,
                                  ),
                                )
                            );
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.pencil,
                      color: Color(themedata.ScaffoldbuttonIconColor),
                      ),
                      color:Colors.transparent
                    ):Container(),
                   const SizedBox(
                    width: 10,
                    ),
                  widget.snap['Members'].contains(user1.UID)?ElevatedButton(
                    onPressed: ()async{
                     String content=await FirestoreMethods().Leavegroup(widget.snap['Group Uid'], user1);
                      Showsnackbar(content, context);
                      Navigator.of(context).pop();
                    }, 
                    child: Row(
                      children:const [
                        Text(
                          "Joined",
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 20,
                            ),
                          ),
                        SizedBox(width: 10,),
                        FaIcon(
                          FontAwesomeIcons.check,
                          color: Colors.lightBlueAccent,
                        )
                      ],
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
                    ):
                  ElevatedButton(
                    onPressed: ()async{
                      if(user1.Guest!=true){
                    String content= await FirestoreMethods().JoinGroup(widget.snap['Group Uid'], user1);
                    Showsnackbar(content, context);
                    setState(() {});
                      }else{
                      Showsnackbar("Please Sign in to continue", context);
                    }
                    }, 
                    child: const Text(
                      "Join Colony",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 20,
                        ),
                      ),
                    style: ElevatedButton.styleFrom(
                                      elevation: 6.0,
                                      shadowColor: Colors.black,
                                      backgroundColor: Colors.transparent,
                                      side: const BorderSide(
                                        color: Colors.blue,
                                       width: 2.0,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100.0)
                                      )
                                  ),
                    ),
                ],
              ),
              Divider(
                color: Color(themedata.DividerColor!),
              ),
              RichText(
                text: TextSpan(
                text: "About",
                style:  TextStyle(
                  color: Color(themedata.ScaffoldtextColor),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: " ${widget.snap['Group Name']}",
                    style: const TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ]
              )
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(
                  left:10.0,
                  right: 5.0
                  ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Description: ",
                        style: TextStyle(
                          color: Color(themedata.ScaffoldtextColor),
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      TextSpan(
                        text: "${widget.snap['Group Description']}",
                        style:  TextStyle(
                          color: Color(themedata.ScaffoldtextColor),
                          fontSize: 15,
                        ),
                      )
                    ]
                  )
                  ),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(
                  left:10.0,
                  right: 5.0
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context)=>GroupMembers(
                              snap: widget.snap,
                            ),
                          )
                        );
                      
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${widget.snap['Identity']}: ",
                              style: TextStyle(
                                color: Color(themedata.ScaffoldtextColor),
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            TextSpan(
                              text: "${widget.snap['Members'].length}",
                              style:  TextStyle(
                                color: Color(themedata.ScaffoldtextColor),
                                fontSize: 15,
                              ),
                            )
                          ]
                        )
                        ),
                    ),
                       RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${widget.snap['Post Name']}: ",
                            style:  TextStyle(
                              color: Color(themedata.ScaffoldtextColor),
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          TextSpan(
                            text: "${widget.snap['noP']}",
                            style:  TextStyle(
                              color: Color(themedata.ScaffoldtextColor),
                              fontSize: 15,
                            ),
                          )
                        ]
                      )
                      ),    
                  ],
                ),
              ),
             const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height:double.maxFinite,
                child:  StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Groups').doc(widget.snap['Group Uid']).collection("Posts").orderBy("Post Time",descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => Container(
          child: GPostCard(
            snap: snapshot.data!.docs[index].data(),
            Groupid: widget.snap['Group Uid'],
          ),
        ),
        );
        },
        ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(widget.snap['Members'].contains(user1.UID)==true){
            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context)=>GrPost(
                                  snap: widget.snap,
                                ),
                              )
                          );
          }else{
            Showsnackbar("Access Denied, please join group first", context);
          }
        },
      child:  FaIcon(
        FontAwesomeIcons.featherPointed,
        color: Color(themedata.AppbariconColor),
        ),
      ),
    );
  }
}