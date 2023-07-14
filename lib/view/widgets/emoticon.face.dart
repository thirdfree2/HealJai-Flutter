import "package:flutter/material.dart";
import 'package:flutter_application_1/utils/global.colors.dart';

class EmotionFaceView extends StatelessWidget {
  const EmotionFaceView({Key? key,required this.emotionFace}) : super(key: key);
  final String emotionFace;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalColors.appbarColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Center(
        child: Text(
          emotionFace,
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
    );
  }
}
