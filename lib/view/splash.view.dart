import 'dart:async';

import 'package:flutter_application_1/view/screens/auth_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/global.colors.dart';
import 'package:flutter_application_1/view/login.view.dart';

import '../utils/config.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(AuthPage());
    });
    return Scaffold(
      backgroundColor: Config.primaryColor,
      body: Center(
          child: Text(
        'HealJaii',
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      )),
    );
  }
}
