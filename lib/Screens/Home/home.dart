


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Screens/Forum/Dynamiclink_page.dart';
import 'package:forum3/Screens/Home/Mobilepages/Group_page.dart';
import 'package:forum3/Screens/Home/Mobilepages/Group_search.dart';
import 'package:forum3/Screens/Home/Mobilepages/MDprofile.dart';
import 'package:forum3/Screens/Home/Mobilepages/MPost.dart';
import 'package:forum3/Screens/Home/Mobilepages/MSettings_oage.dart';
import 'package:forum3/Screens/Home/Mobilepages/Mhome.dart';
import 'package:forum3/Screens/Home/Mobilepages/Mmessages.dart';
import 'package:forum3/Screens/Home/Mobilepages/Mnotifications.dart';
import 'package:forum3/Screens/Home/Mobilepages/Mrequest_page.dart';
import 'package:forum3/Screens/Home/Mobilepages/Msearch.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/Services/Storagemethods.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:forum3/shared/Networkconnection.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import '../../Provider/user_provider.dart';
import '../../Services/auth.dart';

//Home Screen
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
  
 void initiateDynamiclink()async{
    FirebaseDynamicLinks.instance.onLink.listen(
       (PendingDynamicLinkData? dynamicLink)async{
        final Uri? deeplink= dynamicLink!.link;

        if(deeplink!=null){
          handlemylink(deeplink);
        }
      },
      onError: (e)async{
        print(e.toString());
      }
    );
  }
  
  void handlemylink(Uri url){
    List<String> seperatedlink=[];
    seperatedlink.addAll(url.path.split('/'));
    Get.to(()=>dynamicHandler(
      postid: seperatedlink[1],
    ));
    print ("The Token that i'm interesed in is ${seperatedlink[1]}");
}
  
  void pic()async{
    image= await _upload.uploadpic(ImageSource.gallery);
    User? result=await FirebaseAuth.instance.currentUser;
    User1? currentUser =await _auth.fbuser(result);

    String photourl= await  store.Storageip("Profilepic", image, false,null);
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
  late String appName;
  late String packageName;
  late String version;
  late String buildNumber;

  void getappinfo()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  void initState() {
    //  initial();
    pageController=PageController();
    super.initState();
    initiateDynamiclink();
    getappinfo();
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
     ): user1.ppurl==""? const CircleAvatar(
      radius:50,
      backgroundImage: AssetImage('Assets/hac.jpg'),
      backgroundColor: Colors.transparent,
     ) 
     : CircleAvatar(
       backgroundImage: NetworkImage(user1.ppurl!),
       radius: 50,
     );
    }
    catch(e){
    return const CircleAvatar(
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
     try{
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    
   
    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Color(themedata.AppbariconColor)
        ),
        backgroundColor: Color(themedata.AppbarbackColor),
        shadowColor: Color(themedata.AppbarShadowColor),
        elevation: 2.0,
        title: Container(
          padding: const EdgeInsets.only(
            right: 40
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style:  TextStyle(
                            color: Color(themedata.AppbartextColor),
                ),
              )
            ],
          ),
        ),
      ),

      drawer: Drawer(
        backgroundColor: Color(themedata.ScaffoldbackColor),
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
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: Color(themedata.DrawerIconColor!),
                                    )
                                ),
                              )
                            ]
                        ),
                        const SizedBox(height: 10,),
                        Center(
                          child: Text(
                            user1.Username!,
                            style:  TextStyle(
                              fontSize: 16,
                              color: Color(themedata.DrawerTextColor!),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading:  Icon(
                    Icons.person,
                    color: Color(themedata.DrawerIconColor!),
                    size:35.0,
                  ),
                  title:  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color:Color(themedata.DrawerTextColor!),
                    ),
                  ),
                  onTap: () async{
                     Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context)=>MDprofile(),
                      )
                  );
                  },
                ),
                const SizedBox(height: 15,),
                ListTile(
                  leading:  Transform.flip(
                    flipX: true,
                    child: Icon(
                      Icons.directions_walk,
                      color: Color(themedata.DrawerIconColor!),
                      size:35.0,
                      ),
                  ),
                  title:  Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color:Color(themedata.DrawerTextColor!),
                    ),
                  ),
                  onTap: () async{
                  await _auth.SignOut(user1.Guest!,user1.UID!);
                  },
                ),
               const SizedBox(
                height: 5.0,
                ),
                ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.peopleGroup,
                    color: Color(themedata.DrawerIconColor!),
                    size:35.0,
                    ),
                    title:  Text(
                      "My Colonies",
                      style:TextStyle(
                        color: Color(themedata.DrawerTextColor!),
                        fontSize: 22.0,
                      )
                      ),
                    onTap: ()async{
                      Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context)=>GroupPage(),
            )
        );
                    },
                ),
               const SizedBox(height: 5.0,),
                ListTile(
                  leading:  FaIcon(
                    FontAwesomeIcons.userGroup,
                    color: Color(themedata.DrawerIconColor!),
                    size:35.0,
                    ),
                    title:  Text(
                      "Search Colonies",
                      style:TextStyle(
                        color: Color(themedata.DrawerTextColor!),
                        fontSize: 22.0,
                      )
                      ),
                    onTap: ()async{
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context)=>Groupsearch(),
                        )
                      );
                    },
                ),
               const SizedBox(
                height: 5.0,
                ),
                ListTile(
                  leading:  FaIcon(
                    FontAwesomeIcons.gears,
                    color: Color(themedata.DrawerIconColor!),
                    size:35.0,
                    ),
                    title:  Text(
                      "Settings",
                      style:TextStyle(
                        color: Color(themedata.DrawerTextColor!),
                        fontSize: 22.0,
                      )
                      ),
                    onTap: ()async{
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context)=>MSettings(),
                        )
                      );
                    },
                ),
              const  SizedBox(
                height: 5.0,
                ),
                ListTile(
                  title:  Text(
                    "Create New Account",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 16.0,
                      color:Color(themedata.DrawerTextbuttonColor!),
                    ),
                  ),
                  onTap: ()async{
                    Navigator.pushNamed(context, '/register');
                  },
                ),
               const SizedBox(height: 8.0,),
               user1.Admin==true?  ListTile(
             title:  Text(
                 "View Requests",
             style:  TextStyle(
               fontStyle: FontStyle.italic,
               color: Color(themedata.DrawerTextbuttonColor!),
                fontSize: 16.0,
             ),
             ),
             onTap: (){
               Navigator.of(context).push(
                   MaterialPageRoute(
                     builder: (context)=>Request_page(),
                   )
               );
             },
           ):
           ListTile(
             title:  Text(
               "Request Admin Privileges",
               style: TextStyle(
                 fontStyle: FontStyle.italic,
                 color: Color(themedata.DrawerTextbuttonColor!),
                 fontSize: 16.0,
               ),
             ),
             onTap: ()async{
               if(user1.Guest!=true){
                String content= await FirestoreMethods().Makerequest(user1.Username!, user1.UID!, user1.ppurl!);
               Showsnackbar(content, context);
               }else{
                 Showsnackbar("Sorry, Guests can't make requests", context);
               }
             },
           ),
             const SizedBox(height: 100.0,),
                Divider(
                  height: 40,
                  color: Color(themedata.DividerColor!),
                  thickness: 3,
                ),
                 Center(
                  child: Text(
                    "POWERED by Firebase",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color:Color(themedata.DrawerTextColor!),
                    ),
                  ),
                ),
                const  SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "v"+version+" ",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color:Color(themedata.DrawerTextColor!),
                    ),
                  ),
                ),
                const  SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      
      body: PageView(
        children: [
          Mhome(),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0
            ),
            child: Msearch(),
          ),
          Mpost(),
          Notifications(uid: user1.UID,),
          Mmessages()
        ],
        controller: pageController,
        onPageChanged: pagechange,
      ),

      bottomNavigationBar: CupertinoTabBar(
        backgroundColor:Color(themedata.BottomNavBackColor),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page==0? Colors.lightBlueAccent:Color(themedata.BottomNavIconColor),
            ),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
              color: _page==1? Colors.lightBlueAccent:Color(themedata.BottomNavIconColor),
            ),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,
              color: _page==2? Colors.lightBlueAccent:Color(themedata.BottomNavIconColor),
            ),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.bell,
              color: _page==3? Colors.lightBlueAccent:Color(themedata.BottomNavIconColor),
            ),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline,
              color: _page==4? Colors.lightBlueAccent:Color(themedata.BottomNavIconColor),
            ),
            label: '',
            backgroundColor: Colors.transparent,
          ),
        ],
        onTap: Navitap,
      ),
    );
      }catch(e){
        print(e.toString());
      return Netcon();
    }
  }
}
