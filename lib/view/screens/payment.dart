import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/view/screens/success_booked.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_application_1/utils/api_url.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Payment extends StatefulWidget {
  final token;
  final int psychonist_appointments_id;
  final int user_id;

  Payment(
      {@required 
      this.token,
      this.user_id = 0,
      this.psychonist_appointments_id = 0,
      Key? key})
      : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  void initState() {
    super.initState();
    debugPrint(
        'Calendar Page - Psychologist_Appointments_id : ${widget.psychonist_appointments_id}');
    debugPrint('Calendar Page - User_id: ${widget.user_id}');
  }

  Future<void> sendPaymentRequest() async {
    try {
      final path = ApiUrls.localhost;
      final apiUrl = '$path/user/paymentrequest';
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.fields['psychonist_appointments_id'] =
          widget.psychonist_appointments_id.toString();
      request.fields['user_id'] = widget.user_id.toString();

      if (_image != null) {
        var imageFile = await http.MultipartFile.fromPath('slip', _image!.path);
        request.files.add(imageFile);
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        // ส่งสำเร็จ
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentBooked(token: widget.token),
          ),
        );
      } else {
        // การส่งไม่สำเร็จ
        print(
            'Failed to send payment request. Status code: ${response.statusCode}');
        // ดำเนินการตามที่คุณต้องการ
      }
    } catch (e) {
      print('Error sending payment request: $e');
      // ดำเนินการตามที่คุณต้องการ
    }
  }

  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Payment'),
            Center(
              child: _image == null
                  ? Column(
                      children: [
                        Center(
                          child: Image(
                              image: AssetImage(
                                  'assets/images/paymentQRcode.jpg')),
                        ),
                        Text('No image selected.'),
                      ],
                    )
                  : Image.file(
                      _image!,
                      width: 100, // กำหนดความกว้างของรูปภาพตามต้องการ
                      height: 300, // กำหนดความสูงของรูปภาพตามต้องการ
                      fit: BoxFit.cover,
                    ),
            ),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Select Image'),
            ),
            Center(
              child: Button(
                width: 200,
                title: 'Go Appointment',
                onPressed: () {
                  sendPaymentRequest();
                },
                disable: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// Future<void> sendBookingData(
//   String psychonist_appointments_id,
//   String user_id,
//   String slip,
// ) async {
//   final path = ApiUrls.localhost;
//   final apiUrl = Uri.parse(
//       '$path/user/paymentrequest'); // เปลี่ยน YOUR_API_URL เป็น URL ของ API ของคุณ
//   final response = await http.post(
//     apiUrl,
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode({
//       'psychonist_appointments_id': psychonist_appointments_id,
//       'user_id': user_id,
//       'slip': slip,
//     }),
//   );

//   if (response.statusCode == 201) {
//     print('Booking successful');
//   } else {
//     print('Booking failed');
//     print('Error message: ${response.body}');
//   }
// }