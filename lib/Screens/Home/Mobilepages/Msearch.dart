import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Msearch extends StatefulWidget {
  const Msearch({Key? key}) : super(key: key);

  @override
  State<Msearch> createState() => _MsearchState();
}

class _MsearchState extends State<Msearch> {
  TextEditingController _search=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0.0,
  title: TextFormField(
    controller: _search,
    decoration: InputDecoration(
      labelText: "Search user",
    ),
  ),
),

      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").where('username',isGreaterThanOrEqualTo: _search.text).get(),
    builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
    if(snapshot.connectionState==ConnectionState.waiting){
    return Center(
    child: CircularProgressIndicator(),
    );
    }else if(!snapshot.hasData){
      return Center(
        child: Text("No match found"),
      );
    }
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
        itemBuilder: (context,index){
        return ListTile();
        }
    );
    }
      ),
    );
  }
}
