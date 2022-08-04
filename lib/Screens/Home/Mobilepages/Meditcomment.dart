import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';

class Mobcomedit extends StatefulWidget {
  final snap;
  final postid;
  const Mobcomedit({Key? key,this.snap,this.postid}) : super(key: key);

  @override
  State<Mobcomedit> createState() => _MobcomeditState();
}

class _MobcomeditState extends State<Mobcomedit> {
  TextEditingController text=TextEditingController();
  @override
  void initState() {
    text.text=widget.snap['detail'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Edit Comment",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor:Colors.white ,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 18,
                      backgroundImage: NetworkImage(user1.ppurl!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text(user1.Username!),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: text,
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    hintText: "Edit comment as ${user1.Username}",
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
