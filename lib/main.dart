import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:forum3/Provider/user_provider.dart';
import 'package:forum3/Screens/Authenticate/reset.dart';
import 'package:forum3/Screens/Platforms/WebSceens/webprofile.dart';
import 'package:provider/provider.dart';
import 'Models/Users1.dart';
import 'Screens/Authenticate/Register.dart';
import 'Screens/Home/Profile.dart';
import 'Screens/Wrapper.dart';
import 'Services/auth.dart';
import 'firebase_options.dart';

void main() async{
  //Initialize Firebase functions
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  //Run App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User1?>.value(value: AuthService().user, initialData: null),
        ChangeNotifierProvider(create: (_)=>UserProvider(),),
      ],
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          '/register':(context)=>Register(),
          '/Profile':(context)=>Profile(),
          '/reset':(context)=>Resetpass(),
          '/wprofile':(context)=>Wprofile(),
        },
      ),
    );
  }
}

