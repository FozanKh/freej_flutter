import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:freej/models/constances.dart';
import 'package:freej/models/freej_tile.dart';
import 'package:http/http.dart' as http;
import 'package:freej/models/student.dart';

const getAnnouncementURL = 'http://freejapp.com/FreejAppRequest/GetAnnouncements.php';
const getAllBuildingsURL = 'http://freejapp.com/FreejAppRequest/getAllBuildings.php';
//const getActivitiesURL = "http://freejapp.com/FreejAppRequest/GetActivities.php";
const GetSessionDataURL = 'http://freejapp.com/FreejAppRequest/iOSApp/GetSessionData.php';

class FreejLists extends ChangeNotifier {
  Student student;
  Map<String, String> sessionData = {};
  List<FreejTile> announcements = [];
  List<FreejTile> activities = [];
  List<Text> buildings = [];
  List<dynamic> activityTypes = [];
  String groupURL;

  Future<void> getSessionData() async {
    print('BNo = ${student.BNo}, UserID = ${student.UserID}');
    http.Response response =
        await http.post(GetSessionDataURL, body: {'BNo': student.BNo, 'UserID': student.UserID});
    if (response.statusCode == 201) {
      print('SessionLoaded');
      var data = jsonDecode(response.body);

      //StartLoading Lists -------------------------------------------------------------------------
      List<FreejTile> tempList = []; //Announcements, Activities
      List<Text> tempTextList = []; //Buildings

      //ActivityType
      activityTypes = data['ActivityType'];

      //Activities
      for (var activity in data['Activity']) {
        tempList.add(
          FreejTile(
            title: activity['Title'],
            description: activity['Descrp'],
            id: activity['AcID'],
          ),
        );
      }
      print('ActivityListUpdated');
      activities = tempList;

      //Announcements
      tempList = [];
      for (var announcement in data['Announcement']) {
        tempList.add(FreejTile(
            title: announcement['Title'],
            description: announcement['Descrp'],
            id: announcement['AnID']));
      }
      print('AnnouncementListUpdated');
      announcements = tempList;

      //groupURL
      groupURL = data['groupURL'];
      print('GroupLinkUpdated');
      print(data['groupURL']);

      //Buildings
      for (var BNo in data['Building']) {
        tempTextList.add(Text(
          BNo['BNo'],
          style: kListTextStyle,
        ));
      }
      buildings = tempTextList;
      print('BuildingsListUpdated');
    }
  }

//--------------------------------------------------------------------------------------------------

  Future<void> getAnnouncements() async {
    http.Response response = await http.post(getAnnouncementURL);
    var data = jsonDecode(response.body);
    List<FreejTile> tempList = [];
    for (var announcement in data) {
      tempList.add(FreejTile(
          title: announcement['Title'],
          description: announcement['Descrp'],
          id: announcement['AnID']));
    }
    announcements = (tempList);
    notifyListeners();
  }

  addAnnouncement(String title, String description, String id) {
    announcements.add(FreejTile(title: title, description: description, id: id));
    notifyListeners();
  }

//--------------------------------------------------------------------------------------------------

  Future<void> getActivities(student) async {
    http.Response response =
        await http.post(GetSessionDataURL, body: {'BNo': student.BNo, 'UserID': student.UserID});
    if (response.statusCode == 201) {
      print('SessionLoaded');
      var data = jsonDecode(response.body)['Activity'];
      List<FreejTile> temp = [];
      for (var activity in data) {
        temp.add(
          FreejTile(
            title: activity['Title'],
            description: activity['Descrp'],
            id: activity['AcID'],
          ),
        );
        print('ActivityListUpdated');
      }
      activities = temp;
      notifyListeners();
    }
  }

//--------------------------------------------------------------------------------------------------

}
