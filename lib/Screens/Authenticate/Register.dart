import 'package:flutter/material.dart';
import 'package:forum3/shared/loading.dart';
import 'package:image_picker/image_picker.dart';
import '../../Services/Upload.dart';
import '../../Services/auth.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email="";
  String password="";
  String Username="";
  String Fnmae= "";
  String Gender="";
  String error="";
  dynamic image;
  DateTime date=DateTime(2022,01,01);


  bool loading=false;



  final AuthService _auth= AuthService();
  final _formKey =GlobalKey<FormState>();
  final Upload _upload=Upload();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow[300],
        elevation: 2.0,
        shadowColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          children:const <Widget> [
            Padding(
              padding: EdgeInsets.fromLTRB(20.0,0,0,0),
              child:   Text(
                "Register New Account",
                style: TextStyle(
                  color:Colors.black,
                ),
                ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(6.0),
              color: Colors.yellow[200],
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: [
                          image!=null? CircleAvatar(
                            radius: 60.0,
                            backgroundImage:MemoryImage(image) ,
                          ):const CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.yellow,
                          ),
                          Positioned(
                              bottom: -5,
                              left: 65,
                              child: IconButton(
                                  onPressed: ()async{
                                    image=await _upload.uploadpic(ImageSource.gallery);
                                    setState(()  {

                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.black,
                                  )
                              )
                          )
                        ],
                      ),
                     const SizedBox(height:20 ,),
                      TextFormField(
                        validator: (val)=>val!.isEmpty ? "Enter Your Full Name" : null,
                        onChanged: (val){
                          setState(() {
                            Fnmae=val;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Full Name",
                          filled: true,
                          fillColor: Colors.white70,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),

                          ),
                        ),

                        style: TextStyle(

                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        validator: (val)=>val!.isEmpty ? "Enter Username" : null,
                        onChanged: (val){
                          setState(() {
                            Username=val;
                          });
                        },
                        decoration: InputDecoration(
                          label: const Text("Username"),
                          hintText: "Enter Username,NB:start with CAPS",
                          filled: true,
                          fillColor: Colors.white70,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.redAccent
                              ),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),

                          ),
                        ),

                        style:const TextStyle(

                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        validator: (val)=>val!.isEmpty ? "Please Enter A Valid Email" : null,
                        onChanged: (val){
                          setState(() {
                            email=val;
                          });
                        },
                        decoration: InputDecoration(
                          label: const Text("Email Address"),
                          hintText: "Enter Email Address",
                          filled: true,
                          fillColor: Colors.white70,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.redAccent
                            ),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),

                          ),
                        ),

                        style: TextStyle(

                        ),
                      ),
                     const SizedBox(height: 20,),
                      TextFormField(
                        validator: (val)=>val!.length < 6 ? "Enter a Password longer than 6 characters" : null,
                        onChanged: (val){
                          setState(() {
                            password=val;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          label: const Text("Password"),
                          hintText: "Enter Password",
                          filled: true,
                          fillColor: Colors.white70,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.redAccent
                            ),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),

                          ),
                        ),
                        style: TextStyle(

                        ),
                      ),
                    const   SizedBox(height: 20,),
                      TextFormField(
                        onChanged: (val){
                          setState(() {
                            Gender=val;
                          });
                        },
                        decoration: InputDecoration(
                          label: const Text("Gender"),
                          hintText: "Enter either Male, Female or Other",
                          filled: true,
                          fillColor: Colors.white70,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),

                          ),
                        ),

                        style: const TextStyle(

                        ),
                      ),
                      const SizedBox(height: 50,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: <Widget>[

                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow,
                                  side: const BorderSide(
                                  color: Colors.black,
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
                                    Navigator.pop(context);
                                  }

                                },

                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(75.0,0,75.0,0),
                                  child: Text(
                                    "Sign in as Guest",
                                    style: TextStyle(
                                      color:Colors.black,
                                    ),

                                  ),
                                )
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          Center(
                            child: ElevatedButton(

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
                                onPressed: () async {
                                  if(_formKey.currentState?.validate()!=null){
                                    setState(() {
                                      loading=true;
                                    });
                                    print(email);
                                    dynamic result=await _auth.RegisterNewUserEmail(email, password,Fnmae,Username,Gender,image);
                                    if (result==null){
                                      setState(() {
                                        loading=false;
                                        error="Registeration Failed";
                                      }
                                      );
                                    }else{
                                      print("success");
                                      Navigator.pop(context);
                                    }
                                  }
                                },

                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(100.0,0,100.0,0),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                    ),
                                  ),
                                )
                            ),
                          ),
                          Center(
                            child: Text(error,
                              style: const TextStyle(
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
        ),
      ),
    );
  }
}
