import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:flutter_application_1/view/call.view.dart';
import 'package:flutter_application_1/view/login.view.dart';
import 'package:flutter_application_1/view/main.layout.dart';
import 'package:flutter_application_1/view/screens/auth_page.dart';
import 'package:flutter_application_1/view/screens/booking_page.dart';
import 'package:flutter_application_1/view/screens/doctor_details.dart';
import 'package:flutter_application_1/view/screens/success_booked.dart';
import 'package:flutter_application_1/view/splash.view.dart';
import 'package:get/get.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Doctor APp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          border: Config.outlinedBorder,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorBorder,
          enabledBorder: Config.outlinedBorder,
          floatingLabelStyle: TextStyle(color: Config.primaryColor),
          prefixIconColor: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Config.primaryColor,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade700,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        'auth': (context) => const AuthPage(),
        'main': (context) => const MainView(),
        'doc_details': (context) => const DoctorDetails(),
        'booking_page': (context) => const BookingPage(),
        'success_booking': (context) => const AppointmentBooked(),
        'videocall': (context) => const Callvideo(),
      },
    );
  }
}
