import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/view/screens/otp_page.dart';
import 'package:flutter_application_1/view/screens/auth_page.dart'; 
import 'package:flutter_application_1/utils/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:email_otp/email_otp.dart';

import '../utils/config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passController = TextEditingController();
  final _phoneController = TextEditingController();
  final _confirmpassController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdayController = TextEditingController();
  bool obsecuerPass = true;

  EmailOTP myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person),
              prefixIconColor: Config.primaryColor,
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Empty';
              }
              return null;
            },
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Empty';
              }
              return null;
            },
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _firstNameController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'First Name',
              labelText: 'First Name',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_2),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _lastNameController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Last Name',
              labelText: 'Last Name',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_2),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Phonenumber',
              labelText: 'TEL.',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.phone),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecuerPass,
            decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.lock_outline),
                prefixIconColor: Config.primaryColor,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecuerPass = !obsecuerPass;
                      });
                    },
                    icon: obsecuerPass
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: Config.primaryColor,
                          ))),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Empty';
              }
              return null;
            },
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _confirmpassController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecuerPass,
            decoration: InputDecoration(
                hintText: 'Retype-Password',
                labelText: 'Retype-Password',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.lock_outline),
                prefixIconColor: Config.primaryColor,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecuerPass = !obsecuerPass;
                      });
                    },
                    icon: obsecuerPass
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: Config.primaryColor,
                          ))),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Empty';
              } else if (val != _passController.text) {
                return 'password not match';
              }
              return null;
            },
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _birthdayController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'YYYY-MM-DD',
              labelText: 'BirthDay',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.cake),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          Button(
            width: double.infinity,
            title: 'Sign Up',
            onPressed: () async {
              myauth.setConfig(
                  appEmail: "me@rohitchouhan.com",
                  appName: "Email OTP",
                  userEmail: _emailController.text,
                  otpLength: 6,
                  otpType: OTPType.digitsOnly
                  );
              bool pass = _formKey.currentState!.validate();
              if (pass) {
                String userName = _usernameController.text;
                String birthDay = _birthdayController.text;
                String email = _emailController.text;
                String firstName = _firstNameController.text;
                String lastName = _lastNameController.text;
                String password = _passController.text;
                String tel = _phoneController.text;

                final path = ApiUrls.localhost;
                final api1Url = '$path/user/register';
                var url = Uri.parse(api1Url);

                var response = await http.post(url, body: {
                  'UserName': userName,
                  'Birthday': birthDay,
                  'Email': email,
                  'FirstName': firstName,
                  'LastName': lastName,
                  'Password': password,
                  'Tel': tel,
                });

                if (response.statusCode == 200) {
                  // สามารถใช้ response.body เพื่อดึงข้อมูลที่ได้จาก API
                  print('API Response: ${response.body}');
                } else {
                  print(
                      'Error calling API. Status code: ${response.statusCode}');
                }
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AuthPage()),
                );
              }
            },
            disable: false,
          ),
        ],
      ),
    );
  }
}
