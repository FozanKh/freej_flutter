import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const getStudentURL = "http://freejapp.com/FreejAppRequest/GetStudent.php";

class Student {
  final KFUPMID;
  String UserID;
  String BNo;
  String FName;
  String LName;
  String Gender;
  String Stat;
  bool isAmeen;

  Student({@required this.KFUPMID});

  getStudentData() async {
    http.Response response = await http.post(getStudentURL, body: {'KFUPMID': this.KFUPMID});
    var data = await jsonDecode(response.body)[0];
    this.UserID = data['UserID'];
    this.BNo = data['BNo'];
    this.FName = data['FName'];
    this.LName = data['LName'];
    this.Gender = data['Gender'];
    this.Stat = data['Stat'];
    this.isAmeen = (data['IsAmeen'] == 'false') ? false : true;
  }
}
