


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forum3/Models/Users1.dart';
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

  void Navitap(int page){
    pageController.jumpToPage(page);
  }
void pagechange(int page){
    setState(() {
      _page=page;
    });
}

  @override
  Widget build(BuildContext context) {
    // try{
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 2.0,
        title: Row(
          children: <Widget>[
            Text(
              "Homepage",
              style: TextStyle(

              ),
            )
          ],
        ),

      ),
      drawer: Drawer(
        backgroundColor: Colors.white70,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                DrawerHeader(
                    child: Column(
                      children: <Widget>[
                        Stack(
                            children:[
                              image!=null? CircleAvatar(
                                radius: 60.0,
                                backgroundImage: MemoryImage(image),
                              ):CircleAvatar(
                                radius: 60.0,
                                backgroundImage: AssetImage('Assets/hac.jpg'),
                              ),
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
                        Center(

                          child: Text(user1.Username!),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 10,),
                ListTile(
                  leading: Icon(Icons.person,
                    color: Colors.black, size:50.0,),
                  title: Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,

                    ),

                  ),
                  onTap: () async{
                    Navigator.pushNamed(context, '/Profile');
                  },
                ),
                SizedBox(height: 40,),
                ListTile(
                  leading: Icon(LineIcons.alternateSignOut,
                    color: Colors.black, size:50.0,),
                  title: Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 18.0,
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
          Text("Home"),
          Text("Home"),
          Text("Home"),
          Text("Home"),
          Text("Home")

        ],
        controller: pageController,
        onPageChanged: pagechange,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Text("+"),
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
