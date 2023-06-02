import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Screens/Home/Mobilepages/Create_groupPage.dart';
import 'package:forum3/Screens/Home/Mobilepages/Group_home.dart';
import 'package:forum3/shared/Widgets/Group_card.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatefulWidget {
  GroupPage({Key? key}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {

@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
        late  User1 user1=  Provider.of<UserProvider>(context).getUser;
        late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;

    return Scaffold(
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar:AppBar(
        backgroundColor: Color(themedata.AppbarbackColor),
        iconTheme: IconThemeData(
          color: Color(themedata.AppbariconColor),
        ),
        title:  Text(
          "Group List",
          style: TextStyle(
            color:Color(themedata.AppbartextColor),
          ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context)=>Creation(),
                        )
                    );
              },
             child:  Text(
              "Create New Colony",
              style: TextStyle(
                color:Color(themedata.AppbartextbuttonColor!)
              ),
              ),
             )
          ],
      ),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Groups').where('Members',arrayContains: user1.UID).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context)=>Ghome(
                snap: snapshot.data!.docs[index].data(),
              ),
            )
        );
                },
                child: GroupCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              )
          );
        },
      ),
    );
  }
}









