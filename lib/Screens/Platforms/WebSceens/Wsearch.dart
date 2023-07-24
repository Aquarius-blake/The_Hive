import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Screens/Platforms/WebSceens/WprofileScreen.dart';
import 'package:forum3/shared/error_handling.dart';
import '../../../Services/Searchmethods.dart';
import '../../../shared/Widgets/post_card.dart';






class Wsearch extends StatefulWidget {
  const Wsearch({Key? key}) : super(key: key);

  @override
  State<Wsearch> createState() => _WsearchState();
}

class _WsearchState extends State<Wsearch> {
  TextEditingController _search=TextEditingController();
var queryResultset=[];
var tempSearchstore=[];
  String se="Post";
bool postsearch=false;
  bool isShowuser=false;
bool loadin=false;
  initiatepostsearch(value){
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



  initiateusersearch(value){
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
              builder: (context)=>Wprofile(
                snap: data,
              ),
            )
        );
      },
      child: Card(
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
              const SizedBox(width: 10,),
              Text(
                  data['username'],
                style: const TextStyle(),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          controller: _search,
          onChanged: (value){
            try{
              if(isShowuser){
                initiateusersearch(value);

              }else {
                initiatepostsearch(value);
              }}catch(e){
              errormessage(e.toString(), context);
            }
          },
          decoration:  InputDecoration(
            border: InputBorder.none,
            label: Text(
              "Search $se",
              style: const TextStyle(

              ),
            ),
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
                elevation: 0.0, backgroundColor: Colors.white,
                shadowColor: Colors.black,
                side: const BorderSide(
                  color: Colors.lightBlueAccent,
                  width: 2.0,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)
                )
            ),
          ),
          /*
          ElevatedButton(
            onPressed: ()async{
            },
            child: Text(
              "User",
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                shadowColor: Colors.black,
                primary: Colors.blue[400],
                side: const BorderSide(
                  color: Colors.white70,
                  width: 2.0,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)
                )
            ),
          ),*/
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













