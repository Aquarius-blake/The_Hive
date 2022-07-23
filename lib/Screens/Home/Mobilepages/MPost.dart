import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Services/Upload.dart';
import 'package:provider/provider.dart';

import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';

class Mpost extends StatefulWidget {
  Mpost({Key? key}) : super(key: key);

  @override
  State<Mpost> createState() => _MpostState();
}

class _MpostState extends State<Mpost> {
dynamic image;
Upload Selection=Upload();

_selectimage()async{

}


  Widget Avatar(User1 user1){
    try{
      return CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(user1.ppurl!),
      );
    }catch(e){
      return CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage('Assets/hac.jpg'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Avatar(user1),
                            SizedBox(width: 15,),
                            Text(user1.Username!),
                          ],
                        ),
                        SizedBox(height: 15,),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Title",
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: "Write Something.....",
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(),
                        Row(
                          children: [
                            IconButton(onPressed: (){},
                                icon: Icon(Icons.add_a_photo
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
