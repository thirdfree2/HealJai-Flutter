import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/register.view.dart';
import 'package:flutter_application_1/view/splash.view.dart';
import 'package:flutter_application_1/view/index.view.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
      routes: {
        'register': (context) => RegisterView(),
        'home': (context) => IndexView(),
      },
    );
  }
}

