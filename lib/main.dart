import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:flutter_application_1/view/call.view.dart';
import 'package:flutter_application_1/view/login.view.dart';
import 'package:flutter_application_1/view/main.layout.dart';
import 'package:flutter_application_1/view/screens/auth_page.dart';
import 'package:flutter_application_1/view/screens/booking_page.dart';
import 'package:flutter_application_1/view/screens/chat_page.dart';
import 'package:flutter_application_1/view/screens/chat_screen_page.dart';
import 'package:flutter_application_1/view/screens/doctor_details.dart';
import 'package:flutter_application_1/view/screens/homefix_page.dart';
import 'package:flutter_application_1/view/screens/register_page.dart';
import 'package:flutter_application_1/view/screens/success_booked.dart';
import 'package:flutter_application_1/view/splash.view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(App(token: prefs.getString('token'),));
}

class App extends StatelessWidget {

  final token;
  const App({@required this.token, Key? key}) : super(key: key);
  static final navigatorKey = GlobalKey<NavigatorState>();
  bool isUserAuthenticated() {
    if (token != null) {
      // Decode and verify the token here, and check for expiration
      // If the token is valid, return true; otherwise, return false.
      // You can use packages like 'jwt_decoder' for token decoding.
      // Example:
      // final bool tokenIsValid = validateToken(token);
      // return tokenIsValid;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final bool isAuthenticated = isUserAuthenticated();
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Doctor App',
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
        'main': (context) => isAuthenticated ? HomePagefix(token: token) : AuthPage(),
        'auth': (context) => const AuthPage(),
        'register': (context) => const RigisterPage(),
        // 'main': (context) => const MainView(),
        'doc_details': (context) => const DoctorDetails(),
        'booking_page': (context) => const BookingPage(),
        'success_booking': (context) => const AppointmentBooked(),
        'videocall': (context) => const Callvideo(),
      },
    );
  }
}
