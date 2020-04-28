import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freej/models/constances.dart';
import 'package:http/http.dart' as http;

const postAnnouncementURL = "http://freejapp.com/FreejAppRequest/PostAnnouncements.php";

class AddAnnouncement extends StatelessWidget {
  AddAnnouncement(this.UserID);
  final UserID;
  String title = 'General';
  String description;
  String AnTID = '1';
  final titlesList = [
    Text(
      'General',
      style: kListTextStyle,
    ),
    Text(
      'Specific',
      style: kListTextStyle,
    ),
    Text(
      'Technical',
      style: kListTextStyle,
    ),
  ];
  Map<String, String> param = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: kInactiveCardColour,
      ),
      padding: EdgeInsets.only(top: 50, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Write your activity",
            style: kLargeTextStyle.copyWith(fontSize: 30),
          ),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 100,
            alignment: Alignment.center,
            child: CupertinoPicker(
              backgroundColor: kInactiveCardColour,
              itemExtent: 30,
              onSelectedItemChanged: (index) {
                AnTID = (index + 1).toString();
                title = titlesList[index].data;
              },
              children: titlesList,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 50,
            width: MediaQuery.of(context).size.width - 100,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Description",
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  gapPadding: 5,
                  borderSide: BorderSide(color: Colors.purple, style: BorderStyle.solid),
                ),
              ),
              onChanged: (value) {
                description = value;
              },
            ),
          ),
          SizedBox(height: 10),
          kBasicButton(
            size: 'small',
            text: 'ADD',
            onPressed: () async {
              print(DateTime.now().toString());
              print(title);
              if (description != null && title != null) {
                param.addAll({
                  'AnTID': AnTID,
                  'UserID': UserID.toString(),
                  'Title': title,
                  'Descrp': description,
                  'Stat': 'Active'
                });
                print(param);
                http.Response response = await http.post(postAnnouncementURL, body: param);
                print('Adding activity result ${response.statusCode}');
                if (response.statusCode == 201) Navigator.pop(context);
              }
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
