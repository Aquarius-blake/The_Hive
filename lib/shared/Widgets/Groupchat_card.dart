import 'package:flutter/material.dart';
import 'package:forum3/Models/Users1.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:provider/provider.dart';


class Gchatcard extends StatefulWidget {
  final snap;
  const Gchatcard({ Key? key,this.snap }) : super(key: key);

  @override
  State<Gchatcard> createState() => _GchatcardState();
}

class _GchatcardState extends State<Gchatcard> {
  @override
  Widget build(BuildContext context) {
        late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    if(widget.snap['author uid']==user1.UID){
    return Container(
      child: Card(),
    );}else{
      return Container(
        child: Card(),
      );
    }
  }
}