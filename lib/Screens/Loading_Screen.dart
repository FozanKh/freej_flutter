import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freej/Screens/Main_Screen.dart';
import 'package:freej/Screens/SignIn_Screen.dart';
import 'package:freej/models/constances.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freej/models/freej_lists.dart';

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
    print('im here at the Loading Screen, getuser');
    if (localData.containsKey('id')) {
      var id = await localData.get('id');
      print('Saved Id = $id, Loading Screen');
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(id: id)));
    } else {
      print('No saved ID, Loading Screen');
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
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
