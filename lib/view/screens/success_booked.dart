import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/utils/api_url.dart';

class AppointmentBooked extends StatefulWidget {
  final payment;
  final psychonist_appointments_id;
  final user_id;
  final image;
  const AppointmentBooked(
      {@required this.user_id,
      this.image,
      this.psychonist_appointments_id,
      this.payment,
      Key? key});

  @override
  State<AppointmentBooked> createState() => _AppointmentBookedState();
}

class _AppointmentBookedState extends State<AppointmentBooked> {
  Future<void> sendBookingData(
    String email,
    String doc,
    String payment,
    String date,
    String time,
  ) async {
    final path = ApiUrls.localhost;
    final apiUrl = Uri.parse(
        '$path/user/paymentrequest'); // เปลี่ยน YOUR_API_URL เป็น URL ของ API ของคุณ
    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'doc': doc,
        'payment': payment,
        'date': date,
        'time': time,
      }),
    );

    if (response.statusCode == 201) {
      print('Booking successful');
    } else {
      print('Booking failed');
      print('Error message: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Lottie.asset('assets/images/animation_2xarao.json'),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Successfully Booked',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Button(
                width: double.infinity,
                title: 'Back to Home Page',
                onPressed: () => Navigator.of(context).pushNamed('/'),
                disable: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
