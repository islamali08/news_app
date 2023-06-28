import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../model/news_model.dart';
import '../shared/cubit/bloc.dart';
import '../shared/cubit/state.dart';
import 'contry_new_cat.dart';
import 'details_screen.dart';
enum SampleItem { itemOne, itemTwo, itemThree }

class newscatagory extends StatefulWidget {
String catogry ;

newscatagory(this.catogry);

  @override
  State<newscatagory> createState() => _newscatagoryState();
}

class _newscatagoryState extends State<newscatagory> {
  userlistmodel? news ;

  Future<userlistmodel?> getdata()   async{

    String url ='https://newsapi.org/v2/top-headlines?country=eg&category=${widget.catogry}&apiKey=9526a294900f467f8d0be19b3a747ea5';

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
  var scafoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SampleItem? selectedMenu;

    return BlocProvider(

      create: (BuildContext context) =>appcubit(),
      child: BlocConsumer<appcubit, appstate>(
        listener: (context, state) {},
        builder: (context, state) {
          appcubit cubit = appcubit.get(context);

          return     Scaffold(
            key:scafoldkey ,
            appBar: AppBar(


              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },icon: Icon(Icons.arrow_back_outlined,
                color: Colors.black,
              )),
              centerTitle: true,
              title: LocaleText(widget.catogry,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30

                ),
              ),
            ),

            body:SingleChildScrollView(
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        LocaleText(
                          'country',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontFamily: 'Billabong'),
                        ),
                        PopupMenuButton(
                            onSelected: (result){
                              if(result==0){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context){
                                      return cantrynews('us', widget.catogry) ;
                                    }));
                              }else if(result==1){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context){
                                      return cantrynews('au', widget.catogry) ;
                                    }));
                              }

                              else if(result==2){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context){
                                      return cantrynews('fr', widget.catogry) ;
                                    }));
                              }

                            },
                            icon: Icon(
                              Icons.expand_more,
                              color: Colors.black,
                            ),
                            itemBuilder: (context) => [

                              PopupMenuItem(

                                child: Row(

                                  children: [
                                    Text('us'),
                                    Spacer(),
                                    Image(
                                        width: 18,
                                        height: 18,
                                        image: NetworkImage(

                                            'https://upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/1200px-Flag_of_the_United_States.svg.png'))
                                  ],
                                ),
                                value: 0,



                              ),
                              PopupMenuItem(

                                child:  Row(

                                  children: [
                                    Text('au'),
                                    Spacer(),
                                    Image(
                                        width: 18,
                                        height: 18,
                                        image: NetworkImage('https://www.worldatlas.com/r/w960-q80/img/flag/au-flag.jpg'
                                        )
                                    )
                                  ],
                                ),
                                value: 1,




                              ),
                              PopupMenuItem(

                                child:  Row(

                                  children: [
                                    Text('fr'),
                                    Spacer(),
                                    Image(
                                        width: 18,
                                        height: 18,
                                        image: NetworkImage('https://cdn11.bigcommerce.com/s-2lbnjvmw4d/images/stencil/1280x1280/products/4410/5333/francesleeve__90485.1619695878.jpg?c=2'
                                        )
                                    )
                                  ],
                                ),
                                value: 2,




                              )
                            ])
                      ],
                    ),
                  ),
                  FutureBuilder<userlistmodel?>(
                    future: getdata(),
                    builder:(context,snapshot){
                      return snapshot.hasData? ListView.separated(
                        physics: ScrollPhysics(),
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

                                      child: Image(  image:news!.news![index].urlToImage==null?NetworkImage('https://demofree.sirv.com/nope-not-here.jpg'):  NetworkImage('${news!.news![index].urlToImage}'),
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
                ],
              ),
            ) ,
          );
          ;
        },
      ),
    );
  }
}
