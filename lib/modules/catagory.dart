 import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:fnews_app/modules/details_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../model/news_model.dart';
import '../shared/components/components.dart';
import 'news_catogary.dart';

class Catagory extends StatefulWidget {
  const Catagory({Key? key}) : super(key: key);

  @override
  State<Catagory> createState() => _CatagoryState();
}
 userlistmodel? c1 ;
bool? done ;
class _CatagoryState extends State<Catagory> {
  Future<userlistmodel?>  getdata1 ()async{
    String url ='https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=9526a294900f467f8d0be19b3a747ea5';

    Response response = await Dio().get(url);

    c1 = userlistmodel.fromjeson(response.data);
    print(response.data);




    return c1 ;



  }
  userlistmodel? c2 ;

  Future<userlistmodel?>  getdata2 ()async{
    String url ='https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=9526a294900f467f8d0be19b3a747ea5';

    Response response = await Dio().get(url);

    c2 = userlistmodel.fromjeson(response.data);
    print(response.data);




    return c2 ;



  }

  userlistmodel? c3 ;

  Future<userlistmodel?>  getdata3 ()async{
    String url ='https://newsapi.org/v2/top-headlines?country=eg&category=technology&apiKey=9526a294900f467f8d0be19b3a747ea5';

    Response response = await Dio().get(url);

    c3 = userlistmodel.fromjeson(response.data);
    print(response.data);




    return c3 ;



  }
  userlistmodel? c4 ;

  Future<userlistmodel?>  getdata4 ()async{
    String url ='https://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=9526a294900f467f8d0be19b3a747ea5';

    Response response = await Dio().get(url);

    c4 = userlistmodel.fromjeson(response.data);
    print(response.data);




    return c4 ;



  }
  userlistmodel? c5 ;

  Future<userlistmodel?>  getdata5 ()async{
    String url ='https://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=9526a294900f467f8d0be19b3a747ea5';

    Response response = await Dio().get(url);

    c5 = userlistmodel.fromjeson(response.data);
    print(response.data);




    return c5 ;



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
    getdata1();
    getdata2();
    getdata3 ();
    getdata4 ();
    getdata5 ();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(



      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 11),
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: Future.wait([getdata1(),getdata2(),getdata3 (),getdata4 (),getdata5 ()]),
              builder: (context,snapshot){

            return     snapshot.hasData?
                ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 5,
                    itemBuilder: (context,index){
                      List<userlistmodel> u =[c1!,c2!,c3!,c4!,c5!];
                      List<String> tit =['business','sports','technology','health','science'];

                      return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return newscatagory(tit[index]);
                                }));
                          },

                          child: LocaleText('${tit[index]}',
                            style: TextStyle(
                                fontSize: 40
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        GestureDetector(
                          onTap: (){

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return detailscreen(u[index]!.news![0]);
                                }));
                          },
                          child: Container(

                            height: 160,
                            width: 290,
                            child: Image(
                                errorBuilder: (context,expeption,stacktree){

                                  return Image(
                                    fit: BoxFit.fill,
                                      image: NetworkImage('https://demofree.sirv.com/nope-not-here.jpg'));

                                },
                                fit: BoxFit.fill,
                                image:  NetworkImage('${u[index]!.news![0].urlToImage}')),

                          ),
                        ),
                        SizedBox(height: 15,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return detailscreen(u[index]!.news![0]);
                                }));
                          },
                          child: Text(u[index]!.news![0].title!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),

                          ),
                        ),
                        // SizedBox(height: 10),
                        // Text('sport',
                        //   style: TextStyle(
                        //       fontSize: 40
                        //   ),
                        // ),
                        // SizedBox(height: 15,),
                        // Container(
                        //
                        //   height: 200,
                        //   width: 300,
                        //   child: Image(
                        //       fit: BoxFit.fill,
                        //       image: NetworkImage(c2!.news![0].urlToImage!)),
                        // ),
                        // SizedBox(height: 15,),
                        // Text(c2!.news![0].title!,
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold
                        //   ),
                        // )
                      ],
                    ) ;
                    }, separatorBuilder: (BuildContext context, int index)  =>SizedBox(height: 25),):snapshot.hasError?
                Text('eror'):Center(child: CircularProgressIndicator());

              }),
        ),
      )
    );
  }
}
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text('Business',
// style: TextStyle(
// fontSize: 40
// ),
// ),
// SizedBox(height: 15,),
// GestureDetector(
// onTap: (){
//
// Navigator.push(context,
// MaterialPageRoute(builder: (context){
// return detailscreen(c1!.news![0]);
// }));
// },
// child: Container(
//
// height: 170,
// width: 300,
// child: Image(
// fit: BoxFit.fill,
// image: NetworkImage(c1!.news![0].urlToImage!)),
//
// ),
// ),
// SizedBox(height: 15,),
// Text(c1!.news![0].title!,
// style: TextStyle(
// fontWeight: FontWeight.bold
// ),
//
// ),
// SizedBox(height: 10),
// Text('sport',
// style: TextStyle(
// fontSize: 40
// ),
// ),
// SizedBox(height: 15,),
// Container(
//
// height: 200,
// width: 300,
// child: Image(
// fit: BoxFit.fill,
// image: NetworkImage(c2!.news![0].urlToImage!)),
// ),
// SizedBox(height: 15,),
// Text(c2!.news![0].title!,
// style: TextStyle(
// fontWeight: FontWeight.bold
// ),
// )
// ],
// )