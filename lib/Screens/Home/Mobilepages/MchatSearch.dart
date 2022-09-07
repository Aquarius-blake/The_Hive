import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Services/Searchmethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'Mprofilescreen.dart';

class Mchatusersearch extends StatefulWidget {
  const Mchatusersearch({Key? key}) : super(key: key);

  @override
  State<Mchatusersearch> createState() => _MchatusersearchState();
}

class _MchatusersearchState extends State<Mchatusersearch> {
  TextEditingController _search=TextEditingController();
  var queryResultset=[];
  var tempSearchstore=[];



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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.lightBlueAccent,
                backgroundImage: NetworkImage(
                    data['profilepic']
                ),
              ),
              const SizedBox(width: 20,),
              Text(data['username'])
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
        elevation: 3.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: TextFormField(
          controller: _search,
          onChanged: (value){
            try{
                initiateusersearch(value);
            }catch(e){
              Showsnackbar(e.toString(), context);
            }
          },

          decoration: const InputDecoration(
            labelText: "Search User",
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: (){
             /* try{
                initiateusersearch(_search.text);
              }catch(e){
                Showsnackbar(e.toString(), context);
              }*/
              setState(() {

              });
            },
            child:  const Text(
              "User",
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

      body:
      ListView(
        children:tempSearchstore.map((element){
          return usercard(element);
        }).toList()

        ,
      )
    );
  }
}
