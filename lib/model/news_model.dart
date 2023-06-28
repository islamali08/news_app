class userlistmodel{
  List <usermodel>? news ;

  userlistmodel.fromjeson(Map<String,dynamic> jeson){
    news=[];
    jeson['articles'].forEach(

        (elment)=>news!.add(

            usermodel.fromjeson(elment)
        )
    );

  }


}


class usermodel {

  String? author ;
  String? title ;
  String? description;
  String? url ;
  String? urlToImage ;
  String? content ;
  String? publishedAt;

  usermodel.fromjeson(Map<String,dynamic> jeson){
    author = jeson['author'];
    title = jeson['title'];
    description=jeson['description'];
    url = jeson['url'];
    urlToImage = jeson['urlToImage'];
    content=jeson['content'];
    publishedAt=jeson['publishedAt'];
  }


}