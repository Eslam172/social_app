import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/screens/home_screen.dart';
import 'package:social_app/screens/login/login_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/network/local.dart';
import 'package:social_app/shared/network/remote.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'shared/my_bloc_observer.dart';

//import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
 // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  DioHelper.init();
  await CacheHelper.init();

   late Widget widget;
   uId = CacheHelper.getData(key: 'uId');

  if(uId != null){
    widget = const HomeScreen();
  }else {
    widget = LoginScreen();
  }

  BlocOverrides.runZoned(
        () {
      // Use cubits...
      runApp(MyApp(startWidget: widget,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
   final startWidget;

  MyApp({this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserDate(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: primaryColor,
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme:  AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20
            ),
            titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20
            ),
            actionsIconTheme: IconThemeData(
              color: primaryColor,
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark
            )
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}

