import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/global.colors.dart';

class Config {


  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenHeight = mediaQueryData!.size.width;
    screenWidth = mediaQueryData!.size.height;
  }

  static get widthSize {
    return widthSize;
  }

  static get heighSize {
    return heighSize;
  }

  static const spaceSmall = SizedBox(height: 25);
  static final spaceMedium = SizedBox(height: screenHeight! * 0.05);
  static final spaceBig = SizedBox(height: screenHeight! * 0.08);

  static const outlinedBorder =
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)));

  static const focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.greenAccent,
      ));

  static const errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.red,
      ));

  static const primaryColor = Colors.greenAccent;
}
