import 'dart:async';
import 'package:flutter_application_1/view/main.layout.dart';
import 'package:flutter_application_1/view/psychologist_screens/psycholonist_home_page.dart';
import 'package:flutter_application_1/view/psychologist_screens/psymain.layout.dart';
import 'package:flutter_application_1/view/screens/auth_page.dart';
import 'package:flutter_application_1/view/screens/homefix_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:flutter_application_1/view/login.view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashView extends StatefulWidget {
  final String? token; // เปลี่ยนเป็น String?
  const SplashView({@required this.token, Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () {
        if (widget.token != null) {
          var decodedToken = JwtDecoder.decode(widget.token!);
          if (decodedToken['role_id'] == 3) {
            Get.offAll(MainView(token: widget.token));
          } else if (decodedToken['role_id'] == 2) {
            Get.offAll(PsyMain(token: widget.token));
          } else {
            Get.offAll(AuthPage());
          }
        } else {
          Navigator.of(context).pushReplacementNamed('auth');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      body: Center(
        child: Text(
          'HealJaii',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
