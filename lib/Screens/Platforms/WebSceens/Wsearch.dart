import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



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
bool loadin=false;


  initiateusersearch(value,snapshot){
    if(value.length==0){
      setState(() {
        queryResultset=[];
        tempSearchstore=[];
      });
    }
    var capvalue=value.substring(0,1).toUpperCase()+value.substring(1);
    if(queryResultset.length==0 && value.lenth==1 ){
      for(int i=0;i<snapshot.docs.length;++i){
        queryResultset.add(snapshot.docs[i].data());
      }
    }else{
      tempSearchstore=[];
      queryResultset.forEach((element) {
        if(element['usernmae'].startsWith(capvalue)){
          setState(() {
            tempSearchstore.add(element);
          });
        }
      });
    }
  }


  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Widget secard(data){
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          controller: _search,
          onFieldSubmitted: (String value){
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").where("searchkey",isLessThanOrEqualTo: _search.text.substring(0,1)).snapshots(),
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
            initiateusersearch(_search.text, snapshot);
            return ListView(
                children:tempSearchstore.map((element){
                  return secard(element);
                }).toList()
            );
          }
      ),

    );
  }

}













