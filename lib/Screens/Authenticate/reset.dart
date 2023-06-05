import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Services/auth.dart';


class Resetpass extends StatefulWidget {
  Resetpass({Key? key}) : super(key: key);

  @override
  State<Resetpass> createState() => _ResetpassState();
}

class _ResetpassState extends State<Resetpass> {
double cp=0;
bool e=false;
  String email="";
String error="";
double fp=0;
double padd=0;

  final AuthService _auth=AuthService();
  final _formKey =GlobalKey<FormState>();

@override
  void initState() {

  if(kIsWeb){
padd=150;
 fp=100;
 cp=16;
  }
  else{
    padd=10;
     fp=50;
     cp=30;
  }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow[300],
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
            "Reset Password",
            style: TextStyle(
              color: Colors.black,
            ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding:  EdgeInsets.all(padd),
          child: Card(
            margin: EdgeInsets.fromLTRB(16.0, cp,16.0, cp),
            color: Colors.black,
            shadowColor: Colors.black,
            elevation: 12.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0)
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Password Reset",
                            style: TextStyle(
                            fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow
                            ),
                            ),
                            Container(
                              child: Padding(
                                padding:  EdgeInsets.fromLTRB(fp, 10, fp, 30),
                                child: TextFormField(
                                  validator: (val)=>val!.isEmpty ? "Please Enter A Valid Email" : null,
                                  onChanged: (val){
                                    setState(() {
                                      email=val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter Email Address",
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100.0),

                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.redAccent
                                        ),
                                      borderRadius: BorderRadius.circular(100.0),
                                    ),
                                  ),
                                  style: TextStyle(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            ElevatedButton(
                              onPressed: () async{
                                if(_formKey.currentState?.validate()!=null){
                                  await _auth.Reset(email);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                    "Reset Password",
                                        style: TextStyle(
                                          color: Colors.yellow
                                        ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  elevation: 6.0,
                                  backgroundColor: Colors.black,
                                  shadowColor: Colors.black,
                                  side: const BorderSide(
                                    color: Colors.yellow,
                                    width: 2.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.0)
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
