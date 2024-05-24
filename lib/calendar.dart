// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors
import 'package:enquire/eventbox.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';

class EventModel {
  final String id;
  final String title;
  final String details;
  final DateTime date;
  final String img;
  final bool quiz;
  final int time;
  final String instruct;
  EventModel({
    required this.id,
    required this.title,
    required this.details,
    required this.date,
    required this.img,
    required this.quiz,
    required this.instruct,
    required this.time,
  });
}

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<EventModel>> getEvents() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('event').get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return EventModel(
        id: doc.id,
        title: data['title'],
        details: data['details'],
        date: (data['date'] as Timestamp).toDate(),
        img: data['img'],
        quiz: data['quiz'],
        instruct: data['instruct'],
        time: data['time'],
      );
    }).toList();
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Event> events = [];
  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    List<EventModel> eventModels = await FirebaseService().getEvents();
    events = eventModels.map((eventModel) {
      return Event(
        child: Column(
          children: [
            SizedBox(height: 10),
            buildeventbox(
              context,
              eventModel.id,
              eventModel.img,
              eventModel.title,
              eventModel.details,
              eventModel.instruct,
              eventModel.date,
              eventModel.quiz,
              eventModel.time,
            ),
          ],
        ),
        dateTime: CalendarDateTime(
          year: eventModel.date.year,
          month: eventModel.date.month,
          day: eventModel.date.day,
          calendarType: CalendarType.GREGORIAN,
        ),
      );
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 12, 27),
        title: Text(
          'Event Calendar',
          style: TextStyle(
              color: Color.fromARGB(255, 253, 246, 255),
              fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 149, 100),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 24, 12, 27),
      body: EventCalendar(
        showEvents: true,
        calendarType: CalendarType.GREGORIAN,
        events: events,
        calendarOptions: CalendarOptions(
          headerMonthBackColor: Color.fromARGB(255, 253, 246, 255),
          bottomSheetBackColor: Color.fromARGB(255, 253, 246, 255),
          headerMonthElevation: 10,
          toggleViewType: true,
        ),
        headerOptions: HeaderOptions(
          headerTextColor: Color.fromARGB(255, 87, 5, 107),
          navigationColor: Color.fromARGB(255, 87, 5, 107),
          resetDateColor: Color.fromARGB(255, 87, 5, 107),
          monthStringType: MonthStringTypes.FULL,
          weekDayStringType: WeekDayStringTypes.SHORT,
          calendarIconColor: Color.fromARGB(255, 87, 5, 107),
        ),
        dayOptions: DayOptions(
          showWeekDay: true,
          unselectedTextColor: Color.fromARGB(255, 87, 5, 107),
          selectedBackgroundColor: Color.fromARGB(255, 216, 94, 37),
          selectedTextColor: Color.fromARGB(255, 253, 246, 255),
          weekDaySelectedColor: Colors.black,
          eventCounterColor: Colors.green,
          eventCounterViewType: DayEventCounterViewType.LABEL,
        ),
        eventOptions: EventOptions(
          emptyIcon: Icons.error,
          emptyIconColor: Color.fromARGB(255, 24, 12, 27),
          emptyText: 'No Event Found',
          emptyTextColor: Color.fromARGB(255, 24, 12, 27),
          loadingWidget: () {
            return CircularProgressIndicator(
              strokeWidth: 5,
            );
          },
        ),
      ),
    );
  }
}
