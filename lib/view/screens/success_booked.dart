import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:lottie/lottie.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('Doctor Details Page - Docname: ${widget.docname}');
    debugPrint('Doctor Details Page - User: ${widget.user}');
    debugPrint('Doctor Details Page - Date: ${widget.date}');
    debugPrint('Doctor Details Page - Time: ${widget.time}');
    debugPrint('Doctor Details Page - Payment: ${widget.payment}');
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
          ]),
    ));
  }
}
