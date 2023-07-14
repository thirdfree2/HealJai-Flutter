import 'package:flutter/material.dart';
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
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndexView(),
    );
  }
}