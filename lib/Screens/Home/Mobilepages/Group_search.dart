import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Screens/Home/Mobilepages/Group_home.dart';
import 'package:forum3/Services/Searchmethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:provider/provider.dart';

class Groupsearch extends StatefulWidget {
  const Groupsearch({Key? key}) : super(key: key);

  @override
  State<Groupsearch> createState() => _GroupsearchState();
}

class _GroupsearchState extends State<Groupsearch> {
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
      onTap: (){
       Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context)=>Ghome(
                snap:data,
              ),
            )
        );
      },
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
             const SizedBox(width:5,),
             data['Admin']==true ? const Text(
              "Admin",
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
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        backgroundColor: Color(themedata.AppbarbackColor),
        elevation: 3.0,
        iconTheme: IconThemeData(
          color: Color(themedata.AppbariconColor),
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

          decoration:  InputDecoration(
            labelText: "Search Colonies",
            labelStyle: TextStyle(
              color: Color(themedata.ScaffoldtextColor),
            ),
          ),
          style:  TextStyle(
            color: Color(themedata.ScaffoldtextColor),
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
            child:   Text(
              "Refresh",
              style: TextStyle(
                color: Color(themedata.ScaffoldbuttonTextColor),
              ),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, 
                backgroundColor: Colors.transparent,
                shadowColor: Colors.black,
                side: BorderSide(
                  color: Color(themedata.ScaffoldbuttonborderColor),
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
