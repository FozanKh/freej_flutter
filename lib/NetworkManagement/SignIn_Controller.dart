import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freej/Screens/Verify_Screen.dart';
import 'package:http/http.dart' as http;

const IsSignedUpURL = "http://freejapp.com/FreejAppRequest/CheckUserSignUpStatus.php";
const signUpURL = "http://freejapp.com/FreejAppRequest/PostStudent.php";
const sendOTPURL = "http://freejapp.com/FreejAppRequest/SendOTP.php";
const getStudentURL = "http://freejapp.com/FreejAppRequest/GetStudent.php";

class SignInController {
  String id;
  SignInController({this.id});

//------------------------------------------------------------------------------

  Future<bool> signedIn({String ID}) async {
    (ID == null) ? id : ID;
  }

  Future<bool> isSignedUp({String ID}) async {
    var params = {'KFUPMID': ID};
    http.Response response = await http.post(IsSignedUpURL, body: params);
    if (response.statusCode == 201) {
      print('Student found!');
      return true;
    } else {
      print('Error#${response.statusCode}: Student not found!');
      return false;
    }
  }

  Future<bool> getStudent({@required String ID}) async {
    var params = {'KFUPMID': ID};
    http.Response response = await http.post(getStudentURL, body: params);
    if (response.statusCode == 201) {
      print('Student found!');
      return true;
    } else {
      print('Error#${response.statusCode}: Student not found!');
      return false;
    }
  }

  Future<bool> signUpStudent(
      {BuildContext context,
      @required String BNo,
      @required String FName,
      @required String LName,
      @required String id}) async {
    var params = {
      'BNo': BNo,
      'FName': FName,
      'LName': LName,
      'KFUPMID': id,
      'Gender': 'M',
      'Status': 'Unactivated'
    };
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => VerifyScreen(id: id)));

    if (!result) return false;

    http.Response response = await http.post(signUpURL, body: params);

    if (response.statusCode == 201) {
      print('Student Added Succesfully');
      return true;
    } else {
      print('Error#${response.statusCode}: Student could not be Added');
      return false;
    }
  }

  Future<bool> verifySignUp({@required String id, @required String otp}) async {
//    String email = '$id@kfupm.edu.sa';
    String email = 'fozan.kh@icloud.com';

    if (/*await sendOTP(email: email, otp: otp)*/ true) {
      print("code Sent");
      return true;
    } else
      return false;
  }

  Future<bool> sendOTP({@required String email, @required String otp}) async {
    var params = {'to': email, 'otp': otp};
    http.Response response = await http.post(sendOTPURL, body: params);
    return (response.statusCode == 201) ? true : false;
  }
}
