import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const deleteActivityURL = 'http://freejapp.com/FreejAppRequest/DeleteActivity.php';

class FreejTile extends StatelessWidget {
  final title;
  final description;
  final id;
  final deletable;
  Widget tileIcon;

  FreejTile({this.title, this.description, this.id, this.deletable = false}) {
    if (deletable) {
      tileIcon = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.surround_sound,
            size: 60,
          ),
          GestureDetector(
            onLongPress: () async {
              http.Response response = await http.post(deleteActivityURL, body: {'AcID': id});
              if (response.statusCode == 201) print('Activity Deleted');
            },
            child: Text(
              'Delete',
              style: TextStyle(fontSize: 10, color: Colors.red),
            ),
          )
        ],
      );
    } else
      tileIcon = Icon(
        Icons.surround_sound,
        size: 60,
      );
  }

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
          tileIcon,
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
