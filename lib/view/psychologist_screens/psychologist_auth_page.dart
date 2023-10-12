import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/login_form.dart';
import 'package:flutter_application_1/utils/config.dart';

class PsyAuthPage extends StatefulWidget {
  const PsyAuthPage({super.key});

  @override
  State<PsyAuthPage> createState() => _PsyAuthPageState();
}

class _PsyAuthPageState extends State<PsyAuthPage> {
  final role = 'psy';
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome, Psycologist',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              Text(
                'Sign in to your account',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              LoginForm(),
              Config.spaceSmall,
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Your Password?',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Config.spaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Back to user UI',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('auth');
                    },
                    child: Text(
                      ' Click',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
