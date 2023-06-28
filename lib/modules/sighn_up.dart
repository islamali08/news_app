import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnews_app/model/vidio_model.dart';
import 'package:fnews_app/modules/login.dart';

class sighnup extends StatefulWidget {
  const sighnup({Key? key}) : super(key: key);

  @override
  State<sighnup> createState() => _sighnupState();
}

class _sighnupState extends State<sighnup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String? validatemail(String? value) {
    if (value!.isEmpty) {
      return 'requid';
    } else if (!EmailValidator.validate(value)) {
      return 'not valid email';
    }
  }

  String? validatepass(String? value) {
    if (value!.isEmpty) {
      return 'requid';
    } else if (value.length < 6 || value.length > 12) {
      return 'password betwen 6 and 12';
    }
  }
bool isvald =false ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: Image(
                          fit: BoxFit.cover, image: AssetImage('assets/hhh.png')),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'sign up',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: validatemail,
                      controller: email,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Email',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.5,
                        )),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.5),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 9),
                    TextFormField(
                      validator: validatepass,
                      controller: password,
                      decoration: InputDecoration(
                          hintText: 'password',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5,
                                color: Colors.black
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5))),

                    ),


                    SizedBox(
                      height: 15,
                    ),

                  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(350, 45),
                            backgroundColor: Colors.black,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email.text, password: password.text).then((value) {
                                    setState(() {
                                      isvald=true ;
                                      print(isvald);
                                    });
                          });

                        },
                        child: Text(
                          'sign up',
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        )),
                Center(child: Visibility(visible: isvald==true,child: Text('Done'))),
                    Center(
                      child: TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text('Back to login',
                        style: TextStyle(
                            fontSize: 20,
                          color: Colors.black
                        ),
                      ),
                      ),
                    )


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
