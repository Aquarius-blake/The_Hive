

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/subjects.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth{}
class MockFirebaseUser extends Mock implements User{}
class MockAuthResult extends Mock implements UserCredential{}

void main(){
  MockFirebaseAuth _auth = MockFirebaseAuth();
  BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();

  group("user_repository_test", () { 
    test("sign in with email and password",() async {

    });

    test("sign out",(){
      
    });

  });
}