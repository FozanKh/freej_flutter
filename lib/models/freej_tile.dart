import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const deleteActivityURL = 'http://freejapp.com/FreejAppRequest/DeleteActivity.php';

class FreejTile extends StatelessWidget {
  final title;
  final description;
  final id;
  final deletable;
  final acTID;
  final anTID;
  List<Widget> tileLead;
  IconData tileIcon = Icons.surround_sound;
  String reqType;

  FreejTile(
      {this.title,
      this.description,
      this.id,
      this.deletable = false,
      this.acTID = null,
      this.anTID = null}) {
    tileLead = [];
    if (acTID != null) {
      switch (acTID) {
        case '0':
          reqType = 'Request';
          tileIcon = Icons.add_box;
          break;
        case '1':
          reqType = 'Service';
          tileIcon = Icons.beenhere;
          break;
        case '2':
          reqType = 'Maintenance';
          tileIcon = Icons.settings;
          break;
        case '3':
          reqType = 'Entertainment';
          tileIcon = Icons.videogame_asset;
          break;
        default:
          reqType = 'Actvity';
          tileIcon = Icons.add_circle_outline;
      }

      tileLead.add(
        Text(
          reqType,
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      );
    }
    tileLead.add(
      Icon(
        tileIcon,
        size: 60,
      ),
    );
    if (deletable) {
      tileLead.add(GestureDetector(
        onLongPress: () async {
          http.Response response = await http.post(deleteActivityURL, body: {'AcID': id});
          if (response.statusCode == 201) print('Activity Deleted');
        },
        child: Text(
          'Delete',
          style: TextStyle(fontSize: 10, color: Colors.red),
        ),
      ));
    }
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tileLead,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 15),
                  ),
                  Divider(
                    indent: MediaQuery.of(context).size.width / 20,
                    endIndent: MediaQuery.of(context).size.width / 20,
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Text(
                    description,
                    textAlign: TextAlign.center,
                  ))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
