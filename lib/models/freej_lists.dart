import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:freej/models/freej_tile.dart';
import 'package:http/http.dart' as http;

const getAnnouncementURL = "http://freejapp.com/FreejAppRequest/GetAnnouncements.php";

class FreejLists extends ChangeNotifier {
  List<FreejTile> announcements = [];
  List<FreejTile> requests = [];

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
