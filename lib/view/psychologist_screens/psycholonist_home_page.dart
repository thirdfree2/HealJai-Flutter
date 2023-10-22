import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screens/chat_screen_page.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../components/button.dart';
import '../../utils/api_url.dart';
import '../../utils/config.dart';
import '../screens/auth_page.dart';
import 'dart:convert';

class PsyHomePage extends StatefulWidget {
  final token;
  const PsyHomePage({@required this.token, super.key});

  @override
  State<PsyHomePage> createState() => _PsyHomePageState();
}

class _PsyHomePageState extends State<PsyHomePage> {
  late String email;
  late int id;
  late String name;

  List<dynamic> appointment = [];
  Future<void> fetchAppointment() async {
    final path = ApiUrls.localhost;
    final apiUrl = '$path/appointment/psychologist/$id';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final AppointmentData = jsonData['data'];

      setState(() {
        appointment = AppointmentData;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    name = jwtDecodedToken['name'];
    id = jwtDecodedToken['id'];
    debugPrint('Doctor Details Page - User_id: $id');
    fetchAppointment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$name",
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Config.primaryColor,
        toolbarHeight: 100,
        elevation: 15,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text("Incoming Appointment"),
              ListView.builder(
                shrinkWrap: true,
                itemCount: appointment.length,
                itemBuilder: (BuildContext context, int index) {
                  if (appointment.isEmpty) {
                    return Center(
                      child: Text("Appointment Not Found"),
                    );
                  }
                  final appointmentToday = appointment[index];
                  final chat_id = appointmentToday['id'];
                  final user_id = appointmentToday['user_id'];
                  final target_id = appointmentToday['psychologist_id'];
                  final appoint_time = appointmentToday['slot_time'];
                  final appoint_date = appointmentToday['slot_date'];
                  final status = appointmentToday['status'];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.only(),
                                  child: FlutterLogo(size: 80.0),
                                ),
                                title: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              '$user_id',
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            child: IconButton(
                                              icon: Transform.scale(
                                                scale: 1.2,
                                                child: Icon(Icons.settings),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      Text('Appointment Time : $appoint_time'),
                                      Text('Date : $appoint_date'),
                                    ],
                                  ),
                                ),
                                isThreeLine: true,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Button(
                                    width: 300,
                                    title: 'Start Chat',
                                    onPressed: () => {
                                          Get.to(ChatdocScreen(
                                            token: widget.token,
                                            sourceId: id,
                                            target_id: user_id,
                                          ))
                                        },
                                    disable: false),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
