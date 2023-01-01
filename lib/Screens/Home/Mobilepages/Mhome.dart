import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/shared/Widgets/post_card.dart';


class Mhome extends StatefulWidget {
  const Mhome({Key? key}) : super(key: key);

  @override
  State<Mhome> createState() => _MhomeState();
}

class _MhomeState extends State<Mhome> {

late String sortby="Post Time";

 _options(BuildContext context)async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text(
                "Sort by",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
             SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                    "Recent Post",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                onPressed: (){
                  setState(() {
                    sortby='Post Time';
                  });
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                    "Most Liked",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                  ),
                ),
                onPressed: ()async{
                  setState(() {
                    sortby='nol';
                  });
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors. black, 
appBar:AppBar(
  backgroundColor: Colors.black,
  elevation: 0.0,
  actions: [
    Row(
      children: [
          GestureDetector(
            onTap:(){
             _options(context);
            } ,
          child: const Text(
              "Sort By",
              style: TextStyle(
          color:Colors.white,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold
              ),
              ),
        ),
        IconButton(
          onPressed: (){
            _options(context);
          },
         icon: const FaIcon(
            FontAwesomeIcons.sort,
            color: Colors.white,
         ),
         ),
      ],
    ),
  ],
),

  body: StreamBuilder(
    stream: FirebaseFirestore.instance.collection('Posts').orderBy(sortby,descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) => Container(
        child: PostCard(
          snap: snapshot.data!.docs[index].data(),
        ),
      )
      );
      },
  ),
    );
  }
}
