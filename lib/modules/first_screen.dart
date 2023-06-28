import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnews_app/model/news_model.dart';
import 'package:fnews_app/shared/cubit/bloc.dart';
import 'package:fnews_app/shared/cubit/state.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'details_screen.dart';

class firstscreen extends StatefulWidget {
  const firstscreen({Key? key}) : super(key: key);

  @override
  State<firstscreen> createState() => _firstscreenState();
}

class _firstscreenState extends State<firstscreen> {
  userlistmodel? news;

  Future<userlistmodel?> getdata() async {
    String url = 'https://newsapi.org/v2/top-headlines?country=eg&category=general&apiKey=9526a294900f467f8d0be19b3a747ea5';

    Response response = await Dio().get(url);
    news = userlistmodel.fromjeson(response.data);
    print(response.data);
    print(response.statusCode);


    return news;
  }



  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;


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
  void initState() {
    getConnectivity();

    // TODO: implement initState
    super.initState();

    getdata();
  }
  var scafoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(


      create: (BuildContext context) => appcubit(),

      child: BlocConsumer<appcubit,appstate>(

        listener: (BuildContext context, Object? state) {},

        builder: (BuildContext context, state) {
          appcubit cubit = appcubit.get(context);

          return  Scaffold(

            key: scafoldkey,
            body: FutureBuilder<userlistmodel?>(
              future: getdata(),
              builder: (context, snapshot) {
                return

                      snapshot.hasData ?
                       ListView.separated(
                  itemCount: news!.news!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return detailscreen(news!.news![index]);
                              }));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 150,
                                height: 150,

                                child: Image(
                                  errorBuilder: (context, expeption,
                                      stacktree) {
                                    return Image(image: NetworkImage(
                                        'https://demofree.sirv.com/nope-not-here.jpg'));
                                  },
                                  image: NetworkImage(
                                      '${news!.news![index].urlToImage}'),
                                  fit: BoxFit.fill,
                                )
                            ),
                            SizedBox(width: 5,),

                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${news!.news![index].title}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,

                                  ),
                                  maxLines: 3,
                                ),
                                SizedBox(height: 9),
                                Text('${news!.news![index].publishedAt},',
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),

                              ],
                            ))
                          ],
                        ),
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) =>
                    Divider(
                      thickness: 1.5,
                    ),
                ) :
                  snapshot.hasError ? Text('eror') : Center(
                    child: CircularProgressIndicator());
              },

            ),

          );
        },

      ),
    );
  }
}
