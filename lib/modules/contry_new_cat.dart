import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/news_model.dart';
import 'details_screen.dart';

class cantrynews extends StatefulWidget {
String contry ;
String catagory ;

cantrynews(this.contry, this.catagory);

@override
  State<cantrynews> createState() => _cantrynewsState();
}

class _cantrynewsState extends State<cantrynews> {

  userlistmodel? news ;

  Future<userlistmodel?> getdata()   async{

    String url ='https://newsapi.org/v2/top-headlines?country=${widget.contry}&category=${widget.catagory}&apiKey=9526a294900f467f8d0be19b3a747ea5';

    Response response = await Dio().get(url);
    news = userlistmodel.fromjeson(response.data);
    print(response.data);
    print(response.statusCode);


    return news ;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getdata();
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
        title: Text('${widget.contry} ${widget.catagory }',
          style: TextStyle(
              color: Colors.black,
              fontSize: 30

          ),
        ),
      ),
      body:             FutureBuilder<userlistmodel?>(
        future: getdata(),
        builder:(context,snapshot){
          return snapshot.hasData? ListView.separated(
            shrinkWrap: true,
            itemCount: news!.news!.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
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
                            errorBuilder: (context,expeption,stacktree){

                              return Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage('https://demofree.sirv.com/nope-not-here.jpg'));

                            },
                            image:news!.news![index].urlToImage==null?NetworkImage('https://demofree.sirv.com/nope-not-here.jpg'):  NetworkImage('${news!.news![index].urlToImage}'),
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
                              fontSize: 14 ,

                            ),
                            maxLines: 3,
                          ),
                          SizedBox(height: 9),
                          Text('${news!.news![index].publishedAt},',
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
          ):snapshot.hasError?Text('eror'):Center(child: CircularProgressIndicator());
        } ,

      ),

    );
  }
}
