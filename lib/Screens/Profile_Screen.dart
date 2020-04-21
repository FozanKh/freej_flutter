import 'package:flutter/material.dart';
import 'package:freej/models/constances.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final student;
  ProfileScreen(this.student);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

Future<void> logoutUser() async {
  SharedPreferences localData = await SharedPreferences.getInstance();
  await localData.clear();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kDarkPurple,
        body: Column(
          children: <Widget>[
            Text('Profile', style: kLargeTextStyle),
            k_BasicButton(
                onPressed: () async {
                  await logoutUser();
                  Navigator.pop(context, 'MainScreenLogOut');
                },
                text: 'LogOut'),
          ],
        ),
      ),
    );
  }
}
