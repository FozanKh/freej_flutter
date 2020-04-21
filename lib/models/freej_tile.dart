import 'package:flutter/material.dart';

class FreejTile extends StatelessWidget {
  final title;
  final description;
  final id;

  FreejTile({this.title, this.description, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: EdgeInsets.all(10),
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade700.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            Icons.print,
            size: 60,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade900.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: <Widget>[
                  Text(title),
                  Expanded(child: SingleChildScrollView(child: Text(description))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
