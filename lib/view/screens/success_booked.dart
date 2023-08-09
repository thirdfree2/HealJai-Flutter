import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:lottie/lottie.dart';

class AppointmentBooked extends StatelessWidget {
  const AppointmentBooked({super.key});

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
