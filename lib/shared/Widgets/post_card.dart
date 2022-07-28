import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({ Key? key,this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  //dynamic _image;
  Widget Postimage(dynamic image,BuildContext context){
    if(image==""){
      setState(() {
        image=null;
      });
    }
    return image!=null? SizedBox(
      width: MediaQuery.of(context).size.width*0.7,
      child: Image.network(image),
    ):SizedBox();
  }

  @override
  Widget build(BuildContext context) {
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
                    IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.red,
                        )
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
