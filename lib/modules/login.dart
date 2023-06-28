import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnews_app/layout/home.dart';
import 'package:fnews_app/modules/first_screen.dart';
import 'package:fnews_app/modules/sighn_up.dart';
import 'package:fnews_app/shared/cubit/bloc.dart';
import 'package:fnews_app/shared/local/chash_helper.dart';

import '../shared/cubit/state.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);
  static bool islogin = false ;

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var formKey = GlobalKey<FormState>();



  String? validatemail(String? value) {
    if (value!.isEmpty) {
      return 'requid';
    }else if(!EmailValidator.validate(value)){

      return 'not valid email';
    }
  }
  String? validatepass(String? value) {
    if (value!.isEmpty) {
      return 'requid';
    }else if(value.length<6||value.length>12){

      return 'password betwen 6 and 12';
    }
  }

  bool? islogout ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appcubit.get(context).getlogout();
;  }



  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: BlocConsumer<appcubit,appstate>(

        listener: (BuildContext context, Object? state) {  },


        builder: (BuildContext context, state) {
          return appcubit.get(context).islogout==true?home(): Scaffold(

            body: Form(
              key:formKey ,
              autovalidateMode: AutovalidateMode.onUserInteraction,

              child: StreamBuilder (
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context,snapshot){

                  valid() {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return home();
                      }));
                      print('yes');
                    } else {
                      print('no');
                    }
                  }


                  return  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 50,),

                          Align(
                              alignment: Alignment.topLeft,
                              child: Text('news app',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                ),
                              )),
                          SizedBox(height: 3,),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text('Stay informed with the latest updates',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )),

                          SizedBox(height: 100,),
                          Image(
                              height: 200,
                              image: AssetImage('assets/lon.png')),


                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: validatemail,
                            controller: email,
                            decoration: InputDecoration(
                              filled: true,


                              hintText: 'Email',

                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,

                                  )


                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),


                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: Colors.black
                                ),
                              ),


                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            validator:validatepass ,
                            controller: password,
                            decoration: InputDecoration(

                              hintText: 'password',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: Colors.black,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:15,),

                          ElevatedButton(


                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(350, 45),
                                  backgroundColor: Colors.black,
                                  textStyle: TextStyle(
                                      color: Colors.white
                                  )
                              ),

                              onPressed: ()async{

                                FirebaseAuth.instance.signInWithEmailAndPassword (email: email.text.trim(), password: password.text.trim()).then((value) {

                                  appcubit.get(context).logout();
                                  appcubit.get(context).getlogout();


                                });

                               

                              }, child: Text('login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19
                            ),
                          )),
                          SizedBox(height: 3,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("do not have account ?",
                                style: TextStyle(
                                    fontSize: 17
                                ),
                              ),

                              InkWell(
                                onTap: (){

                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context){
                                        return sighnup();
                                      }));
                                },
                                child: Text(' sign up',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          )


                        ],
                      ),
                    ),
                  ) ;
                },
              ),
            ),
          ) ;

        },

      ),
    );
  }


}




