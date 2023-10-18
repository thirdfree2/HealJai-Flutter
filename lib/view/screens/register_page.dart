import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/sign_up_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/custom_appbar.dart';
import '../../utils/config.dart';

class RigisterPage extends StatefulWidget {
  const RigisterPage({super.key});

  @override
  State<RigisterPage> createState() => _RigisterPageState();
}

class _RigisterPageState extends State<RigisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: ' ',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sign up',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}