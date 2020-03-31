import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const Color k_DarkPurple = Color(0xFF0A0E21);

const TextStyle k_LargeTextStyle = TextStyle(
  fontSize: 50,
  color: Colors.white70,
  fontFamily: 'BalooDa2',
);

const InputDecoration k_SignUpTFDecoration = InputDecoration(
  counter: Offstage(),
  filled: true,
  hintText: 'Enter KFUPM ID',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
);

Container k_Loading() => Container(
      height: 50,
      width: 50,
      child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
    );

Container k_PlaceHolder(Widget widget, {Color color = null}) => Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)]),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
      height: 70,
      width: 330,
      child: widget,
    );

Container k_BasicButton(
    {@required Function onPressed,
    String text = '',
    Color color = Colors.deepPurple,
    double height = 70,
    double width = 330,
    double fontSize = 25,
    String size = 'normal'}) {
  if (size == 'small') {
    height = 40;
    width = 230;
    fontSize = 18;
  }
  return Container(
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)]),
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
    height: height,
    width: width,
    child: RawMaterialButton(
      shape: CircleBorder(),
      elevation: 0.0,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: Colors.white, fontFamily: 'BalooDa2'),
      ),
      onPressed: onPressed,
    ),
  );
}
