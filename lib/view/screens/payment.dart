import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/view/screens/success_booked.dart';

class Payment extends StatefulWidget {
  final docname;
  final user;
  final date;
  final time;
  const Payment(
      {@required this.docname, this.user, this.date, this.time, Key? key});

  @override
  State<Payment> createState() => _PaymentState();
}





class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    final String money = '300';
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Payment'),
            Center(
              child: Button(
                  width: 200,
                  title: 'Go Appointment',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentBooked(
                            docname: widget.docname,
                            user: widget.user,
                            date: widget.date,
                            time: widget.time,
                            payment: money,
                          ),
                        ));
                  },
                  disable: false),
            ),
          ],
        ),
      ),
    );
  }
}
