import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screens/payment.dart';
import 'package:flutter_application_1/view/screens/success_booked.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/utils/api_url.dart';

class BookingPagefix extends StatefulWidget {
  final token;
  final int psychologist_id;
  final int user_id;
  const BookingPagefix(
      {@required
      this.token,
      this.user_id = 0,
      this.psychologist_id = 0,
      Key? key})
      : super(key: key);

  @override
  State<BookingPagefix> createState() => _BookingPagefixState();
}

class _BookingPagefixState extends State<BookingPagefix> {
  List<dynamic> appointments = [];
  int selectedAppointmentIndex = -1;

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
    final apiUrl = '$path/psychologist/calendar/$psychologist_id';
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
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (BuildContext context, int index) {
                final appointment = appointments[index];
                final isDateChanged = index == 0 ||
                    appointment['slot_date'] !=
                        appointments[index - 1]['slot_date'];
                final isDisabled = appointment['status'] == 1;
                final isSelected = selectedAppointmentIndex == index;

                return Column(
                  children: <Widget>[
                    if (isDateChanged)
                      ListTile(
                        title: Text('Date: ${appointment['slot_date']}'),
                      ),
                    ElevatedButton(
                      onPressed: isDisabled
                          ? null
                          : () {
                              setState(() {
                                selectedAppointmentIndex = index;
                              });
                            },
                      child: Text('Time: ${appointment['slot_time']}'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (isSelected) {
                              return Colors.red;
                            }
                            return isDisabled ? Colors.grey : Colors.blue;
                          },
                        ),
                      ),
                    ),
                    // Add other appointment details here if needed
                  ],
                );
              },
            ),
      floatingActionButton: ElevatedButton(
        onPressed: selectedAppointmentIndex != -1
            ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Appointment'),
                      content: Text(
                        'Do you want to confirm the appointment for Time Slot ID ${appointments[selectedAppointmentIndex]['id']} at ${appointments[selectedAppointmentIndex]['slot_time']}?',
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
                            int psychonist_appointments_id = int.parse(
                                appointments[selectedAppointmentIndex]['id']
                                    .toString());

                            // Handle appointment confirmation here
                            print(
                                'Appointment confirmed for Time Slot ID ${appointments[selectedAppointmentIndex]['id']} at ${appointments[selectedAppointmentIndex]['slot_time']}');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Payment(
                                    psychonist_appointments_id: int.parse(
                                        appointments[selectedAppointmentIndex]
                                                ['id']
                                            .toString()),
                                    user_id: widget.user_id,
                                    token: widget.token,
                                  ),
                                ));
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
