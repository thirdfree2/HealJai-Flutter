import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screens/payment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/utils/api_url.dart';

class CalendarFixSecond extends StatefulWidget {
  final token;
  final int psychologist_id;
  final int user_id;
  const CalendarFixSecond(
      {@required this.token,
      this.user_id = 0,
      this.psychologist_id = 0,
      Key? key})
      : super(key: key);

  @override
  State<CalendarFixSecond> createState() => _CalendarFixSecondState();
}

class _CalendarFixSecondState extends State<CalendarFixSecond> {
  List<dynamic> appointments = [];
  int selectedTimeIndex = -1;

  @override
  void initState() {
    super.initState();
    debugPrint('Doctor Details Page - Docname: ${widget.psychologist_id}');
    debugPrint('Doctor Details Page - User_id: ${widget.user_id}');
    fetchData();
  }

  Future<void> fetchData() async {
    final path = ApiUrls.localhost;
    final psychologist_id = widget.psychologist_id;
    final apiUrl = '$path/psychologist/calendar/test/$psychologist_id';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        appointments = data['data'];
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Psychologist Appointments'),
      ),
      body: appointments.isEmpty
          ? Center(
              child: Text('No appointments available'),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListView.builder(
                itemCount: appointments.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {



                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 300,
                      height: 200,
                      child: Card(
                        child: ListTile(
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: ElevatedButton(
        onPressed: selectedTimeIndex != -1
            ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Appointment'),
                      content: Text(
                        'Do you want to confirm the appointment for Time Slot ID ${appointments[selectedTimeIndex]['id']} at ${appointments[selectedTimeIndex]['slot_time']}?',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            int psychologist_appointments_id = int.parse(
                                appointments[selectedTimeIndex]['id']
                                    .toString());

                            // Handle appointment confirmation here
                            print(
                                'Appointment confirmed for Time Slot ID ${appointments[selectedTimeIndex]['id']} at ${appointments[selectedTimeIndex]['slot_time']}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Payment(
                                  psychonist_appointments_id: psychologist_appointments_id,
                                  user_id: widget.user_id,
                                  token: widget.token,
                                ),
                              ),
                            );
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );
              }
            : null,
        child: Text('Submit'),
      ),
    );
  }
}
