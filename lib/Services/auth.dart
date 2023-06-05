
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/Services/Storagemethods.dart';
import '../Models/Users1.dart';

//Authentication

class AuthService{
//Initialization
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageMethods Store =StorageMethods();
  bool guest=false;
  String? Username;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  //custom user for current user
  User1? fbuser(User? user){
    if (user!=null) {
      if(guest){
        return User1(UID: user.uid,Guest: guest,);
      }else{
        return User1(UID: user.uid,Guest: false,Username: Username);
      }
    } else {
      return null;
    }
  }


//Convert to Custom User
  User1? _userfirebase(User? user){
    if (user!=null) {
      if(guest){
        return User1(UID: user.uid,Guest: guest,);
      }else{
        return User1(UID: user.uid,Guest: false,Username:Username );
      }
    } else {
      return null;
    }
  }



  //auth change user stream
  Stream<User1?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _userfirebase(user));

  }

  //sign in as guest

  Future Signguest() async{

    try{
      UserCredential result= await _auth.signInAnonymously();
      User? user = result.user;
      guest=true;

      User1 user1= User1(Bio: "Ghost of Sushima",Guest: true,UID: user?.uid,Username:"Guest",Name:"Guest",Gender:"Unknown",Email: "Guest@Guest.com",ppurl:"",searchkey: "Guest".substring(0,1));

      await  _firestore.collection("users").doc(user!.uid).set(
        user1.toJson(),
      );
    await FirestoreMethods().UpdateThemeMode(user.uid,true);
      return _userfirebase(user);
    }catch(e){
      print(e.toString());

      return null;
    }

  }



  //sign in with email
  Future SigninWithEmail(String email,String password)async{
    try{
      UserCredential result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userfirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }


  }


//reset password
  Future Reset(String email)async{
    try{
      await _auth.sendPasswordResetEmail(email: email).then((value) {
      });

      return null;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Register as new User with email and password
  Future RegisterNewUserEmail(String email,String password,String name,String username,String gender,dynamic image)async{
    try{
      UserCredential result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

    String photourl= await  Store.Storageip("Profilepic", image, false,null);
    String flname=username.substring(0,1).toUpperCase();
    username=flname + username.substring(1);
     User1 user1= User1(
      Admin: false,
      Guest: false,
      UID: user?.uid,
      Username: username,
      Name: name,
      Gender: gender,
      Email: email,
      ppurl: photourl,
      searchkey: username.substring(0,1),
      Bio: "I am new here",
      );

      await  _firestore.collection("users").doc(user!.uid).set(
        user1.toJson(),
      );
      Username=username;
      await FirestoreMethods().UpdateThemeMode(user.uid,true);
      return _userfirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }


  //sign out
  Future SignOut(bool guest,String uid)async{
    try{
      if(guest){
      await  _firestore.collection("users").doc(uid).delete();}
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }


  }

//Return Current user in Custom User

  Future<User1?> CurrentUserDetails()async{
    try {
      User? result = await _auth.currentUser;
      DocumentSnapshot snap= await _firestore.collection("users").doc(result!.uid).get();
      return User1.FromSnap(snap) ;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

//return custom user theme
  Future CurrentUserTheme()async{
    try {
      User? result = await _auth.currentUser;
     DocumentSnapshot snap= await _firestore.collection("Settings").doc(result!.uid).collection("Theme").doc(result.uid).get();
        return UserThemeData.FromSnap(snap) ;
      }catch(e){
        print(e.toString());
      }
  }




}
