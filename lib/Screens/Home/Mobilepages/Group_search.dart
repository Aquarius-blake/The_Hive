import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Screens/Home/Mobilepages/Mpprofile_screen.dart';
import 'package:forum3/Services/Searchmethods.dart';
import 'package:forum3/shared/Pop_up.dart';

class Mchatusersearch extends StatefulWidget {
  const Mchatusersearch({Key? key}) : super(key: key);

  @override
  State<Mchatusersearch> createState() => _MchatusersearchState();
}

class _MchatusersearchState extends State<Mchatusersearch> {
  TextEditingController _search=TextEditingController();
  var queryResultset=[];
  var tempSearchstore=[];



  initiategroupsearch(value)async{
    if(value.length==0){
      setState(() {
        queryResultset=[];
        tempSearchstore=[];
      });
    }
    var capvalue=value.substring(0,1).toUpperCase()+value.substring(1);
    if(queryResultset.length==0 && value.length==1 ){
      SearchService().SearchGroup(value).then((QuerySnapshot<Map<String,dynamic>> snapshot){
        for(int i=0;i<snapshot.docs.length;++i){
          queryResultset.add(snapshot.docs[i].data());
        }
      });
    }else{
      tempSearchstore=[];
      queryResultset.forEach((element) {
        if(element['Group Name'].startsWith(capvalue)){
          setState(() {
            tempSearchstore.add(element);
          });
        }
      });
    }
  }


  Widget groupcard(data){
    return GestureDetector(
      onTap: (){},
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                    data['Group Pic']
                ),
              ),
              const SizedBox(width: 20,),
              Text(
                data['Group Name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                ),
              SizedBox(width:5,),
             data['Admin']==true ? const Text("Admin",
              style :TextStyle(
                color:Colors.white,
                fontStyle:FontStyle.italic ,
              ),
              ):const SizedBox(),
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 3.0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: TextFormField(
          controller: _search,
          onChanged: (value){
            try{
                initiategroupsearch(value);
            }catch(e){
              Showsnackbar(e.toString(), context);
            }
          },

          decoration: const InputDecoration(
            labelText: "Search Groups",
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
              "Refresh",
              style: TextStyle(
                color: Colors.lightBlueAccent,
              ),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                shadowColor: Colors.black,
                primary: Colors.black,
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
          return groupcard(element);
        }).toList()

        ,
      )
    );
  }
}
