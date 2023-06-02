import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/shared/Widgets/post_card.dart';
import 'package:provider/provider.dart';

//TODO: Create theme fields for dialog options
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
                    "Recent Buzz",
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
                    "Trending Buzz",
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
        late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    return Scaffold(
      backgroundColor:Color(themedata.ScaffoldbackColor), 
appBar:AppBar(
  backgroundColor: Color(themedata.AppbarbackColor),
  elevation: 0.0,
  actions: [
    Row(
      children: [
          GestureDetector(
            onTap:(){
             _options(context);
            } ,
          child:  Text(
              "Sort By",
              style: TextStyle(
          color:Color(themedata.AppbartextColor),
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold
              ),
              ),
        ),
        IconButton(
          onPressed: (){
            _options(context);
          },
         icon: FaIcon(
            FontAwesomeIcons.sort,
            color: Color(themedata.AppbariconColor),
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
