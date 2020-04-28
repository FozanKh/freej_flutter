import 'package:flutter/material.dart';
import 'package:freej/models/constances.dart';

class SignUpScreen extends StatefulWidget {
  static const route = 'SignUpScreen';
  SignUpScreen(this.id);
  final String id;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String FName;

  String LName;

  String BNo;

  Map<String, String> result = {};

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
            "Please Sign Up",
            style: kLargeTextStyle.copyWith(fontSize: 30),
          ),
          Text(
            "Enter Your Information",
            style: kLargeTextStyle.copyWith(fontSize: 30),
          ),
          SizedBox(height: 100),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
            height: 70,
            width: 330,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "First Name",
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  gapPadding: 5,
                  borderSide: BorderSide(),
                ),
              ),
              onChanged: (value) {
                FName = value;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
            height: 70,
            width: 330,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Last Name",
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  gapPadding: 5,
                  borderSide: BorderSide(color: Colors.purple, style: BorderStyle.solid),
                ),
              ),
              onChanged: (value) {
                LName = value;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
            height: 70,
            width: 330,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                labelText: "Building Number",
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  gapPadding: 5,
                  borderSide: BorderSide(color: Colors.purple, style: BorderStyle.solid),
                ),
              ),
              onChanged: (value) {
                BNo = value;
              },
            ),
          ),
          SizedBox(height: 20),
          kBasicButton(
              text: 'SignUp',
              onPressed: () async {
                if (FName != null && LName != null) {
                  result.addAll({
                    'BNo': BNo,
                    'FName': FName,
                    'LName': LName,
                    'KFUPMID': widget.id,
                    'Gender': 'M',
                    'Status': 'Unactivated'
                  });
                  Navigator.pop(context, result);
                }
              }),
        ],
      ),
    );
  }
}
