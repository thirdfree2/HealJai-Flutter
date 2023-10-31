import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID, required this.user_id, required this.user_name}) : super(key: key);
  final String callID;
  final String user_id;
  final String user_name;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID:
            2086567153, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign:
            "a3899f867d191e014732aef964d1368c0f1eed33f988367025f8a79ef19e0712", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: user_id,
        userName: user_name,
        callID: callID,
        // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
  }
}
