import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freej/Screens/edit_profile.dart';
import 'package:freej/models/constances.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:freej/Screens/my_activities_view.dart';

const DeleteStudentURL = 'http://freejapp.com/FreejAppRequest/DeleteStudent.php';
const WhatsAppURL = 'http://freejapp.com/FreejAppRequest/GetWhatsappURL.php';

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
            Text(
              'Profile',
              style: kLargeTextStyle,
            ),
            kBackgroundContainer(
              position: 'top',
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Edit Profile',
                        style: kSettingTextStyle,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => EditProfile(widget.student)));
                      },
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Delete account',
                        style: kSettingTextStyle,
                      ),
                      onPressed: () async {
                        if (await assureDialog()) {
                          http.Response response = await http
                              .post(DeleteStudentURL, body: {'KFUPMID': widget.student.UserID});
                          if (response.statusCode == 201) {
                            await logoutUser();
                            Navigator.pop(context, 'MainScreenLogOut');
                          }
                        }
                      },
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'My Activities',
                        style: kSettingTextStyle,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyActivitiesView(widget.student.UserID)));
                      },
                    ),
                  ],
                ),
              ),
            ),
            kBackgroundContainer(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'WhatsApp Group',
                        style: kSettingTextStyle,
                      ),
                      onPressed: () async {
                        http.Response response =
                            await http.post(WhatsAppURL, body: {'BNo': widget.student.BNo});
                        print(response.statusCode);
                        var data = jsonDecode(response.body)[0]['GroupURL'];
                        if (data != null)
                          Clipboard.setData(ClipboardData(text: data));
                        else
                          Clipboard.setData(ClipboardData(text: 'No Link'));
                      },
                    ),
                  ],
                ),
              ),
            ),
            kBackgroundContainer(
              color: Colors.white,
              position: 'bottom',
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'LogOut',
                        style: kSettingTextStyle,
                      ),
                      onPressed: () async {
                        await logoutUser();
                        Navigator.pop(context, 'MainScreenLogOut');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> assureDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      'Are You sure you want to delete you account ?',
                      style: TextStyle(fontSize: 18),
                    )),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RawMaterialButton(
                              child: Text(
                                'SURE',
                                style: kSettingTextStyle,
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                              }),
                        ),
                        Expanded(
                          child: RawMaterialButton(
                              child: Text(
                                'CANCEL',
                                style: kSettingTextStyle,
                              ),
                              onPressed: () {
                                Navigator.pop(context, false);
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
