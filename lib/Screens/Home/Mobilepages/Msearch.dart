import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Screens/Home/Mobilepages/Mpprofile_screen.dart';
import 'package:forum3/Services/Searchmethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:forum3/shared/Widgets/post_card.dart';
import 'package:provider/provider.dart';

class Msearch extends StatefulWidget {
  const Msearch({Key? key}) : super(key: key);

  @override
  State<Msearch> createState() => _MsearchState();
}

class _MsearchState extends State<Msearch> {
  TextEditingController _search=TextEditingController();
  bool isShowuser=false;
  String se="Post";
  var queryResultset=[];
  var tempSearchstore=[];


  initiatepostsearch(value)async{
    if(value.length==0){
      setState(() {
        queryResultset=[];
        tempSearchstore=[];
      });
    }
    var capvalue=value.substring(0,1).toUpperCase()+value.substring(1);
    if(queryResultset.length==0 && value.length==1 ){
      SearchService().SearchPost(value).then((QuerySnapshot<Map<String,dynamic>> snapshot){
        for(int i=0;i<snapshot.docs.length;++i){
          queryResultset.add(snapshot.docs[i].data());
        }
      });
    }else{
      tempSearchstore=[];
      queryResultset.forEach((element) {
        if(element['title'].startsWith(capvalue)){
          setState(() {
            tempSearchstore.add(element);
          });
        }
      });
    }
  }



  initiateusersearch(value)async{
    if(value.length==0){
      setState(() {
        queryResultset=[];
        tempSearchstore=[];
      });
    }
    var capvalue=value.substring(0,1).toUpperCase()+value.substring(1);
    if(queryResultset.length==0 && value.length==1 ){
      SearchService().SearchUser(value).then((QuerySnapshot<Map<String,dynamic>> snapshot){
        for(int i=0;i<snapshot.docs.length;++i){
          queryResultset.add(snapshot.docs[i].data());
        }
      });
    }else{
      tempSearchstore=[];
      queryResultset.forEach((element) {
        if(element['username'].startsWith(capvalue)){
          setState(() {
            tempSearchstore.add(element);
          });
        }
      });
    }
  }


  Widget usercard(data){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context)=>Mprofile(
                snap: data,
              ),
            )
        );
      },
      child: Card(
        color:Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 2.0,
        shadowColor: Colors.transparent,
        child: Container(
          padding:const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    data['profilepic']
                ),
              ),
             const SizedBox(width: 10,),
              Text(
                data['username'],
                style:const TextStyle(
                  color:Colors.lightBlueAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
            late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    return Scaffold(
      backgroundColor:Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        backgroundColor: Color(themedata.AppbarbackColor),
        elevation: 0.0,
        title: TextFormField(
          controller: _search,
          onChanged: (value){
            try{
              if(isShowuser){
                initiateusersearch(value);

              }else {
                initiatepostsearch(value);
              }}catch(e){
              Showsnackbar(e.toString(), context);
            }
          },

          decoration: InputDecoration(
            labelText: "Search $se",
            labelStyle:  TextStyle(
              color:Color(themedata.AppbartextColor),
            ),
          ),
          style:  TextStyle(
            color:Color(themedata.AppbartextColor),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: (){
              setState(() {
                isShowuser=!isShowuser;
                if(isShowuser){
                  se="user";
                }else{
                  se="Post";
                }
              });
            },
            child: !isShowuser? Text(
              "User",
              style: TextStyle(
                color: Color(themedata.AppbartextbuttonColor!),
              ),
            ): Text(
              "Posts",
              style: TextStyle(
                color: Color(themedata.AppbartextbuttonColor!),
              ),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Color(themedata.AppbarbackColor),
                shadowColor: Color(themedata.AppbarShadowColor),
                side: const BorderSide(
                  color: Colors.lightBlueAccent,
                  width: 2.0,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)
                )
            ),
          ),
        ],
      ),

      body: isShowuser? ListView(
        children:tempSearchstore.map((element){
          return usercard(element);
        }).toList()
        ,
      )
          :ListView(
        children: tempSearchstore.map((element){
          return PostCard(snap: element,);
        }).toList(),
      ),
    );
  }
}
