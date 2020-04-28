import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freej/models/constances.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const UpdateStudentInfoURL = 'http://freejapp.com/FreejAppRequest/UpdateUserInfo.php';

class EditProfile extends StatelessWidget {
  EditProfile(this.id);
  final id;
  Map<String, String> param = {};
  String newFName;
  String newLName;
  String newBNo;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kDarkPurple,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white12,
                  ),
                  onChanged: (value) {
                    newFName = value;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white12,
                  ),
                  onChanged: (value) {
                    newLName = value;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Building Number',
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white12,
                  ),
                  onChanged: (value) {
                    newBNo = value;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                kBasicButton(
                  onPressed: () async {
                    param.addAll(
                        {'KFUPMID': id, 'FName': newFName, 'LName': newLName, 'BNo': newBNo});
                    http.Response response = await http.post(UpdateStudentInfoURL, body: param);
                    if (response.statusCode == 201) Navigator.pop(context);
                  },
                  text: 'SUBMIT',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
