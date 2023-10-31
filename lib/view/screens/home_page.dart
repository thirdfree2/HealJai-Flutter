import 'package:flutter/material.dart';

import 'package:flutter_application_1/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class HomePage extends StatefulWidget {
  final token;
  const HomePage({@required this.token, Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> psychologistList = [];

  late String email;

  @override
  void initState() {
    super.initState();
    fetchPsychologists();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
  }

  Future<void> fetchPsychologists() async {
    final apiUrl = 'http://10.1.203.91:3000/getpsychonist';

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

  final List<Map<String, dynamic>> medCat = [
    {
      "icon": FontAwesomeIcons.userDoctor,
      "category": "General",
    },
    {
      "icon": FontAwesomeIcons.heartPulse,
      "category": "Cardiology",
    },
    {
      "icon": FontAwesomeIcons.lungs,
      "category": "Respiratory",
    },
    {
      "icon": FontAwesomeIcons.person,
      "category": "Dermatologist",
    },
    {
      "icon": FontAwesomeIcons.handHoldingMedical,
      "category": "Orthopedics",
    },
    {
      "icon": FontAwesomeIcons.tooth,
      "category": "Dental",
    },
  ];

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 245, 232),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Config.primaryColor,
                    backgroundImage: AssetImage('assets/images/helm2.jpg'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 100, // Set a specific height for the category list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: medCat.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Config.primaryColor,
                    margin: const EdgeInsets.only(right: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FaIcon(
                            medCat[index]['icon'],
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            medCat[index]['category'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                'The Doctors',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: psychologistList.length,
                itemBuilder: (BuildContext context, int index) {
                  final psychologist = psychologistList[index];
                  final name = psychologist['doc_username'];
                  return ListTile(
                    leading: const Icon(Icons.list),
                    trailing: const Text(
                      "GFG",
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                    title: Text("$name"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
