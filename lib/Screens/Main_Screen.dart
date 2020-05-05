import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:freej/models/constances.dart';
import 'package:freej/Screens/Announcement_Screen.dart';
import 'package:freej/Screens/Profile_Screen.dart';
import 'package:freej/Screens/Activities_Screen.dart';
import 'package:freej/models/freej_lists.dart';
import 'package:freej/models/student.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const route = 'MainScreen';
  final id;
  MainScreen({this.id});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Student student;
  List<Widget> screens = List();

  @override
  void initState() {
    getStudent();
    screens
        .addAll([AnnouncementScreen(student), ActivitiesScreen(student), ProfileScreen(student)]);
    currentScreen = screens[1];
//    Provider.of<FreejLists>(context, listen: false).getAnnouncements();
  }

  Future<void> getStudent() async {
    student = Student(KFUPMID: widget.id);
    await student.getStudentData();
    Provider.of<FreejLists>(context, listen: false).student = student;
    Provider.of<FreejLists>(context, listen: false).getSessionData();
  }

  Widget currentScreen;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: SafeArea(
        child: Scaffold(
            backgroundColor: kDarkPurple,
            bottomNavigationBar: CurvedNavigationBar(
              index: 1,
              animationDuration: Duration(milliseconds: 300),
              height: 60,
              backgroundColor: kDarkPurple,
              color: Colors.white,
              items: <Widget>[
                Icon(Icons.all_out, size: 30),
                Icon(Icons.list, size: 30),
                Icon(Icons.settings, size: 30),
              ],
              onTap: (index) async {
                //TODO : Make a better way to refresh the Lists

                setState(() {
                  currentScreen = screens[index];
                });
                //Handle button tap
              },
            ),
            body: currentScreen),
      ),
    );
  }
}
