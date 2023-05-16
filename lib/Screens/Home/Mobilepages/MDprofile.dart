import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Screens/Home/Mobilepages/Meditprofile.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';
import '../../../shared/Pop_up.dart';



class MDprofile extends StatefulWidget {
  const MDprofile({Key? key}) : super(key: key);

  @override
  State<MDprofile> createState() => _MDprofileState();
}

class _MDprofileState extends State<MDprofile>with
    TickerProviderStateMixin {
  late TabController _tabController;
  int postlen=0;
  getPostlen(String uid)async{
    try{
      QuerySnapshot snapshot=await FirebaseFirestore.instance.collection("Posts").where('author uid' ,isEqualTo: uid).get();
      setState(() {
        postlen=snapshot.docs.length;
      });    }
    catch(e){
      Showsnackbar(e.toString(), context);
    }
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController( vsync:this, length: 2);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    getPostlen(user1.UID!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
            color: Colors.black
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user1.ppurl!),
                      radius: 50,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "$postlen",
                              style: const TextStyle(
                                fontSize: 24,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            const Text(
                              "Posts",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 6.0,
                                  shadowColor: Colors.black,
                                  primary: Colors.white,
                                  side: const BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.0)
                                  )
                              ),
                              onPressed: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context)=>Medprofile(
                                        drawer: true,
                                        user1: user1,
                                      ),
                                    )
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  left:18.0,
                                  right: 18.0,
                                ),
                                child: Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      color: Colors.lightBlueAccent
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 15.0,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    user1.Username!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                ),
                Row(
                    children:[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Name: ${user1.Name}",
                          style: const TextStyle(
                              color: Colors.grey
                          ),
                        ),
                      ),
                      const Expanded(
                          child: SizedBox()
                      ),
                      user1.Gender==null|| user1.Gender==""? const SizedBox(): Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Gender: ${user1.Gender}",
                          style: const TextStyle(
                              color: Colors.grey
                          ),
                        ),
                      ),

                      const SizedBox(width: 80,)
                    ]
                ),
                user1.Bio==null|| user1.Bio==""? const SizedBox(): Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Bio: ${user1.Bio}",
                    style: const TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: user1.DOB==null || user1.DOB==""? const SizedBox()
                      : Text("Date of Birth: ${user1.DOB}",
                    style: const TextStyle(
                        color: Colors.grey
                    ),),
                ),
                const Divider(
                  height: 40,
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}






















