import 'package:flutter/material.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:freej/models/constances.dart';
import 'package:freej/NetworkManagement/SignIn_Controller.dart';
import 'Main_Screen.dart';

class SignUpScreen extends StatelessWidget {
  static const route = 'SignUpScreen';
  SignUpScreen(this.id);
  final String id;
  String FName;
  String LName;
  String BNo;
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
          k_PlaceHolder(BeautyTextfield(
            placeholder: 'First Name',
            cornerRadius: BorderRadius.all(Radius.circular(20)),
            margin: EdgeInsets.all(0),
            height: 50,
            width: MediaQuery.of(context).size.width,
            prefixIcon: Icon(Icons.person),
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
            prefixIcon: Icon(Icons.person_outline),
            inputType: TextInputType.text,
            onChanged: (value) {
              LName = value;
              print(LName);
            },
          )),
          k_PlaceHolder(BeautyTextfield(
            placeholder: 'Building Number',
            cornerRadius: BorderRadius.all(Radius.circular(20)),
            margin: EdgeInsets.all(0),
            height: 50,
            width: MediaQuery.of(context).size.width,
            prefixIcon: Icon(Icons.business),
            inputType: TextInputType.number,
            onChanged: (value) {
              BNo = value;
            },
          )),
          SizedBox(height: 20),
          k_BasicButton(
              text: 'SignUp',
              onPressed: () async {
                print('SignUp Button Pressed');
                //TODO: Verify the inputted values
                print('SignUp Info = ${{
                  'BNo': BNo,
                  'FName': FName,
                  'LName': LName,
                  'id': id
                }}, SingUp Screen');

                Navigator.pop(context, {
                  'BNo': BNo,
                  'FName': FName,
                  'LName': LName,
                  'KFUPMID': id,
                  'Gender': 'M',
                  'Status': 'Unactivated'
                });
//                var result = await SignInController()
//                    .signUpStudent(BNo: BNo, FName: FName, LName: LName, id: id, context: context);
//                Navigator.pop(context, result);
              }),
        ],
      ),
    );
  }
}
