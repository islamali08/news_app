import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnews_app/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class detailscreen extends StatefulWidget {

 usermodel? news;

  detailscreen(this.news);

  @override
  State<detailscreen> createState() => _detailscreenState();
}

class _detailscreenState extends State<detailscreen> {
  @override
  Widget build(BuildContext context) {


    
    final Uri _url = Uri.parse('${widget.news!.url}');
    Future<void> _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }



    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back_outlined,
          color: Colors.black,
        )),
      ),

      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(child: Container(
                height: 300,
                width: double.infinity,
                child: Image(

                  errorBuilder: (context,expeption,stacktree){

                    return Image(
                        fit: BoxFit.fill,
                        image: NetworkImage('https://demofree.sirv.com/nope-not-here.jpg'));

                  },

                  image: NetworkImage('${widget.news!.urlToImage}'),
                  fit: BoxFit.fill,
                ),
            ),
            ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: 20,),
               Text('${widget.news!.title}',
                 style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold
                 ),
               ),
               SizedBox(height: 20,),
               Text('${widget.news!.publishedAt}',
                 style: TextStyle(
                     fontSize: 15,
                     color: Colors.grey

                 ),
               ),
               SizedBox(height: 20,),
               Text('${widget.news!.description}',
                 style: TextStyle(
                   fontSize: 20,
                 ),
               ),
               SizedBox(height: 12,),

               Align(
                 alignment: Alignment.centerRight,
                 child: TextButton(onPressed: _launchUrl, child: Text('Open the news on the site',
                   style: TextStyle(
                       fontSize: 20,
                       color: Colors.black

                   ),
                 )),
               ),


             ],
           ),
         )
          ],
        ),
      ),
    );
  }
}
