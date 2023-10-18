import 'package:flutter/material.dart';

class PsyAppointPage extends StatefulWidget {
  const PsyAppointPage({super.key});

  @override
  State<PsyAppointPage> createState() => _PsyAppointPageState();
}

class _PsyAppointPageState extends State<PsyAppointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text('Appoint')),
    );
  }
}
