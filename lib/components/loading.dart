import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/psychologist_screens/psymain.layout.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/view/main.layout.dart';
import 'package:flutter_application_1/view/screens/auth_page.dart';
import 'package:flutter_application_1/view/screens/homefix_page.dart';
import 'package:flutter_application_1/view/login.view.dart';
import '../utils/api_url.dart';
import '../view/psychologist_screens/psycholonist_home_page.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LoadingView extends StatefulWidget {
  final int roleId;
  final token;
  const LoadingView({@required this.token, this.roleId = 0, Key? key})
      : super(key: key);

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

final path = ApiUrls.localhost;

class _LoadingViewState extends State<LoadingView> {
  late int id;
  final IO.Socket _socket = IO.io("http://10.1.30.4:4000", <String, dynamic>{
    'transports': ['websocket'],
    'query': {},
  });

  _connectSocket() {
    _socket.onConnect((data) {
    print('Connection established');
    _socket.emit('message', 'Hello, Server!');
  });
  _socket.on('message', (data) {
    print('Received message from server: $data');
  });
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    id = jwtDecodedToken['id'];
    _connectSocket();
    _redirectToPageBasedOnRoleId();
  }

  void _redirectToPageBasedOnRoleId() {
    Timer(const Duration(seconds: 2), () {
      if (widget.roleId == 1) {
        Get.offAll(MainView(token: widget.token));
      } else if (widget.roleId == 2) {
        Get.offAll(PsyMain(token: widget.token));
      } else {
        Get.offAll(AuthPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      body: Center(
        child: Text(
          'Loading.. ',
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
