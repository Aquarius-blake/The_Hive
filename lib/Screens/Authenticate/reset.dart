import 'package:flutter/material.dart';
import 'package:forum3/Services/auth.dart';

class Resetpass extends StatefulWidget {
  Resetpass({Key? key}) : super(key: key);

  @override
  State<Resetpass> createState() => _ResetpassState();
}

class _ResetpassState extends State<Resetpass> {
  final _formKey =GlobalKey<FormState>();
  final AuthService _auth=AuthService();
  String email="";
String error="";
bool e=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],

      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: SafeArea(
        child: Container(

          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                          color: Colors.white
                        ),),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(100, 10, 100, 30),
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
                                  borderSide: BorderSide(color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              ),

                              style: TextStyle(

                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                          onPressed: () async{
                            if(_formKey.currentState?.validate()!=null){
                              await _auth.Reset(email);
                              if(e=false){
                              Navigator.pop(context);}
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                                "Reset Password",
                                    style: TextStyle(
                                      color: Colors.blue
                                    ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 6.0,
                              shadowColor: Colors.black,
                              primary: Colors.white,
                              side: BorderSide(
                                color: Colors.blue,
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
    );
  }
}
