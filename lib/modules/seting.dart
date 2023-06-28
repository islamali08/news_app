import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:fnews_app/modules/login.dart';
import 'package:fnews_app/shared/cubit/bloc.dart';
import 'package:fnews_app/shared/cubit/state.dart';
import 'package:fnews_app/shared/local/chash_helper.dart';

class seting extends StatefulWidget {
  const seting({Key? key}) : super(key: key);

  @override
  State<seting> createState() => _setingState();
}

class _setingState extends State<seting> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, appstate>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LocaleText(
                  'Setting',
                  style: TextStyle(color: Colors.black, fontSize: 32),
                ),
                SizedBox(
                  height: 25,
                ),
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black)),
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          LocaleText(
                            'langage',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          PopupMenuButton(
                              onSelected: (result) {
                                if (result == 0) {
                                  LocaleNotifier.of(context)!.change('ar');
                                } else if (result == 1) {
                                  LocaleNotifier.of(context)!.change('en');
                                } else if (result == 2) {}
                              },
                              icon: Icon(
                                Icons.expand_more,
                                color: Colors.black,
                              ),
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Text('arapic'),
                                          Spacer(),
                                          Image(
                                              width: 18,
                                              height: 18,
                                              image: NetworkImage(
                                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/2560px-Flag_of_Egypt.svg.png'))
                                        ],
                                      ),
                                      value: 0,
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Text('english'),
                                          Spacer(),
                                          Image(
                                              width: 18,
                                              height: 18,
                                              image: NetworkImage(
                                                  'https://www.worldatlas.com/r/w960-q80/img/flag/au-flag.jpg'))
                                        ],
                                      ),
                                      value: 1,
                                    ),
                                  ])
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black)),
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          LocaleText(
                            'mood',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                appcubit.get(context).changethem();
                              },
                              icon: appcubit.get(context).isdark
                                  ? Icon(
                                      Icons.light_mode_outlined,
                                      color: Colors.black,
                                    )
                                  : Icon(Icons.dark_mode_outlined))
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black)),
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          LocaleText(
                            'signout',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                                   appcubit.get(context).logout();
                              appcubit.get(context).getlogout();

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return login();
                              }));

                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
