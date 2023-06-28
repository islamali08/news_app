import 'dart:async';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:fnews_app/main.dart';
import 'package:fnews_app/modules/first_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../modules/catagory.dart';
import '../modules/search_screen.dart';
import '../modules/seting.dart';
import '../modules/video.dart';
import '../modules/vidio_catagory.dart';
import '../shared/components/components.dart';
import '../shared/cubit/bloc.dart';
import '../shared/cubit/state.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  var scafoldkey = GlobalKey<ScaffoldState>();

  TextEditingController search = TextEditingController();
  bool ischec = false;

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );


  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return   DefaultTabController(
      length: 3,
      child: BlocConsumer<appcubit, appstate>(
        listener: (context, state) {},
        builder: (context, state) {
          appcubit cubit = appcubit.get(context);


          return Scaffold(

            body: Scaffold(
              key: scafoldkey,

              appBar: AppBar(
                actions: [
                  ischec == false
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              ischec = true;
                            });
                          },
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.black,
                          ))
                      : Container()
                ],
                centerTitle: true,
                title: ischec == true
                    ? TextFormField(
                        controller: search,
                        decoration: InputDecoration(
                            hintText: 'search',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  ischec = false;
                                });
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return searchscreen(search.text);
                                }));
                              },
                              icon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            )),
                      )
                    : LocaleText(
                        'news',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                bottom: TabBar(
                  labelColor: Colors.grey[400],
                  tabs: [
                     LocaleText('home',
                     style: TextStyle(
                       fontSize: 17
                     ),
                     ),
                    LocaleText('catagory',
                      style: TextStyle(
                          fontSize: 17
                      ),

                    ),

                    LocaleText('live',
                      style: TextStyle(
                          fontSize: 17
                      ),

                    ),

                  ],
                ),
                leading:IconButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return seting() ;
                        }));

                  },
                  icon: Icon(Icons.settings),
                ),
              ),
              body: isAlertSet==true?Container():TabBarView(
                children: [
                  firstscreen(),
                  Catagory(),
                  vidiocatagory(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
