import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/shared/loading.dart';
import '../../Services/auth.dart';

class Singin extends StatefulWidget {
  const Singin({Key? key}) : super(key: key);

  @override
  State<Singin> createState() => _SinginState();
}

class _SinginState extends State<Singin> {

  final AuthService _auth= AuthService();
  final _formKey =GlobalKey<FormState>();
  bool loading=false;

  //Text field States
  String email="";
  String password="";
  String error="";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.lightBlueAccent[100] ,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 2.0,
        title: const Center(
            child: Text(
              "Welcome",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const   SizedBox(height:30 ,),
                  const FaIcon(
                    FontAwesomeIcons.peopleGroup,
                    color: Colors.white70,
                    size: 180,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val)=>val!.isEmpty ? "Please Enter A Valid Email" : null,
                    onChanged: (val){
                      setState(() {
                        email=val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: const TextStyle(
                          color: Colors.black
                      ),
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
                  const SizedBox(height: 20,),
                  TextFormField(
                    validator: (val)=>val!.isEmpty ? "Please Enter A Valid Password" : null,
                    onChanged: (val){
                      setState(() {
                        password=val;
                      });
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: const TextStyle(
                          color: Colors.black
                      ),
                      hintText: "Enter Password",
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
                  SizedBox(height: 5.0,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/reset');
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic
                          ),)
                    ),
                  ),
                  SizedBox(height: 50,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: <Widget>[
                      Center(
                        child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                                elevation: 7.0, 
                                backgroundColor: Colors.blue[400],
                                shadowColor: Colors.black,
                                side: BorderSide(
                                  color: Colors.white70,
                                  width: 2.0,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)
                                )
                            ),
                            onPressed: () async {
                              if(_formKey.currentState?.validate()!=null){
                                setState(() {
                                  loading=true;
                                });
                                print(email);
                                dynamic result= await _auth.SigninWithEmail(email, password);
                                if (result==null){
                                  setState(() {
                                    error="Sigin Failed, Check Signin details";
                                    loading=false;
                                  }
                                  );
                                }else{
                                  print("success");
                                }
                              }else{
                                error="Signin Failed";}
                              loading=false;
                            },

                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(100.0,0.0,100.0,0),
                              child: Text(
                                "Sign in ",


                              ),
                            )
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 7.0, 
                                backgroundColor: Colors.blue[400],
                                shadowColor: Colors.black,
                                side: BorderSide(
                                  color: Colors.white70,
                                  width: 2.0,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)
                                )
                            ),
                            onPressed: () async {
                              dynamic result= await _auth.Signguest();
                              if(result== null){
                                print("Error Signing into App");
                              }else
                              {
                                print("Success");
                                print(result.UID);
                              }

                            },

                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(75.0,0,75.0,0),
                              child: Text(
                                "Sign in as Guest",
                                style: TextStyle(

                                ),

                              ),
                            )
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 6.0,
                                shadowColor: Colors.black,
                                primary: Colors.white,
                                side: const BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),

                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)
                                )
                            ),
                            onPressed: () async {
                              Navigator.pushNamed(context, '/register');

                            },

                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(100.0,10,100.0,10.0),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            )
                        ),
                      ),
                      SizedBox(height: 5.0,),
                      Center(
                        child: Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      )

                    ],
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
