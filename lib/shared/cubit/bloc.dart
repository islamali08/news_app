import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnews_app/shared/cubit/state.dart';
import 'package:fnews_app/shared/local/chash_helper.dart';

class appcubit extends Cubit<appstate> {
  static appcubit get(context) => BlocProvider.of(context);

  appcubit() : super(initialstate());

  bool isdark = false;

  void changethem(){

     isdark=!isdark ;
     print('$isdark  cubit');
     cashhelper.putdata('isdark', isdark).then((value) {

       print('${cashhelper.getdata('isdark')}   gey get get');
       emit(darkstate());
     });
   }
  getdark(){
    isdark=cashhelper.getdata('isdark')??false;

    emit(getdarkstate());

  }

  bool islogout =false ;
  logout(){
    islogout=!islogout ;
    cashhelper.putdata('islogout', islogout);

    emit(logoutstate());


  }

  getlogout(){

    islogout=cashhelper.getdata('islogout')??false;
    emit(getlogoutstate());
  }


}
