import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const getStudentURL = "http://freejapp.com/FreejAppRequest/GetStudent.php";

class Student {
  final KFUPMID;
  String userID;
  String bNo;
  String fName;
  String lName;
  String gender;
  String stat;
  bool isAmeen;

  Student({@required this.KFUPMID});

  getStudentData() async {
    http.Response response = await http.post(getStudentURL, body: {'KFUPMID': this.KFUPMID});
    var data = await jsonDecode(response.body)[0];
    this.userID = data['UserID'];
    this.bNo = data['BNo'];
    this.fName = data['FName'];
    this.lName = data['LName'];
    this.gender = data['Gender'];
    this.stat = data['Stat'];
    this.isAmeen = (data['IsAmeen'] == 'false') ? false : true;
  }
}
