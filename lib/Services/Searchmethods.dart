

import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService{


    SearchUser(String searchfield) {
        return  FirebaseFirestore.instance
            .collection("users")
            .where("searchkey",isEqualTo: searchfield.substring(0,1).toUpperCase())
            .get();
    }
    SearchPost(String searchfield) {
        return   FirebaseFirestore.instance
            .collection("Posts")
            .where("searchkey",isEqualTo: searchfield.substring(0,1).toUpperCase())
            .get();
    }

    SearchGroup(String searchfield) {
        return   FirebaseFirestore.instance
            .collection("Groups")
            .where("searchkey",isEqualTo: searchfield.substring(0,1).toUpperCase())
            .get();
    }


}






