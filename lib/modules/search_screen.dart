import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/news_model.dart';
import 'details_screen.dart';

class searchscreen extends StatefulWidget {
String? input ;

searchscreen(this.input);

  @override
  State<searchscreen> createState() => _searchscreenState();
}

class _searchscreenState extends State<searchscreen> {
 late userlistmodel serchnews ;
  Future<userlistmodel?> getdata   ()async{

    String url = 'https://newsapi.org/v2/top-headlines?q=${widget.input}&apiKey=9526a294900f467f8d0be19b3a747ea5';
    Response response = await Dio().get(url);

    serchnews = userlistmodel.fromjeson(response.data);
    print(response.data);
    print('${response.statusCode}sssssssssssss');
    return  serchnews ;


  }
  @override
  void initState() {
    // TODO: implement initState
    getdata();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back_outlined,
          color: Colors.black,
        )),
        centerTitle: true,
        title: Text(widget.input!,
          style: TextStyle(
            color: Colors.black,
              fontSize: 30

          ),
        ),
      ),

      body:  FutureBuilder<userlistmodel?>(
        future:  getdata(),
        builder:(context,snapshot){

          return  snapshot.hasData? SingleChildScrollView(
            child: Column(

              children: [

                serchnews.news!.isEmpty?Center(child: Text('no result',
                  style: TextStyle(fontSize: 30),
                )): Image(image: NetworkImage(serchnews!.news![0].urlToImage!)),
                ListView.separated(
                  shrinkWrap: true,
                  physics:ScrollPhysics() ,
                  scrollDirection:Axis.vertical ,
                  itemCount: serchnews!.news!.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return detailscreen(serchnews!.news![index]);
                              }));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 150,
                                height: 150,

                                child: Image(
                                  errorBuilder: (context,expeption,stacktree){

                                    return Image(image: NetworkImage('https://demofree.sirv.com/nope-not-here.jpg'));

                                  },
                                  image:  NetworkImage('${serchnews!.news![index].urlToImage}'),
                                  fit: BoxFit.fill,
                                )
                            ),
                            SizedBox(width: 5,),

                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${serchnews!.news![index].title}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14 ,

                                  ),
                                  maxLines: 3,
                                ),
                                SizedBox(height: 9),
                                Text('${serchnews!.news![index].publishedAt},',
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                )
                              ],
                            ))
                          ],
                        ),
                      ),
                    ) ;
                  }, separatorBuilder: (BuildContext context, int index)  =>Divider(
                  thickness: 1.5,
                ),
                )
              ],
            ),
          ):snapshot.hasError?Center(child: Text('eror',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black
            ),
          )):Center(child: CircularProgressIndicator()) ;

        } ,

      ),
    );
  }
}
