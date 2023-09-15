import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AppointmentBooked extends StatefulWidget {
  final docname;
  final user;
  final date;
  final time;
  final payment;
  const AppointmentBooked(
      {@required this.docname, this.user, this.date, this.time, this.payment, Key? key});

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
    final apiUrl = Uri.parse('http://10.1.205.49:3000/user/paymentrequest'); // เปลี่ยน YOUR_API_URL เป็น URL ของ API ของคุณ
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
    debugPrint('Doctor Details Page - Docname: ${widget.docname}');
    debugPrint('Doctor Details Page - User: ${widget.user}');
    debugPrint('Doctor Details Page - Date: ${widget.date}');
    debugPrint('Doctor Details Page - Time: ${widget.time}');
    debugPrint('Doctor Details Page - Payment: ${widget.payment}');

    // เรียกใช้งานฟังก์ชัน sendBookingData เพื่อส่งข้อมูลการจองไปยัง API
    sendBookingData(
      widget.user,   // แทนที่ด้วยข้อมูลผู้ใช้จริง
      widget.docname,  // แทนที่ด้วยชื่อแพทย์จริง
      widget.payment,  // แทนที่ด้วยข้อมูลการชำระเงินจริง
      widget.date,     // แทนที่ด้วยวันที่จริง
      widget.time,     // แทนที่ด้วยเวลาจริง
    );
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
