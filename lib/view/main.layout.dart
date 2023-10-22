import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screens/appoinment_page.dart';
import 'package:flutter_application_1/view/screens/chat_list_user_page.dart';
import 'package:flutter_application_1/view/screens/home_page.dart';
import 'package:flutter_application_1/view/screens/homefix_page.dart';
import 'package:flutter_application_1/view/screens/profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';

class MainView extends StatefulWidget {
  final token;
  const MainView({@required this.token, Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final Map<String, dynamic> jwtDecodedToken;
  late final PageController _page;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    jwtDecodedToken = JwtDecoder.decode(widget.token);
    _page = PageController(); // Initialize _page in initState
  }

  @override
  void dispose() {
    _page.dispose(); // Dispose of the controller when done.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value) {
          setState(() {
            currentPage = value;
          });
        }),
        children: <Widget>[
          HomePagefix(token: widget.token),
          ChatListPage(),
          AppointmentPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _page.animateToPage(
              page,
              duration: const Duration(microseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timelapse,
            ),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user), label: 'Profile'),
        ],
      ),
    );
  }
}
