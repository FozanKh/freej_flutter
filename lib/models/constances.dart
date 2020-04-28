import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const kDarkPurple = Color(0xFF0A0E21);
const kDarkPurplelight = Color(0x550A0E21);
const kActiveCardColour = Color(0xFF1D1E33);
const kInactiveCardColour = Color(0xFF111328);
const kSettingTextStyle = TextStyle(
  fontSize: 20,
);
const kLargeTextStyle = TextStyle(
  fontSize: 50,
  color: Colors.white70,
  fontFamily: 'BalooDa2',
);
const kListTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontFamily: 'BalooDa2',
);

const InputDecoration kSignUpTFDecoration = InputDecoration(
  counter: Offstage(),
  filled: true,
  hintText: 'Enter KFUPM ID',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
);

Container kLoading() => Container(
      height: 50,
      width: 50,
      child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
    );

Container kPlaceHolder(Widget widget, {Color color = null}) => Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)]),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
      height: 70,
      width: 330,
      child: widget,
    );

Container kBasicButton(
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

class kBackgroundContainer extends StatefulWidget {
  final child;
  final color;
  final position;
  final margin;
  final padding;
  kBackgroundContainer({this.child, this.color, this.position, this.margin, this.padding});

  @override
  _kBackgroundContainerState createState() => _kBackgroundContainerState();
}

class _kBackgroundContainerState extends State<kBackgroundContainer> {
  @override
  Radius topRadius;
  Radius bottomRadius;
  EdgeInsets margin;
  EdgeInsets padding;

  void initState() {
    margin =
        (widget.margin != null) ? widget.margin : EdgeInsets.only(bottom: 20, left: 10, right: 10);
    padding = (widget.padding != null) ? widget.padding : EdgeInsets.fromLTRB(10, 25, 10, 15);

    switch (widget.position) {
      case 'top':
        topRadius = Radius.circular(40);
        bottomRadius = Radius.circular(15);
        break;
      case 'bottom':
        topRadius = Radius.circular(15);
        bottomRadius = Radius.circular(40);
        break;
      case 'alone':
        topRadius = Radius.circular(40);
        bottomRadius = Radius.circular(40);
        break;
      default:
        topRadius = Radius.circular(15);
        bottomRadius = Radius.circular(15);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.vertical(
          top: topRadius,
          bottom: bottomRadius,
        ),
      ),
      child: widget.child,
    );
  }
}

class kTextField extends StatefulWidget {
  @override
  _kTextFieldState createState() => _kTextFieldState();
}

class _kTextFieldState extends State<kTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)]),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
      height: 70,
      width: 330,
      child: TextField(),
    );
  }
}
