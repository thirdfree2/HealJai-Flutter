import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/psychologist_screens/psychologist_appoint_page.dart';
import 'package:flutter_application_1/view/psychologist_screens/psychologist_profile_page.dart';
import 'package:flutter_application_1/view/psychologist_screens/psycholonist_home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class PsyMain extends StatefulWidget {
  final token;
  const PsyMain({@required this.token, Key? key}) : super(key: key);

  @override
  State<PsyMain> createState() => _PsyMainState();
}

class _PsyMainState extends State<PsyMain> {
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
          PsyHomePage(token: widget.token),
          PsyAppointPage(),
          // เปลี่ยน HomePagefix เป็น HomePage // เปลี่ยนชื่อเมนู ChatListPage เป็น ChatListUserPage
          PsyProfilePage(token: widget.token),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _page.animateToPage(
              page,
              duration: const Duration(
                  milliseconds: 500), // แก้ duration เป็น milliseconds
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
              Icons.timelapse_outlined,
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
