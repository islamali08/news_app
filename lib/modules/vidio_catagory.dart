import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnews_app/modules/video.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../model/vidio_model.dart';

class vidiocatagory extends StatefulWidget {

  @override
  State<vidiocatagory> createState() => _vidiocatagoryState();
}

class _vidiocatagoryState extends State<vidiocatagory> {




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
    return Scaffold(
      body:isAlertSet == true?Container(): Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(

          itemCount: image.length,
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return openvidio(index)  ;
                      ;                     }));
              },
              child: Card(
                child: Container(
                  height: 150,
                  width: 150,
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(image[index]),
                  ),
                ),
              ),
            ) ;
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
          ),
        ),
      )

    );
  }
}
