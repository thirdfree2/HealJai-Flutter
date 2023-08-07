import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class Callvideo extends StatefulWidget {
  const Callvideo({super.key});

  @override
  State<Callvideo> createState() => _CallvideoState();
}

class _CallvideoState extends State<Callvideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltCall(
          appID: 1240184661,
          appSign: '33a78b828692b268f48acef1fe6e9e280266ca74fe10c466b6fef94f81efb641',
          callID: '54321',
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..onOnlySelfInRoom = (context) => Navigator.pop(context),
          userID: '1234',
          userName: 'User01',
        )
      ),
    );
  }
}