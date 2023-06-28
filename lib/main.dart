import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:fnews_app/shared/cubit/bloc.dart';
import 'package:fnews_app/shared/cubit/observer.dart';
import 'package:fnews_app/shared/cubit/state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fnews_app/shared/local/chash_helper.dart';


import 'modules/spalsh_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Locales.init(['en', 'ar']);
  Bloc.observer = MyBlocObserver();
 await cashhelper.init() ;

  runApp(myapp());
}

class myapp extends StatefulWidget {



  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  bool? isdark;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    const MaterialColor white = const MaterialColor(
      0xFFFFFFFF,
      const <int, Color>{
        50: const Color(0xFFFFFFFF),
        100: const Color(0xFFFFFFFF),
        200: const Color(0xFFFFFFFF),
        300: const Color(0xFFFFFFFF),
        400: const Color(0xFFFFFFFF),
        500: const Color(0xFFFFFFFF),
        600: const Color(0xFFFFFFFF),
        700: const Color(0xFFFFFFFF),
        800: const Color(0xFFFFFFFF),
        900: const Color(0xFFFFFFFF),
      },
    );
    return BlocProvider(
      create: (BuildContext context) => appcubit()..getdark(),
      child: BlocConsumer<appcubit, appstate>(
        listener: (context, state) {},
        builder: (context, state) {
          appcubit cubit = appcubit.get(context);
          return LocaleBuilder(
            builder: (locale) => MaterialApp(
              localizationsDelegates: Locales.delegates,
              supportedLocales: Locales.supportedLocales,
              locale: locale,
              debugShowCheckedModeBanner: false,
              theme:
                  ThemeData(brightness: Brightness.light, primarySwatch: white),
              darkTheme: ThemeData(brightness: Brightness.dark),
              themeMode: appcubit.get(context).isdark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: splashscreen(),
            ),
          );
        },
      ),
    );
  }
}
