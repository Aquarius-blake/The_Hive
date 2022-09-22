import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Screens/Home/Mobilepages/Meditprofile.dart';
import 'package:forum3/Screens/Home/Mobilepages/Mliked_post.dart';
import 'package:forum3/Screens/Home/Mobilepages/MppchatScreen.dart';
import 'package:forum3/Screens/Home/Mobilepages/Profile_post.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';
import '../../../shared/Pop_up.dart';



class Mprofile extends StatefulWidget {
  final snap;
  const Mprofile({Key? key,this.snap}) : super(key: key);

  @override
  State<Mprofile> createState() => _MprofileState();
}

class _MprofileState extends State<Mprofile>with
    TickerProviderStateMixin {
  late TabController _tabController;
  int postlen=0;
  getPostlen()async{
    try{
      QuerySnapshot snapshot=await FirebaseFirestore.instance.collection("Posts").where('author uid' ,isEqualTo: widget.snap['uid']).get();
      setState(() {
        postlen=snapshot.docs.length;
      });    }
    catch(e){
      Showsnackbar(e.toString(), context);
    }
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController( vsync:this, length: 2);
    getPostlen();
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.snap['profilepic']),
                      radius: 50,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "$postlen",
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            const Text(
                              "Posts",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        widget.snap['Admin']==true && user1.Admin==true ?ElevatedButton(
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
                            onPressed: ()async{
                              String content= await FirestoreMethods().RemoveAdmin(widget.snap['uid']);
                              Showsnackbar(content, context);
                            },
                            child:Text(
                              "Remove Admin",
                            style: TextStyle(
                                color: Colors.lightBlueAccent
                            ),
                            )
                        ):SizedBox(),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            widget.snap['uid']!=user1.UID? ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context)=>MpchatScreen(
                                        snap: widget.snap,
                                      ),
                                    )
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0),
                                child: Text(
                                  "Message",
                                  style: TextStyle(
                                      color: Colors.lightBlueAccent
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
                            ):ElevatedButton(
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
                              onPressed: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context)=>Medprofile(
                                        snap: widget.snap,
                                        drawer: false,
                                      ),
                                    )
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  left:18.0,
                                  right: 18.0,
                                ),
                                child: Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      color: Colors.lightBlueAccent
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15.0,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.snap['username'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                ),
                Row(
                    children:[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Name: ${widget.snap['Full Name']}",
                          style: TextStyle(
                              color: Colors.grey
                          ),
                        ),
                      ),
                      const Expanded(
                          child: SizedBox()
                      ),
                      widget.snap['Gender']==null|| widget.snap['Gender']==""? const SizedBox(): Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Gender: ${widget.snap['Gender']}",
                          style: const TextStyle(
                              color: Colors.grey
                          ),
                        ),
                      ),

                      SizedBox(width: 80,)
                    ]
                ),
                widget.snap['Bio']==null|| widget.snap['Bio']==""? const SizedBox(): Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Bio: ${widget.snap['Bio']}",
                    style: const TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: widget.snap['DateofBirth']==null || widget.snap['DateofBirth']==""? const SizedBox()
                      : Text("Date of Birth: ${widget.snap['DateofBirth']}",
                    style: const TextStyle(
                        color: Colors.grey
                    ),),
                ),
                const Divider(
                  height: 40,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      labelColor: Colors.lightBlueAccent,
                        labelPadding: const EdgeInsets.only(
                          left: 80,
                          right: 35
                        ),
                        isScrollable: true,
                        unselectedLabelColor: Colors.black,
                        controller: _tabController,
                        tabs: [
                          Tab(text: "Posts",),
                          Tab(text: "Likes",)
                        ]
                    ),
                  ),
                ),
                Container(
                  width:double.maxFinite ,
                  height: 300,
                  child: TabBarView(
                      controller: _tabController,
                      children: [
                        Profilepost(
                          snap: widget.snap,
                        ),
                        Likedposts(
                          snap: widget.snap,
                        )
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}











