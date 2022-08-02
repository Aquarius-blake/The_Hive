


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Screens/Home/Mobilepages/MPost.dart';
import 'package:forum3/Screens/Home/Mobilepages/Mhome.dart';
import 'package:forum3/Screens/Home/Mobilepages/Mmessages.dart';
import 'package:forum3/Screens/Home/Mobilepages/Mnotifications.dart';
import 'package:forum3/Screens/Home/Mobilepages/Msearch.dart';
import 'package:forum3/Services/Storagemethods.dart';
import 'package:forum3/Services/Upload.dart';
//import 'package:forum3/shared/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../../Provider/user_provider.dart';
import '../../Services/auth.dart';

//Home Screen
class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final  AuthService _auth=AuthService();
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final StorageMethods store=StorageMethods();


  final Upload _upload=Upload();
  final User1? u2=User1();
  dynamic image;
  void pic()async{
    image= await _upload.uploadpic(ImageSource.gallery);
    User? result=await FirebaseAuth.instance.currentUser;
    User1? currentUser =await _auth.fbuser(result);

    String photourl= await  store.Storageip("Profilepic", image, false);
    currentUser?.ppurl=photourl;

    await  _firestore.collection("users").doc(currentUser!.UID).set(
        currentUser.toJson(),
        SetOptions(merge: true)
    );
    setState(() {

    });
  }
  int _page=0;
  late PageController pageController;
  String title="Home";

  @override
  void initState() {
    //  initial();
    pageController=PageController();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void initial()async{
    UserProvider _userprovider=Provider.of(context,listen: false);
    await _userprovider.Refreshuser();
  }


  Widget Avatar(dynamic image,User1 user1){
    try{
     return image!=null?  CircleAvatar(
       radius: 50,
       backgroundImage: MemoryImage(image),
     ): CircleAvatar(
       backgroundImage: NetworkImage(user1.ppurl!),
       radius: 50,
     );
    }
    catch(e){
    return CircleAvatar(
      backgroundImage: AssetImage('Assets/hac.jpg'),
      radius: 50,
    );
    }
  }

  void Navitap(int page){
    pageController.jumpToPage(page);
  }
  void pagechange(int page){
    setState(() {
      _page=page;
      if(_page==0){
        title="Home";
      }
      else if(_page==1){
        title="Search";
      }
      else if(_page==2){
        title="Post";
      }
      else if(_page==3){
        title="Notifications";
      }
      else if(_page==4){
        title="Messages";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    // try{
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 2.0,
        title: Container(
          padding: EdgeInsets.only(
            right: 40
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "$title",
                style: TextStyle(
                            color: Colors.black
                ),
              )
            ],
          ),
        ),
      ),

      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                DrawerHeader(
                    child: Column(
                      children: <Widget>[
                        Stack(
                            children:[
                              /*image!=null? CircleAvatar(
                                radius: 60.0,
                                backgroundImage: MemoryImage(image),
                              ):CircleAvatar(
                                radius: 60.0,
                                backgroundImage: AssetImage('Assets/hac.jpg'),
                              ),*/
                              Avatar(image, user1),
                              Positioned(
                                bottom: -5,
                                left: 65,
                                child: IconButton(
                                    onPressed:() {
                                      pic();
                                    },
                                    icon:Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                    )
                                ),
                              )
                            ]
                        ),
                        SizedBox(height: 10,),
                        Center(

                          child: Text(
                            user1.Username!,
                            style: TextStyle(
                              fontSize: 16,

                            ),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 10,),
                ListTile(
                  leading: const Icon(Icons.person,
                    color: Colors.black,
                    size:20.0,
                  ),
                  title: const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,

                    ),

                  ),
                  onTap: () async{
                    Navigator.pushNamed(context, '/Profile');
                  },
                ),
                SizedBox(height: 10,),
                ListTile(
                  leading: const Icon(LineIcons.alternateSignOut,
                    color: Colors.black,
                    size:30.0,),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,

                    ),

                  ),
                  onTap: () async{
                    await _auth.SignOut();
                  },
                ),
                SizedBox(height: 5.0,),
                ListTile(
                  title: Text(
                    "Create New Account",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12.0,
                    ),
                  ),
                  onTap: ()async{
                    Navigator.pushNamed(context, '/register');
                  },
                ),
                SizedBox(height: 20.0,),
                Divider(
                  height: 40,
                  color: Colors.black,
                  thickness: 3,
                ),
                Center(
                  child: Text(
                    "POWERED by Firebase",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,

                    ),
                  ),
                )

              ],
            ),
          ),
        ),

      ),
      body: PageView(
        children: [
          Mhome(),
          Msearch(),
          Mpost(),
          Notifications(),
          Mmessages()
        ],
        controller: pageController,
        onPageChanged: pagechange,
      ),

      bottomNavigationBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page==0? Colors.lightBlueAccent:Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
              color: _page==1? Colors.lightBlueAccent:Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,
              color: _page==2? Colors.lightBlueAccent:Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.bell,
              color: _page==3? Colors.lightBlueAccent:Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline,
              color: _page==4? Colors.lightBlueAccent:Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
        ],
        onTap: Navitap,
      ),
    );
    //  }catch(e){
    //    return Loading();
    //  }
  }
}
