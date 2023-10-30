import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../components/button.dart';
import '../../utils/api_url.dart';
import '../screens/auth_page.dart';

class WriteInsurtion extends StatefulWidget {
  final int apppintmentID;
  final int patientID;
  final int senderID;
  const WriteInsurtion(
      {super.key,
      required this.apppintmentID,
      required this.patientID,
      required this.senderID});

  @override
  State<WriteInsurtion> createState() => _WriteInsurtionState();
}

class _WriteInsurtionState extends State<WriteInsurtion> {
  late String senderID = (widget.senderID).toString();
  late String userID = (widget.patientID).toString();
  late String appointtmentID = (widget.apppintmentID).toString();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    debugPrint('${widget.apppintmentID}');
    debugPrint('${widget.patientID}');
    debugPrint('${widget.senderID}');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'เขียนคำแนะนำ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // TextFormFields สำหรับหัวเรื่องและคำอธิบาย
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'หัวเรื่อง',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 150,
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'คำอธิบาย',
                    ),
                    maxLines: 5,
                  ),
                ),
              ),
              Button(
                width: double.infinity,
                title: 'Send',
                onPressed: () {
                  final path = ApiUrls.localhost;
                  final apiUrl = '$path/psychologist/writeinsurtion';
                  final data = {
                    'UserID': userID,
                    'PsychologistAppoinmentID': appointtmentID,
                    'Sender': senderID,
                    'FileName': titleController.text, // รับค่าจาก TextFormField หัวเรื่อง
                    'Description': descriptionController.text, // รับค่าจาก TextFormField คำอธิบาย
                  };
                  http.post(
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
            ],
          ),
        ),
      ),
    );
  }
}
