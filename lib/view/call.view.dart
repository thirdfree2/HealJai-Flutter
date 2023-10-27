import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class Callvideo extends StatefulWidget {
  final int userID;
  final String userName;
  Callvideo({
    required this.userID,
    required this.userName,
  });

  @override
  State<Callvideo> createState() => _CallvideoState();
}

class _CallvideoState extends State<Callvideo> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ZegoUIKitPrebuiltCall(
        appID: 748440981,
        appSign:
            'eb899a200a07934471d2943ab298d63befbd7c8b80371d7b3ec52a02de7b9e1e',
        callID: '54322',
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..onOnlySelfInRoom = (context) => Navigator.pop(context),
        userID: '12',
        userName: "Joy2",
      )),
    );
  }
}
