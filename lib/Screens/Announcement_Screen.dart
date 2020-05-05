import 'package:flutter/material.dart';
import 'package:freej/Screens/add_announcement_view.dart';
import 'package:freej/models/constances.dart';
import 'package:freej/models/freej_lists.dart';
import 'package:provider/provider.dart';

class AnnouncementScreen extends StatefulWidget {
  final student;
  AnnouncementScreen(this.student);

  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  FloatingActionButton ameenBtn;

  @override
  void initState() {
    isAmeen();
  }

  void isAmeen() {
    if (widget.student.isAmeen)
      ameenBtn = FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddAnnouncement(),
              ),
            ),
          );
        },
        backgroundColor: Colors.grey.shade800,
        child: Icon(Icons.add),
      );
    else
      ameenBtn = null;
  }

  Future<void> refreshAnnouncements() async {
    await Provider.of<FreejLists>(context, listen: false).refreshAnnouncement();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FreejLists>(
      builder: (context, Freej, child) => SafeArea(
        child: Scaffold(
          floatingActionButton: ameenBtn,
          backgroundColor: kDarkPurple,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('Announcement', style: kLargeTextStyle),
                ),
              ),
              Expanded(
                flex: 15,
                child: kBackgroundContainer(
                  position: 'top',
                  color: Colors.white,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await refreshAnnouncements();
                      print('Announcement refreshed');
                    },
                    child: ListView(
                      children: Freej.announcements,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
