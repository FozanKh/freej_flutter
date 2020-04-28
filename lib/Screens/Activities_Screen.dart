import 'package:flutter/material.dart';
import 'package:freej/models/constances.dart';
import 'package:freej/models/request_card.dart';
import 'package:freej/models/freej_lists.dart';
import 'package:freej/Screens/add_activity_view.dart';
import 'package:provider/provider.dart';

class ActivitiesScreen extends StatefulWidget {
  final student;
  ActivitiesScreen(this.student);

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  void initState() {
    getActivity();
  }

  Future<void> getActivity() async {
    await Future.delayed(Duration(milliseconds: 1500));
    Provider.of<FreejLists>(context, listen: false).getActivities(widget.student);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade800,
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddActivity(widget.student.UserID),
                ),
              ),
            );
          },
        ),
        backgroundColor: kDarkPurple,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text('Activities', style: kLargeTextStyle),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                      child: Text('Requests',
                          textAlign: TextAlign.center,
                          style: kLargeTextStyle.copyWith(fontSize: 20))),
                  Expanded(
                      child: Text('Services',
                          textAlign: TextAlign.center,
                          style: kLargeTextStyle.copyWith(fontSize: 20))),
                  Expanded(
                      child: Text('Maintenance',
                          textAlign: TextAlign.center,
                          style: kLargeTextStyle.copyWith(fontSize: 20))),
                ],
              ),
            ),
            Expanded(
              flex: 15,
//              child: GestureDetector(
              child: kBackgroundContainer(
                position: 'top',
                color: Colors.white,
                child: ListView(children: Provider.of<FreejLists>(context).activities),
              ),
            ),
//            )
          ],
        ),
      ),
    );
  }
}
