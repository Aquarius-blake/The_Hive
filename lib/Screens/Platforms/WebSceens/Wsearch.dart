import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Services/Searchmethods.dart';


class Wsearch extends StatefulWidget {
  const Wsearch({Key? key}) : super(key: key);

  @override
  State<Wsearch> createState() => _WsearchState();
}

class _WsearchState extends State<Wsearch> {
  TextEditingController _search=TextEditingController();
var queryResultset=[];
var tempSearchstore=[];
bool postsearch=false;

  initiateusersearch(value){
    if(value.length==0){
      setState(() {
        queryResultset=[];
        tempSearchstore=[];
      });
    }
    var capvalue=value.substring(0,1).toUpperCase()+value.substring(1);
    if(queryResultset.length==0 && value.length==1 ){
      SearchService().SearchUser(value).then((QuerySnapshot snapshot){
        for(int i=0;i<snapshot.docs.length;++i){
          queryResultset.add(snapshot.docs[i].data());
        }
      });
    }else{
      tempSearchstore=[];
      queryResultset.forEach((element) {
        print(element['username']);
        if(element['username'].startsWith(capvalue)){
          setState(() {
            tempSearchstore.add(element);
          });
        }
      });
    }
  }
  Widget secard(data){
    print(data['username']);
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
            Text(data['username'],
            style: TextStyle(
              color: Colors.red
            ),)
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
        title: TextFormField(
          controller: _search,
          onFieldSubmitted: (String value){
            initiateusersearch(value);
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            label: Text(
              "Search",
              style: TextStyle(

              ),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: ()async{
await initiateusersearch(_search.text);
setState(() {

});
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
          ),
          ElevatedButton(
            onPressed: (){},
            child: const Text(
              "Post",
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
                    borderRadius: BorderRadius.circular(20.0)
                )
            ),
          ),

        ],
      ),
      body: ListView(
        children:tempSearchstore.map((element){
          return secard(element);
        }).toList()
        ,
      ),
    );
  }

}













