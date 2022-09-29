import 'package:flutter/material.dart';
import 'package:forum3/Models/Users1.dart';


class GrPost extends StatefulWidget {
  final snap;
  const GrPost({ Key? key,this.snap }) : super(key: key);

  @override
  State<GrPost> createState() => _GrPostState();
}

class _GrPostState extends State<GrPost> {
  dynamic _image;

   Widget Avatar(User1 user1){
    try{
      return user1.ppurl==""?const CircleAvatar(
           radius: 20,
        backgroundImage: AssetImage('Assets/hac.jpg'),     
      )
       : CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(user1.ppurl!),
      );
    }catch(e){
      return const CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage('Assets/hac.jpg'),
      );
    }
  }

  Widget Post(){
    return _image==null?SizedBox():SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      child:Image.memory(_image),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black ,
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Group Post",
          style: TextStyle(
            color:Colors.white,
          ),
          ),
      ),
      
    );
  }
}