

import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService{


    SearchUser(String searchfield) async{
        return await FirebaseFirestore.instance
            .collection("users")
            .where("searchkey",isEqualTo: searchfield.substring(0,1).toUpperCase())
            .get();
    }
    SearchPost(String searchfield)async {
        return  await FirebaseFirestore.instance
            .collection("Posts")
            .where("searchkey",isEqualTo: searchfield.substring(0,1).toUpperCase())
            .get();
    }


}






