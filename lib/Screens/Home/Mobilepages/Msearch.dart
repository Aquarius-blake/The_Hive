import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Msearch extends StatefulWidget {
  const Msearch({Key? key}) : super(key: key);

  @override
  State<Msearch> createState() => _MsearchState();
}

class _MsearchState extends State<Msearch> {
  TextEditingController _search=TextEditingController();
  bool isShowuser=false;
var queryResultset=[];
var tempSearchstore=[];


  initiateusersearch(value){
    if(value.length==0){
      setState(() {
        queryResultset=[];
        tempSearchstore=[];
      });
    }
    var capvalue=value.substring(0,1).toUpperCase()+value.substring(1);
if(queryResultset.length==0 && value.lenth==1 ){}
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
    onFieldSubmitted: (String _){
      setState(() {
        isShowuser=true;
      });
    },
    decoration: InputDecoration(
      labelText: "Search user",
    ),
  ),
),

      body: isShowuser? FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").where("username",isGreaterThanOrEqualTo: _search.text.trim()).get(),
    builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
    if(snapshot.connectionState==ConnectionState.waiting){
    return Center(
    child: CircularProgressIndicator(),
    );
    }else if(!snapshot.hasData){
      return Center(
        child: Text("No match found",
        style: TextStyle(
            color: Colors.black,
        ),),
      );
    }
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
        itemBuilder: (context,index){
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(snapshot.data!.docs[index]['profilepic']),
          ),
          title: Text(snapshot.data!.docs[index]['username'],
            style: TextStyle(
              color: Colors.black
            ),
          ),
        );
        }
    );
    }
      ):Text("Post"),
    );
  }
}
