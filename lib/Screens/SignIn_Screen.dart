import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freej/NetworkManagement/SignIn_Controller.dart';
import 'package:freej/Screens/Main_Screen.dart';
import 'package:freej/models/constances.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:freej/Screens/SignUp_Screen.dart';
import 'package:freej/Screens/Verify_Screen.dart';

class SignInScreen extends StatefulWidget {
  static const route = 'SignInScreen';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String id;
  @override
  Widget build(BuildContext context) {
    // WillPopScope is used to prevent disable back button
    return WillPopScope(
      onWillPop: () {},
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kDarkPurple,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Freej",
                style: kLargeTextStyle,
              ),
              SizedBox(height: 200),
              k_PlaceHolder(BeautyTextfield(
                placeholder: 'Enter KFUPM ID',
                cornerRadius: BorderRadius.all(Radius.circular(20)),
                margin: EdgeInsets.all(0),
                height: 50,
                width: MediaQuery.of(context).size.width,
                prefixIcon: Icon(Icons.perm_identity),
                inputType: TextInputType.text,
                onChanged: (value) {
                  id = value;
                },
              )),
              k_BasicButton(
                  text: 'SignIn',
                  onPressed: () async {
                    print('button Pressed,SingIn');
                    if (id != null) {
                      print('Id != null,SingIn');
                      SignInController signInController = SignInController(id: id);
                      if (await signInController.isSignedUp(ID: id)) {
                        var result = await Navigator.push(
                            context, MaterialPageRoute(builder: (context) => VerifyScreen(id: id)));
                        if (result)
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => MainScreen(id: id)));
                      } else {
                        print('User Not Found,SingIn');
                        var signUpInfo = await showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding:
                                  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: SignUpScreen(id),
                            ),
                          ),
                        );
                        print('SingUp Info Taken,SingIn');
                        print('SignUp info = $signUpInfo');
                        bool signUpResult =
                            await signInController.signUpStudent(signUpInfo: signUpInfo);
                        print('Is student signedUp = $signUpResult');
                        if (signUpResult)
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => MainScreen(id: id)));
                        else {
                          //TODO: mush show err dialog with the reason
                        }
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
