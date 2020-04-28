import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:freej/models/freej_tile.dart';
import 'package:http/http.dart' as http;

const getAnnouncementURL = "http://freejapp.com/FreejAppRequest/GetAnnouncements.php";
//const getActivitiesURL = "http://freejapp.com/FreejAppRequest/GetActivities.php";
const GetSessionDataURL = 'http://freejapp.com/FreejAppRequest/GetSessionData.php';

class FreejLists extends ChangeNotifier {
  List<FreejTile> announcements = [];
  List<FreejTile> activities = [];

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
      }
      activities = temp;
      notifyListeners();
    }
  }

//  Future<void> getActivities() async {
//    http.Response response = await http.post(getAnnouncementURL);
//    var data = jsonDecode(response.body);
//    List<FreejTile> tempList = [];
//    for (var announcement in data) {
//      tempList.add(FreejTile(
//          title: announcement['Title'],
//          description: announcement['Descrp'],
//          id: announcement['AnID']));
//    }
//    announcements = (tempList);
//    notifyListeners();
//  }

//  $Announcement_AnID = $row['AnID'];
//  $Announcement_AnTID = $row['AnTID'];
//        $Announcement_UserID = $row['UserID'];
//        $Announcement_Title = $row['Title'];
//    	$Announcement_Descrp = $row['Descrp'];
//    	$Announcement_SDate = $row['SDate'];
//	    $Announcement_Stat = $row['Stat'];

//  addAnnouncement(User user) {}
//  addRequest() {}

}
