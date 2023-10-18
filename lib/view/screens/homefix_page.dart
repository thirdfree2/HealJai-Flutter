import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/view/screens/chat_screen_page.dart';
import 'package:flutter_application_1/view/screens/doctor_details.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'dart:convert';
import 'package:flutter_application_1/utils/api_url.dart';
import 'package:http/http.dart' as http;

class HomePagefix extends StatefulWidget {
  final token;
  const HomePagefix({@required this.token, Key? key}) : super(key: key);
  @override
  State<HomePagefix> createState() => _HomePagefixState();
}

class _HomePagefixState extends State<HomePagefix> {
  late String email;
  late int id;
  late String name;

  List<dynamic> psychologistList = [];
  List<dynamic> appointmentTodayList = [];
  final dummy_status = 'None';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    name = jwtDecodedToken['name'];
    id = jwtDecodedToken['id'];
    fetchPsychologists();
    fetchAppointment();
  }

  Future<void> fetchAppointment() async {
    final path = ApiUrls.localhost;
    final apiUrl = '$path/appointment/get/$id';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final AppointmentData = jsonData['data'];

      setState(() {
        appointmentTodayList = AppointmentData;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchPsychologists() async {
    final path = ApiUrls.localhost;
    final apiUrl = '$path/psychologist/get';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final psychologistData = jsonData['data'];

      setState(() {
        psychologistList = psychologistData;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$name",
          style: TextStyle(fontSize: 28),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 16.0, top: 28.0), // ปรับค่าตามต้องการ
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Transform.scale(
                        scale: 1.5,
                        child: Icon(Icons.notifications),
                      ),
                      onPressed: () {
                        // กระทำเมื่อไอคอนถูกคลิก
                      },
                    ),
                    IconButton(
                      icon: Transform.scale(
                        scale: 1.5,
                        child: Icon(Icons.account_circle_rounded),
                      ),
                      onPressed: () {
                        // กระทำเมื่อไอคอนถูกคลิก
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
        backgroundColor: Config.primaryColor,
        toolbarHeight: 100,
        elevation: 15,
      ),
      backgroundColor: const Color.fromARGB(255, 60, 184, 124),
      body: Container(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              children: [
                // SizedBox(height: 100,),
                Text(
                  'Appointment',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: appointmentTodayList.length,
            itemBuilder: (BuildContext context, int index) {
              if (appointmentTodayList.isEmpty) {
                return Center(
                  child: Text("Appointment Not Found"),
                );
              }
              final appointmentToday = appointmentTodayList[index];
              final chat_id = appointmentToday['psychologist_appointment_id'];
              final target_id = appointmentToday['psychologist_id'];
              final doc_name = appointmentToday['user_name'];
              final psychologist_id = appointmentToday['psychologist_id'];
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
                                          '$doc_name',
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
                                      Get.to(ChatdocScreen(token: widget.token,sourceId: id,target_id: target_id,))
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              children: [
                Text('Psychologist',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: psychologistList.length,
              itemBuilder: (BuildContext context, int index) {
                if (psychologistList.isEmpty) {
                  return Center(
                    child: Text("Psychologist Not Found"),
                  );
                }
                final psychologist = psychologistList[index];
                final psychologist_name = psychologist['user_name'];
                final psychologist_id = psychologist['id'];
                final address = psychologist['address'];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorDetails(
                                  psychologist_name: psychologist_name,
                                  psychologist_id: psychologist_id,
                                  user_id: id,
                                  status: dummy_status,
                                  token: widget.token,
                                ),
                              ));
                        },
                        leading: FlutterLogo(size: 72.0),
                        title: Text('$psychologist_name'),
                        subtitle: Text('Address : $address'),
                        isThreeLine: true,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class OutlinedCardExample extends StatelessWidget {
  const OutlinedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const SizedBox(
          width: 350,
          height: 100,
          child: Center(child: Text('Outlined Card')),
        ),
      ),
    );
  }
}
