import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/components/loading.dart';
import 'package:flutter_application_1/view/screens/auth_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../components/button.dart';
import '../../utils/api_url.dart';
import '../../utils/config.dart';

class RefundPage extends StatefulWidget {
  final int userID;
  final int appointmentID;
  final int paymentID;
  const RefundPage(
      {required this.appointmentID, required this.paymentID, Key? key, required this.userID,})
      : super(key: key);

  @override
  State<RefundPage> createState() => _RefundPageState();
}

class _RefundPageState extends State<RefundPage> {
  late String userID = (widget.userID).toString();
  late String paymentID = (widget.paymentID).toString();
  late String appointtmentID = (widget.appointmentID).toString();
  final _userIDpayment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(
              'Refund', // ข้อความส่วนหัวหน้า
              style: TextStyle(
                fontSize: 24, // ขนาดตัวอักษร
                fontWeight: FontWeight.bold, // ตัวหนา
              ),
            ),
            Form(
              child: TextFormField(
                controller: _userIDpayment,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Config.primaryColor,
                decoration: const InputDecoration(
                  hintText: 'Promt-pay',
                  labelText: 'เลขบัญชี',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.wallet),
                  prefixIconColor: Config.primaryColor,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]')), // ระบุให้รับเฉพาะตัวเลข
                ],
              ),
            ),
            Text(
              'หากกดคืนแล้วจะ การนัดหมายครั้งนี้จะถูกยกเลิกทันที', // ข้อความส่วนหัวหน้า
              style: TextStyle(
                fontSize: 16, // ขนาดตัวอักษร
                fontWeight: FontWeight.bold, // ตัวหนา
              ),
            ),
            Button(
              width: double.infinity,
              title: 'Refund',
              onPressed: () {
                final path = ApiUrls.localhost;
                final apiUrl = '$path/admin/refund/request';
                final data = {
                  'UserID': userID,
                  'PaymentID': paymentID,
                  'Promtpay': _userIDpayment.text,
                  'PsychologistAppoinmentID': appointtmentID,
                };
                http
                    .post(
                  Uri.parse(apiUrl),
                  body: data,
                )
                    .then((response) {
                  if (response.statusCode == 200) {
                    // Request was successful, handle the response here
                    print('Refund request successful');
                    Get.to(AuthPage());
                  } else {
                    // Request failed, handle the error here
                    print('Error: ${response.statusCode}');
                  }
                }).catchError((error) {
                  // Handle any errors that occurred during the request
                  print('Error: $error');
                });
              },
              disable: false,
            ),
          ]),
        ),
      ),
    );
  }
}
