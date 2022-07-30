import 'package:flutter/material.dart';
import 'package:forum3/shared/Widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Models/Users1.dart';
import '../../Provider/user_provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({ Key? key,this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}


class _PostCardState extends State<PostCard> {
  bool islikeanimating=false;

  //dynamic _image;
  Widget Postimage(dynamic image,BuildContext context){
    if(image==""){
      setState(() {
        image=null;
      });
    }
    return image!=null? GestureDetector(
      onDoubleTap: (){
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

  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        left: 15,
        right: 15,
        bottom: 5,
      ),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [

                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(widget.snap['Profile Pic']),
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
                                    fontWeight: FontWeight.bold
                                ),)
                            ],
                          ) ,
                          padding:const EdgeInsets.only(
                              left: 10.0
                          )
                      )
                  ),
                  IconButton(
                    onPressed: (){
                      showDialog(context: context, builder: (context)=>Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,),
                          shrinkWrap: true,
                          children: [
                            'Edit',
                            'Delete'
                          ].map((e) => InkWell(
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              child: Text(e),
                            ),
                          )
                          ).toList(),
                        ),
                      )
                      );
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  )
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
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Postimage(widget.snap['Image Url'], context),
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  children: [
                    Text(
                      "${widget.snap['likes'].length}",
                    ),
                    likeAnimation(
                      isAnimating: widget.snap['likes'].contains(user1.UID),
                      smallLike: true,
                      child: IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.red,
                          )
                      ),
                    ),
                    Expanded(
                        child: SizedBox()
                    ),
                    Text("12344"),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.comment_outlined,
                          color: Colors.black,
                        )
                    ),
                    Expanded(
                        child: SizedBox()
                    ),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(
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
    );
  }
}
