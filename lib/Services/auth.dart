
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/Users1.dart';


class AuthService{
//Initialization
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool guest=false;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;



//Convert to Custom User
  User1? _userfirebase(User? user){
    if (user!=null) {
      if(guest){
        return User1(UID: user.uid,Guest: guest,);
      }else{
        return User1(UID: user.uid,Guest: false);
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



  //Register as new User with email and password
  Future RegisterNewUserEmail(String email,String password,String name,String username,String gender)async{
    try{
      UserCredential result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await  _firestore.collection("users").doc(user!.uid).set({
        "UID":user.uid,
        "Username":username,
        "Full Name":name,
        "Gender":gender,
      }
      );
      return _userfirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }


  //sign out
  Future SignOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }


  }

}