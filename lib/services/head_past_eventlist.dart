import 'dart:async';
import 'dart:core';
import 'package:eventbuzz/models/eventclass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'head_past_eventtile.dart';

class head_Past_EventList extends StatefulWidget {
  final String? email;

  head_Past_EventList(this.email);
  @override
  _head_Past_EventListState createState() => _head_Past_EventListState();
}
DateTime now =DateTime.now();
int count =0;
class _head_Past_EventListState extends State<head_Past_EventList> {
  _getDateTime() {
    setState(() {
      now = DateTime.now();
    });
  }
  @override
  void initState() {
    _getDateTime();
    super.initState();
    Timer.periodic(Duration(seconds: 1), (_) => _getDateTime());
  }
  @override
  Widget build(BuildContext context) {

    final events = Provider.of<List<Events>>(context);

    return ListView.builder(
      itemCount: events.length,

      itemBuilder: (BuildContext context, int index)
      {

        final String stm, etm;
        stm = events[index].date + ' ' + events[index].starttime;
        etm = events[index].date + ' ' + events[index].endtime;

        DateTime sdt = DateTime.parse(stm);
        DateTime edt = DateTime.parse(etm);
        if (edt.compareTo(now) < 0 && events[index].email == widget.email) {
          count = 1;
          return Head_Past_EventTile(event: events[index]);
          // index++;
        }
        else if(count == 0 && index == events.length-1)
        {
          return Center(
            child: Text('No Past Events'),
          );
        }
        else
        {
          return Card();
        }

      },
    );
  }
}