import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freej/models/constances.dart';
import 'package:freej/models/freej_lists.dart';
import 'package:freej/models/freej_tile.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

const GetMyActivitiesURL = 'http://freejapp.com/FreejAppRequest/GetActivitiesPerStudent.php';

class MyActivitiesView extends StatefulWidget {
  final UserID;
  MyActivitiesView(this.UserID);
  @override
  _MyActivitiesViewState createState() => _MyActivitiesViewState();
}

class _MyActivitiesViewState extends State<MyActivitiesView> {
  List<FreejTile> myActivitiesList = [];

  @override
  void initState() {
    getMyActivities();
  }

  Future<void> getMyActivities() async {
    http.Response response = await http.post(GetMyActivitiesURL, body: {'UserID': widget.UserID});
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      List<FreejTile> temp = [];
      for (var activity in data) {
        temp.add(FreejTile(
            title: activity['Title'],
            description: activity['Descrp'],
            id: activity['AcID'],
            deletable: true));
      }
      myActivitiesList = temp;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FreejLists>(
      builder: (context, announcementList, child) => SafeArea(
        child: Scaffold(
          backgroundColor: kDarkPurple,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white70,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('My Activities', style: kLargeTextStyle),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 15,
                child: kBackgroundContainer(
                  margin: EdgeInsets.fromLTRB(10, 25, 10, 50),
                  position: 'alone',
                  color: Colors.white,
                  child: ListView(
                    children: myActivitiesList,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
