import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screens/payment.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/api_url.dart';

class BookingPage extends StatefulWidget {
  final String token;
  final int psychologist_id;
  final int user_id;

  const BookingPage({
    required this.token,
    this.user_id = 0,
    this.psychologist_id = 0,
    Key? key,
  }) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<dynamic> appointments = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final path = ApiUrls.localhost;
    final psychologist_id = widget.psychologist_id;
    final apiUrl = '$path/psychologist/calendar/$psychologist_id';// Replace with your API endpoint
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': 'Bearer ${widget.token}',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        appointments = data['data'];
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  DateTime? selectedDate;
  String? selectedTime;

  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();

  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment'),
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _tableCalendar(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      'Select Consultation Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    alignment: Alignment.center,
                    child: Text(
                      'Weekend is not available, please select another date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              : SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _timeSelected = true;
                          });

                          // Store the selected time in the selectedTime variable
                          selectedTime =
                              '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}';
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _currentIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: _currentIndex == index
                                ? Colors.blue // Change to your desired color
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _currentIndex == index
                                  ? Colors.white
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 8,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.5,
                  ),
                ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 80),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment(),
                    ),
                  );
                },
                child: Text('Make Appointment and Payment'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: _timeSelected && _dateSelected
                      ? Colors.blue // Change to your desired color
                      : Colors.grey,
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableCalendar() {
    Map<DateTime, List> events = {};

    for (var appointment in appointments) {
      DateTime slotDate = DateTime.parse(appointment['slot_date']);
      String slotTime = appointment['slot_time'];

      // Create a DateTime object for the slot time
      DateTime slotDateTime = DateTime(
        slotDate.year,
        slotDate.month,
        slotDate.day,
        int.parse(slotTime.split(':')[0]),
        int.parse(slotTime.split(':')[1]),
      );

      if (events[slotDate] == null) {
        events[slotDate] = [];
      }
      events[slotDate]?.add(slotDateTime);
    }

    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2023, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.blue, // Change to your desired color
          shape: BoxShape.circle,
        ),
      ),
      availableCalendarFormats: {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;
          if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });

        // Set events for the selected day
        selectedDate = DateTime(
            selectedDay.year, selectedDay.month, selectedDay.day);
        if (events[selectedDate] != null) {
          _currentIndex = null;
          _timeSelected = false;
        }
      },
      // Use eventLoader to load events for each day
      eventLoader: (day) {
        return events[day] ?? [];
      },
    );
  }
}
