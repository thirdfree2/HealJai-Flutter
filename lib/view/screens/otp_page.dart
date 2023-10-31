import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/config.dart';


import '../../components/button.dart';

class OTPVerify extends StatefulWidget {
  final String userName;
  final String birthDay;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String tel;

  OTPVerify({
    required this.userName,
    required this.birthDay,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.tel,
  });

  @override
  _OTPVerifyState createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.primaryColor,
        title: Text("Verify OTP"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              cursorColor: Config.primaryColor,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
                labelText: 'OTP',
                alignLabelWithHint: true,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Button(
              width: double.infinity,
              title: 'Verify OTP',
              onPressed: () async {
                // ตรวจสอบค่า OTP ใน _otpController ด้วยระบบ OTP ที่คุณใช้
                // ถ้า OTP ถูกต้อง คุณสามารถดำเนินการลงทะเบียนผู้ใช้ในระบบของคุณ
                // ในกรณีนี้คุณอาจต้องทำการส่งค่า OTP ไปยังระบบของคุณผ่าน HTTP หรือวิธีอื่น ๆ
              },
              disable: false,
            ),
          ),
        ],
      ),
    );
  }
}
