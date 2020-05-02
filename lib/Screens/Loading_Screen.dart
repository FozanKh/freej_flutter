import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freej/Screens/Main_Screen.dart';
import 'package:freej/Screens/SignIn_Screen.dart';
import 'package:freej/models/constances.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  static const route = 'LoadingScreen';

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
      print('Saved Id = $id, Loading Screen');
      await Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(id: id)));
    } else {
      print('No saved ID, Loading Screen');
    }
    while (true) {
      await Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    }
    //TODO: Handle log out
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkPurple,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
        ),
      ),
    );
  }
}
