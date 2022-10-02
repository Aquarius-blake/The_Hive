import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Screens/Home/Mobilepages/GMember_list.dart';
import 'package:forum3/Screens/Home/Mobilepages/Group_Post.dart';
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
  final Upload Selection=Upload();


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
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white
          ),
          title: Text(
            "${widget.snap['Group Name']}",
            style:const TextStyle(
              color:Colors.white
            ),
            ),
            actions: [
              IconButton(
                onPressed: (){},
                icon: const FaIcon(
                  FontAwesomeIcons.message
                  ),
                ),
            ],
      ),
      body:Scrollbar(
        isAlwaysShown: true,
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
                            color: widget.snap['author uid']==user1.UID && widget.snap['Header']==""? Colors.white:Colors.transparent,
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
                    icon: const FaIcon(
                      FontAwesomeIcons.pencil,
                      color: Colors.white,
                      ),
                      color:Colors.transparent
                    ):Container(),
                   const SizedBox(
                    width: 10,
                    ),
                  widget.snap['Members'].contains(user1.UID)?ElevatedButton(
                    onPressed: (){}, 
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
                    ):
                  ElevatedButton(
                    onPressed: (){}, 
                    child: const Text(
                      "Join Group",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 20,
                        ),
                      ),
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
                ],
              ),
              Divider(),
              RichText(text: TextSpan(
                text: "About",
                style: const TextStyle(
                  color: Colors.white,
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
                     const TextSpan(
                        text: "Description: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      TextSpan(
                        text: "${widget.snap['Group Description']}",
                        style: const TextStyle(
                          color: Colors.white,
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
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            TextSpan(
                              text: "${widget.snap['Members'].length}",
                              style: const TextStyle(
                                color: Colors.white,
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
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          TextSpan(
                            text: "${widget.snap['noP']}",
                            style: const TextStyle(
                              color: Colors.white,
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
            Showsnackbar("Access Denied, please join group", context);
          }
        },
      child: const FaIcon(
        FontAwesomeIcons.featherPointed,
        color: Colors.white,
        ),
      ),
    );
  }
}