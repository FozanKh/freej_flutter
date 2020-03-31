import 'dart:math';

import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freej/models/constances.dart';
import 'package:freej/NetworkManagement/SignIn_Controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyScreen extends StatefulWidget {
  VerifyScreen({@required this.id = null});
  final id;
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String inputOTP;
  String otp;

  @override
  void initState() {
    otp = Random().nextInt(9999).toString();
    print(otp);
    SignInController().verifySignUp(id: widget.id, otp: otp);
  }

  Widget build(BuildContext context) {
    Future<void> setUserStatus(id) async {
      SharedPreferences localData = await SharedPreferences.getInstance();
      await localData.setString('id', widget.id);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: k_DarkPurple,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text('Verification code is Sent to your KFUPM',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, color: Colors.white)),
              ),
              SizedBox.fromSize(
                size: Size.fromHeight(20),
              ),
              k_PlaceHolder(BeautyTextfield(
                placeholder: '****',
                cornerRadius: BorderRadius.all(Radius.circular(20)),
                margin: EdgeInsets.all(0),
                height: 50,
                width: MediaQuery.of(context).size.width,
                prefixIcon: Icon(Icons.sms),
                inputType: TextInputType.number,
                onChanged: (value) {
                  inputOTP = value;
                },
              )),
              k_BasicButton(
                  text: 'SignIn',
                  onPressed: () async {
                    if (inputOTP != null && inputOTP.length == 4) {
                      if (inputOTP == otp) {
                        await setUserStatus(widget.id);
                        Navigator.pop(context, true);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)), //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                            child: Text(
                                          'Invalid verificatoin code',
                                          style: TextStyle(fontSize: 18),
                                        )),
                                        k_BasicButton(
                                            text: 'try again',
                                            size: 'small',
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
//                      Navigator.pop(context, false);
                      }
                    }
                  }),
            ],
          )),
        ),
      ),
    );
  }
}
