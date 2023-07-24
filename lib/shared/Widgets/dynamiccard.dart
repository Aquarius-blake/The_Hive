import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Screens/Home/Mobilepages/Mcomments_screen.dart';
import 'package:forum3/Screens/Home/Mobilepages/Meditpost.dart';
import 'package:forum3/Screens/Platforms/WebSceens/Webed.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:forum3/shared/Widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../Models/Users1.dart';
import '../../Provider/user_provider.dart';
import '../../Screens/Platforms/WebSceens/Wcomments_screen.dart';


class dynamicCard extends StatefulWidget {
  final snap;
  const dynamicCard({ Key? key,this.snap}) : super(key: key);

  @override
  State<dynamicCard> createState() => _dynamicCardState();
}


class _dynamicCardState extends State<dynamicCard> {
  bool islikeanimating=false;
  bool liked=false;
  int commentlen=0;


  //Build dynamiclink
  buildDynamicLinks(String title,String image,String docId) async {
    String url = "http://bsocialp.page.link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: url,
      link: Uri.parse('$url/$docId'),
      androidParameters: AndroidParameters(
        packageName: "com.blake.social",
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: "com.blake.social",
        minimumVersion: '0',
        appStoreId: "000000000",
      ),
      
      socialMetaTagParameters: SocialMetaTagParameters(
          description: '',
          imageUrl:
          Uri.parse("$image"),
          title: title),
    );
    final ShortDynamicLink dynamicUrl = await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    String? desc = '${dynamicUrl.shortUrl.toString()}';

    await Share.share(desc, subject: title,);

  }

//more options
  _options(BuildContext context,User1 user1)async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text(
                "More options",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
             user1.Admin==true && widget.snap['author uid']!=user1.UID ?SimpleDialogOption() :SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                    "Edit Post",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                  if(kIsWeb){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context)=>Webed(
                            snap: widget.snap,
                          ),
                        )
                    );
                  }else{
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context)=>Mobeditpost(
                            snap: widget.snap,
                          ),
                        )
                    );
                  }
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                    "Delete",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                  ),
                ),
                onPressed: ()async{
                  String ress=  await FirestoreMethods().Deletepost(widget.snap['Post Uid']);
                  Showsnackbar(ress, context);
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );

  }



  //dynamic _image;
  Widget Postimage(dynamic image,BuildContext context,User1 user1){
    if(image==""){
      setState(() {
        image=null;
      });
    }
    return image!=null? GestureDetector(
      onDoubleTap: ()async{
        await FirestoreMethods().likepost(
            widget.snap['Post Uid'],
            user1.UID!,
            widget.snap['likes'],
            widget.snap['author uid'],
            user1.Username!,
            user1.ppurl!,
            widget.snap['title']
        );
        setState(() {
          islikeanimating=true;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.7,
            child: Image.network(image),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: islikeanimating?1:0,
            child: likeAnimation(
              child: const Icon(
                Icons.favorite,
                color: Colors.redAccent,
                size: 60,
              ),
              isAnimating: islikeanimating,
              duration: const Duration(
                  milliseconds: 400),
              onEnd: (){
                setState(() {
                  islikeanimating=false;
                });
              },
            ),
          )
        ],
      ),
    ):SizedBox();
  }


  getcommentlen()async{
    try{
      QuerySnapshot snapshot=await FirebaseFirestore.instance.collection("Posts").doc(widget.snap['Post Uid']).collection("comments").get();
      setState(() {
        commentlen=snapshot.docs.length;
      });    }
    catch(e){
      Showsnackbar(e.toString(), context);
    }
  }

  void likedf(String authoruid,List list){
    setState(() {
      if(list.contains(authoruid)){
        liked=true;
      }else{liked=false;}
    });
  }
  @override
  void initState() {
    super.initState();
    getcommentlen();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    if(user1.UID==widget.snap['author uid']){
      FirestoreMethods().Updatepostpic(widget.snap['Post Uid'], user1.ppurl!);
      setState(() {});
    }
    String authoruid=user1.UID!;
    List list=widget.snap['likes'];
    likedf(authoruid, list);

    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        left: 10,
        right: 10,
        bottom: 0,
      ),
      child: Card(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                 widget.snap['Profile Pic']==""? const CircleAvatar(
                  radius: 16,
                      backgroundImage: AssetImage('Assets/hac.jpg'),
                      backgroundColor: Colors.transparent,
                 ): CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(widget.snap['Profile Pic']),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                        child: Padding(
                            child:Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.snap['author'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:Colors.black
                                  ),)
                              ],
                            ) ,
                            padding:const EdgeInsets.only(
                                left: 10.0
                            )
                        )
                    ),
                    widget.snap['author uid']==user1.UID || user1.Admin==true ? IconButton(
                      onPressed: ()=>_options(context,user1),
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                    ):const SizedBox()
                  ],
                ),
                Container(
                  padding:const EdgeInsets.only(
                    top: 5,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Text(
                      widget.snap['title'],
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:const EdgeInsets.only(
                    top: 5,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Text(
                      widget.snap['detail'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Postimage(widget.snap['Image Url'], context,user1),
                Container(
                  padding: const EdgeInsets.only(
                    top: 3.0,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child:   Text(
                      DateFormat.yMMMd().format(widget.snap['Post Time'].toDate(),),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                ),
               const Divider(
                color: Colors.black,  
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${widget.snap['likes'].length}",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      likeAnimation(
                        isAnimating: widget.snap['likes'].contains(user1.UID),
                        smallLike: true,
                        child: IconButton(
                            onPressed: ()async{
                              await   FirestoreMethods().likepost(
                                widget.snap['Post Uid'],
                                user1.UID!,
                                widget.snap['likes'],
                                widget.snap['author uid'],
                                user1.Username!,
                                user1.ppurl!,
                                widget.snap['title'],
                              );
                            },
                            icon: liked? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                                : const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.black,
                            )
                        ),
                      ),
                      const Expanded(
                          child: SizedBox()
                      ),
                      Text(
                        "$commentlen",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        ),
                      IconButton(
                          onPressed: (){
                            if(kIsWeb){
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context)=>Wcommentd(
                                      snap: widget.snap,
                                    ),
                                  )
                              );
                            }else{
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context)=>McommentsScreen(
                                      snap: widget.snap,
                                    ),
                                  )
                              );
                            }
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.comments,
                            color: Colors.black,
                          )
                      ),
                      const Expanded(
                          child: SizedBox()
                      ),
                      IconButton(
                          onPressed: (){
                                  try{
                buildDynamicLinks(widget.snap['title'], widget.snap['Profile Pic'], widget.snap['Post Uid']);
                }catch(e){
                  if(widget.snap['Profile Pic']==""){
                    String content="Access Denied,Please sign in to continue";
                    Showsnackbar(content, context);
                  }else{
                  Showsnackbar(e.toString(), context);
                  }
                }
                          },
                          icon: const Icon(
                            Icons.share,
                            color: Colors.black,
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
