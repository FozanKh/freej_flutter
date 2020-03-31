import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freej/Screens/Main_Screen.dart';
import 'package:freej/Screens/SignIn_Screen.dart';
import 'package:freej/models/constances.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getUserStatus();
  }

  Future<void> getUserStatus() async {
    SharedPreferences localData = await SharedPreferences.getInstance();
    if (localData.containsKey('id')) {
      var id = await localData.get('id');
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(id)));
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: k_DarkPurple,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
        ),
      ),
    );
  }
}
