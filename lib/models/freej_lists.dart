import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:freej/models/constances.dart';
import 'package:freej/models/freej_tile.dart';
import 'package:http/http.dart' as http;
import 'package:freej/models/student.dart';

const GetAnnouncementURL = 'http://freejapp.com/FreejAppRequest/GetAnnouncements.php';
const GetAllBuildingsURL = 'http://freejapp.com/FreejAppRequest/getAllBuildings.php';
const GetStudentActivitiesURL = 'http://freejapp.com/FreejAppRequest/GetActivitiesPerStudent.php';
const GetSessionDataURL = 'http://freejapp.com/FreejAppRequest/iOSApp/GetSessionData.php';
//const GetActivitiesURL = "http://freejapp.com/FreejAppRequest/GetActivities.php";
const PostAnnouncementURL = "http://freejapp.com/FreejAppRequest/PostAnnouncements.php";
const PostActivityURL = "http://freejapp.com/FreejAppRequest/PostActivity.php";

class FreejLists extends ChangeNotifier {
  Student student;
  Map<String, String> sessionData = {};
  List<FreejTile> announcements = [];
  List<FreejTile> activities = [];
  List<FreejTile> studentActivities = [];
  List<dynamic> activityTypes = [];
  List<Text> buildings = [];
  String groupURL;

  Future<void> getSessionData({bool notify = false}) async {
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
            acTID: activity['AcTID'],
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
      getStudentActivities();
      if (notify) notifyListeners();
    }
  }

//--------------------------------------------------------------------------------------------------

  Future<bool> addAnnouncement({String anTID, String description, String title}) async {
    Map<String, String> param = {
      'AnTID': anTID,
      'UserID': student.UserID,
      'Title': title,
      'Descrp': description,
      'Stat': 'Active',
    };
    http.Response response = await http.post(PostAnnouncementURL, body: param);
    if (response.statusCode == 201) {
      await refreshAnnouncement();
      return true;
    } else
      return false;
  }

  Future<void> refreshAnnouncement() async {
    http.Response response = await http.post(GetAnnouncementURL);
    var data = jsonDecode(response.body);
    List<FreejTile> tempList = [];
    for (var announcement in data) {
      tempList.add(
        FreejTile(
          title: announcement['Title'],
          description: announcement['Descrp'],
          id: announcement['AnID'],
          anTID: announcement['AnTID'],
        ),
      );
    }
    announcements = (tempList);
    notifyListeners();
  }

//--------------------------------------------------------------------------------------------------

  Future<bool> addActivity({String acTID, String description, String title}) async {
    Map<String, String> param = {
      'AcTID': acTID,
      'UserID': student.UserID,
      'Title': title,
      'Descrp': description,
      'SDate': '0000',
      'IconURL': '0',
      'Stat': 'Active'
    };
    http.Response response = await http.post(PostActivityURL, body: param);
    if (response.statusCode == 201) {
      await refreshActivities();
      return true;
    } else
      return false;
  }

  Future<void> refreshActivities() async {
    //TODO: Replace GetSessionURL with getActivitiesURL
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
            acTID: activity['AcTID'],
          ),
        );
        print('ActivityListUpdated');
      }
      activities = temp;
      notifyListeners();
    }
  }

//--------------------------------------------------------------------------------------------------
  Future<void> getStudentActivities() async {
    http.Response response =
        await http.post(GetStudentActivitiesURL, body: {'UserID': student.UserID});
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      List<FreejTile> temp = [];
      for (var activity in data) {
        temp.add(FreejTile(
            title: activity['Title'],
            description: activity['Descrp'],
            id: activity['AcID'],
            acTID: activity['AcTID'],
            deletable: true));
      }
      studentActivities = temp;
      notifyListeners();
    }
  }
}
