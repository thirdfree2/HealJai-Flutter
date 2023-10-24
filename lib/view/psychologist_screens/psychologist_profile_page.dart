import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:flutter_application_1/view/screens/auth_page.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PsyProfilePage extends StatefulWidget {
  final token;
  const PsyProfilePage({@required this.token, Key? key}) : super(key: key);

  @override
  State<PsyProfilePage> createState() => _PsyProfilePageState();
}

class _PsyProfilePageState extends State<PsyProfilePage> {
  late String email;
  late int id;
  late String name;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    name = jwtDecodedToken['name'];
    id = jwtDecodedToken['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.primaryColor,
        title: Text(
          "$name",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundImage:
                  AssetImage('assets/images/helm2.jpg'), // รูปโปรไฟล์
            ),
            SizedBox(height: 20),
            Text(
              '$name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '$email',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'เบอร์โทรศัพท์: None',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // ลบ token โดยใช้ SharedPreferences
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('token');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AuthPage()),
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
