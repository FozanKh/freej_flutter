import 'package:flutter/material.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:freej/models/constances.dart';
import 'package:freej/NetworkManagement/SignIn_Controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'Main_Screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen(this.id);
  final id;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ProgressDialog pr;
  String FName;
  String LName;
  String BNo;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF0A0E21),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Please Sign Up",
              style: k_LargeTextStyle.copyWith(fontSize: 30),
            ),
            Text(
              "Enter Your Information",
              style: k_LargeTextStyle.copyWith(fontSize: 30),
            ),
            SizedBox(height: 100),
            k_PlaceHolder(BeautyTextfield(
              placeholder: 'First Name',
              cornerRadius: BorderRadius.all(Radius.circular(20)),
              margin: EdgeInsets.all(0),
              height: 50,
              width: MediaQuery.of(context).size.width,
              prefixIcon: Icon(Icons.perm_identity),
              inputType: TextInputType.text,
              onChanged: (value) {
                FName = value;
              },
            )),
            k_PlaceHolder(BeautyTextfield(
              placeholder: 'Last Name',
              cornerRadius: BorderRadius.all(Radius.circular(20)),
              margin: EdgeInsets.all(0),
              height: 50,
              width: MediaQuery.of(context).size.width,
              prefixIcon: Icon(Icons.perm_identity),
              inputType: TextInputType.text,
              onChanged: (value) {
                LName = value;
              },
            )),
            k_PlaceHolder(BeautyTextfield(
              placeholder: 'Building Number',
              cornerRadius: BorderRadius.all(Radius.circular(20)),
              margin: EdgeInsets.all(0),
              height: 50,
              width: MediaQuery.of(context).size.width,
              prefixIcon: Icon(Icons.perm_identity),
              inputType: TextInputType.number,
              onChanged: (value) {
                BNo = value;
              },
            )),
            SizedBox(height: 20),
            k_BasicButton(
                text: 'SignUp',
                onPressed: () async {
                  pr = ProgressDialog(context);
                  pr.show();
                  var result = await SignInController().signUpStudent(
                      BNo: BNo, FName: FName, LName: LName, id: widget.id, context: context);
                  pr.hide();
                  if (result)
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => MainScreen(widget.id)));
                }),
          ],
        ),
      ),
    );
  }
}
