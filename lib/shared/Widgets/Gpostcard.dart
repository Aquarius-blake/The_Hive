import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Screens/Home/Mobilepages/Group_Postedit.dart';
import 'package:forum3/Screens/Home/Mobilepages/Group_commentscreen.dart';
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

class GPostCard extends StatefulWidget {
  final snap;
  final Groupid;
  const GPostCard({ Key? key,this.snap,this.Groupid}) : super(key: key);

  @override
  State<GPostCard> createState() => _GPostCardState();
}


class _GPostCardState extends State<GPostCard> {
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
                          builder: (context)=>Geditpost(
                            snap: widget.snap,
                            groupid: widget.Groupid,
                          ),
                        )
                    );
                  }
                },
              ),
              SimpleDialogOption(
                padding:  const EdgeInsets.all(15.0),
                child: const Text(
                    "Delete",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                  ),
                ),
                onPressed: ()async{
                  String ress=  await FirestoreMethods().Deletegroupost(widget.Groupid,widget.snap['Post Uid']);
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
        await FirestoreMethods().likedgroupost(
                                widget.snap['Post Uid'], 
                                widget.snap['author uid'],
                                 widget.snap['likes'], 
                                 widget.Groupid);
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
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    if(user1.UID==widget.snap['author uid']){
      FirestoreMethods().Updatepostpic(widget.snap['Post Uid'], user1.ppurl!);
      setState(() {

      });
    }

    String authoruid=user1.UID!;
    List list=widget.snap['likes'];
    likedf(authoruid, list);
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        left: 10,
        right: 10,
        bottom: 5,
      ),
      child: Card(
        color: Color(themedata.CardBackgroundColor),
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
                                  style:  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:Color(themedata.CardTextColor)
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
                      icon:  Icon(
                        Icons.more_vert,
                        color: Color(themedata.CardIconColor),
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
                      style:  TextStyle(
                        fontSize: 22,
                        color: Color(themedata.CardTextColor),
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
                      style:  TextStyle(
                        fontSize: 14,
                        color: Color(themedata.CardTextColor),
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
                color: Colors.grey,  
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${widget.snap['likes'].length}",
                        style:  TextStyle(
                          color: Color(themedata.CardTextColor),
                        ),
                      ),
                      likeAnimation(
                        isAnimating: widget.snap['likes'].contains(user1.UID),
                        smallLike: true,
                        child: IconButton(
                            onPressed: ()async{
                              await FirestoreMethods().likedgroupost(
                                widget.snap['Post Uid'], 
                                widget.snap['author uid'],
                                 widget.snap['likes'], 
                                 widget.Groupid);
                            },
                            icon: liked? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                                :  Icon(
                              Icons.favorite_border_outlined,
                              color: Color(themedata.CardIconColor),
                            )
                        ),
                      ),
                      const Expanded(
                          child: SizedBox()
                      ),
                      Text(
                        "${widget.snap['nocomments']}",
                        style:  TextStyle(
                          color: Color(themedata.CardTextColor),
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
                                    builder: (context)=>GcommentsScreen(
                                      snap: widget.snap,
                                      groupid: widget.Groupid,
                                    ),
                                  )
                              );
                            }
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.comments,
                            color: Color(themedata.CardIconColor),
                          )
                      ),
                      const Expanded(
                          child: SizedBox()
                      ),
                      //TODO:Work on group share buttons in future versions
                      IconButton(
                          onPressed: null/*(){
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
                          }*/,
                          icon:  Icon(
                            Icons.share,
                            color: Color(themedata.CardIconColor),
                          ),
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
