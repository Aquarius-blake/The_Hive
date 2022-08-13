import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Services/Searchmethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:forum3/shared/Widgets/post_card.dart';

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

  Widget ppostcard(data){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      elevation: 2.0,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(data['Profile Pic']),
            ),
            Text(data['author'])
          ],
        ),
      ),
    );
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
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      elevation: 2.0,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(data['profilepic']),
            ),
            Text(data['username'])
          ],
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: (){
              setState(() {
                isShowuser=!isShowuser;
                if(isShowuser){
                  se="user";
                }
              });
            },
            child: !isShowuser? const Text(
              "User",
              style: TextStyle(
                color: Colors.lightBlueAccent,
              ),
            ):const Text(
                "Post",
            style: TextStyle(
color: Colors.lightBlueAccent,
            ),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                shadowColor: Colors.black,
                primary: Colors.white,
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
