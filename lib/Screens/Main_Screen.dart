import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:freej/models/constances.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  MainScreen(this.id);
  final id;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<void> logoutUser() async {
    SharedPreferences localData = await SharedPreferences.getInstance();
    await localData.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: SafeArea(
        child: Scaffold(
          backgroundColor: k_DarkPurple,
          bottomNavigationBar: CurvedNavigationBar(
            animationDuration: Duration(milliseconds: 300),
            height: 60,
            backgroundColor: k_DarkPurple,
            color: Colors.white,
            items: <Widget>[
              Icon(Icons.all_out, size: 30),
              Icon(Icons.list, size: 30),
              Icon(Icons.settings, size: 30),
            ],
            onTap: (index) {
              //Handle button tap
            },
          ),
          body: Column(
            children: <Widget>[
              Text(
                "hello : ${widget.id}",
                style: k_LargeTextStyle,
              ),
              k_BasicButton(
                  onPressed: () async {
                    await logoutUser();
                    Navigator.pop(context, 'MainScreenLogOut');
                  },
                  text: 'LogOut')
            ],
          ),
        ),
      ),
    );
  }
}
