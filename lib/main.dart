import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freej/Screens/Loading_Screen.dart';
import 'package:provider/provider.dart';
import 'package:freej/models/freej_lists.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ChangeNotifierProvider(
      create: (context) => FreejLists(),
      child: MaterialApp(
//        theme: ThemeData.dark().copyWith(accentColor: Colors.white),
        theme: ThemeData(fontFamily: 'BalooDa2'),
        debugShowCheckedModeBanner: true,
        color: Colors.deepPurple,
        home: LoadingScreen(),
//      initialRoute: LoadingScreen.route,
//      routes: {
//        LoadingScreen.route: (context) => LoadingScreen(),
//        SignInScreen.route: (context) => SignInScreen(),
//        MainScreen.route: (context) => MainScreen(),
//        VerifyScreen.route: (context) => VerifyScreen()
//      },
      ),
    );
  }
}
