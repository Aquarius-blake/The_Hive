
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Screens/Platforms/WebSceens/Whome.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../Models/Users1.dart';
import '../../Services/Firestoremethods.dart';
import '../../Services/auth.dart';
import '../../shared/Pop_up.dart';
import '../../shared/error_handling.dart';



class Webview extends StatefulWidget {
  const Webview({Key? key}) : super(key: key);

  @override
  State<Webview> createState() => _WebviewState();
}
final  AuthService _auth=AuthService();
String username="";



class _WebviewState extends State<Webview> {

  int _page=0;
  int page=0;
  late PageController pageController;
  String title="home";
  dynamic _image;
  bool _isloading=false;
  final TextEditingController _textEditingController=TextEditingController();
  final TextEditingController _textEditingController2=TextEditingController();

  Upload Selection=Upload();

  void _posting(String uid,String author,dynamic profilepic)async{
    setState(() {
      _isloading=true;
    });
    try{
      String res=await FirestoreMethods().Uploadpost(_textEditingController.text, _textEditingController2.text, _image, uid, author, profilepic);
      if(res=="success"){
        setState(() {
          _isloading=false;
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

  _selectimage()async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: Text("Upload image"),
            children: [
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

            ],
          );
        }
    );
    }

    Widget Post(dynamic image){
    return image==null?SizedBox():SizedBox(
      width: MediaQuery.of(context).size.width*0.3,
      child: Image.memory(image),
    );
    }

  @override
  void initState() {
    // initial();
    pageController=PageController();
    super.initState();
  }

  void initial()async{
    /* DocumentSnapshot snap= await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username=(snap.data() as Map<String,dynamic>)['username'];
    });*/
    UserProvider _userprovider=Provider.of(context,listen: false);
    await _userprovider.Refreshuser();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }




  void Navitap(int page){
    pageController.jumpToPage(page);
  }
  void pagechange(int page){
    setState(() {
      _page=page;
      if(_page==0){
        title="homepage";
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

  void nav(){
    Navitap(page);
  }


  @override
  Widget build(BuildContext context) {
    User1? user1=  Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Web"),
        actions: [
          ElevatedButton(
            onPressed: ()async{
              await _auth.SignOut();
            },
            child: Text("Sign Out"),
          ),
          /*ListTile(
            leading: Icon(LineIcons.alternateSignOut),
            title: Text("Sign Out"),
            onTap: (){},
          ),*/
        ],
      ),
      body: SafeArea(
          child: Container(
            padding:const EdgeInsets.all(10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Card(
                        elevation: 15.0,
                        color: Colors.white,
                        shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50,50,50,50),
                          child: Column(

                            children: <Widget>[
                              Stack(
                                  children:<Widget>[
                                    CircleAvatar(
                                      radius: 50.0,
                                      backgroundImage: NetworkImage(user1.ppurl!),
                                    ),
                                    Positioned(
                                      bottom: -5,
                                      left: 65,
                                      child: IconButton(
                                          onPressed:() {

                                          },
                                          icon:Icon(
                                            Icons.add_a_photo,
                                            color: Colors.lightBlueAccent,
                                          )
                                      ),
                                    )
                                  ]
                              ),
                              SizedBox(height: 10,),
                              user1.Username!=null? Text(
                                user1.Username!,
                                style: TextStyle(

                                ),
                              ):
                              Text("Loading"),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        page=0;
                                      });
                                      Navitap(page);
                                    },
                                    icon: Icon(Icons.home),
                                    iconSize: 40.0,

                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        page=1;
                                      });
                                      Navitap(page);
                                    },
                                    child: Text("Home",
                                      style: TextStyle(
                                        fontSize: 19.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        page=1;
                                      });
                                      Navitap(page);
                                    },
                                    icon: Icon(Icons.person),
                                    iconSize: 40.0,

                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        page=1;
                                      });
                                      Navitap(page);
                                    },
                                    child: Text("Profile",
                                      style: TextStyle(
                                        fontSize: 19.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: (){

                                      setState(() {
                                        page=2;
                                      });
                                      Navitap(page);
                                    },
                                    icon: Icon(Icons.mail_outline),
                                    iconSize: 40.0,

                                  ),

                                  GestureDetector(
                                    onTap: (){

                                      setState(() {
                                        page=2;
                                      });
                                      Navitap(page);
                                    },
                                    child: Text("Messages",
                                      style: TextStyle(
                                        fontSize: 19.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: (){

                                      setState(() {
                                        page=3;
                                      });
                                      Navitap(page);
                                    },
                                    icon: Icon(Icons.search),
                                    iconSize: 40.0,

                                  ),

                                  GestureDetector(
                                    onTap: (){

                                      setState(() {
                                        page=3;
                                      });
                                      Navitap(page);
                                    },
                                    child: Text("Search",
                                      style: TextStyle(
                                        fontSize: 19.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 30,),
                              TextButton(
                                  onPressed: (){},
                                  child: Text("Create New Account",
                                    style: TextStyle(

                                    ),)
                              )

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: SingleChildScrollView(
                      controller: ScrollController(
                        initialScrollOffset:10,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            child: _isloading?CircularProgressIndicator(): Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.lightBlueAccent,
                                          backgroundImage: NetworkImage(user1.ppurl!),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(
                                          user1.Username!,
                                          style: TextStyle(
                                          fontSize: 19,
                                          ),
                                        )
                                        ,
                                      ],
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width*0.4,
                                        child: TextField(
                                          controller: _textEditingController,
                                          decoration: InputDecoration(
                                            hintText:"Title",
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Center(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width*0.4,
                                        child: TextField(
                                          controller: _textEditingController2,
                                          maxLines: 4,
                                          decoration: InputDecoration(
                                            hintText:"Write Something........",
                                           // border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Post(_image),
                                    SizedBox(height: 20,),
                                    Divider(
                                      height: 20,
                                      thickness: 2,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: ()=>_selectimage(),
                                            icon: Icon(Icons.add_a_photo)
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                            child: SizedBox()
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: ElevatedButton(
                                              onPressed: ()=>_posting(user1.UID!, user1.Username!, user1.ppurl),
                                              child: Text("Post"),
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                shadowColor: Colors.black,
                                                primary: Colors.blue[400],
                                                side: BorderSide(
                                                  color: Colors.white70,
                                                  width: 2.0,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(100.0)
                                                )
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(

                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: PageView(
                                children: [
                                  WebHome(),
                                //  Text(""),
                                  Text("Page2"),
                                  Text("Page3"),
                                  Text("Page4")
                                ],

                                physics:const  ScrollPhysics(
                                  parent: NeverScrollableScrollPhysics(),
                                ),
                                controller: pageController,
                                onPageChanged: pagechange,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Card(
                        child: Column(

                          children: <Widget>[
                            SizedBox(width: 300,),
                            Text("dgdfgd")
                          ],
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          )
      ),
    );
  }
}
