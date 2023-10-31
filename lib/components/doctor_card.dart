import 'dart:convert';

import 'package:flutter/material.dart';

import '../utils/config.dart';
import 'package:http/http.dart' as http;

class DoctorCard extends StatefulWidget {
  const DoctorCard({Key? key}) : super(key: key);

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  List<dynamic> psychonistList = [];

  @override
  void initState() {
    super.initState();
    fetchTicket();
  }

  Future<void> fetchTicket() async {
    final api1Url = 'http://10.1.203.91:3000/getpsychonist';

    final api1Response = await http.get(Uri.parse(api1Url));

    if (api1Response.statusCode == 200) {
      final api1Json = jsonDecode(api1Response.body);
      final api1Cars = api1Json['data'];

      setState(() {
        psychonistList = api1Cars;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Expanded(
      // Wrap with Expanded
      child: ListView.builder(
        itemCount: psychonistList.length,
        itemBuilder: (context, index) {
          if (psychonistList.isEmpty) {
            return CircularProgressIndicator();
          }


          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 150,
            child: GestureDetector(
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Image.asset(
                        'assets/images/doctor1.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width:
                              100, // Provide width and height for the Container
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Dr Ridchard Tan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Dental',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  Icon(
                                    Icons.star_border,
                                    color: Colors.yellow,
                                    size: 16,
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Text('4.5'),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Text('Reviews'),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Text('(20)'),
                                  Spacer(
                                    flex: 7,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                print('hello');
              },
            ),
          );
        },
      ),
    );
  }
}
