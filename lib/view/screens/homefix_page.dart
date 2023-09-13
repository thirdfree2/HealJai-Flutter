import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/view/screens/doctor_details.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePagefix extends StatefulWidget {
  final token;
  const HomePagefix({@required this.token, Key? key}) : super(key: key);
  @override
  State<HomePagefix> createState() => _HomePagefixState();
}

class _HomePagefixState extends State<HomePagefix> {
  late String email;
  List<dynamic> psychologistList = [];
  List<dynamic> appointmentTodayList = [];

  @override
  void initState() {
    super.initState();
    fetchPsychologists();
    fetchAppointment();
    // Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    // email = jwtDecodedToken['email'];
  }

  Future<void> fetchAppointment() async {
    final dummy_email = 'AC_DC';
    final apiUrl = 'http://10.1.205.49:3000/getappointment/get/$dummy_email';
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
    final apiUrl = 'http://10.1.205.49:3000/getpsychonist/get';

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
          'Profile Page',
          style: TextStyle(fontSize: 30),
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
              final appointmentToday = appointmentTodayList[index];
              final doc_name = appointmentToday['doc_name'];
              final appoint_time = appointmentToday['appoint_time'];
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
                                      Text(
                                        '$doc_name',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        icon: Transform.scale(
                                          scale: 1.2,
                                          child: Icon(Icons.settings),
                                        ),
                                        onPressed: () {
                                          // กระทำเมื่อไอคอนถูกคลิก
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text('$appoint_time'),
                            ),
                            isThreeLine: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Button(
                                width: 300,
                                title: 'Start Chat',
                                onPressed: () => {},
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
                final psychologist = psychologistList[index];
                final name = psychologist['doc_username'];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorDetails(),
                              ));
                        },
                        leading: FlutterLogo(size: 72.0),
                        title: Text('$name'),
                        subtitle: Text(
                            'A sufficiently long subtitle warrants three lines.'),
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
