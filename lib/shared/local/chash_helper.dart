import 'package:shared_preferences/shared_preferences.dart';

class cashhelper {

  static  SharedPreferences? sharedprefences ;

  static init() async {
    sharedprefences = await SharedPreferences.getInstance();
  }

  static Future<bool> putdata(String key,bool value)async{
    return await sharedprefences!.setBool(key, value);


  }


  static bool? getdata(String key){

    return sharedprefences!.getBool(key);
  }

}