import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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
  bool obsecuerPass = true;

  Future sign_up() async {
    String url = "http://10.1.205.31/my_project_backend/register.php";
    final response = await http.post(Uri.parse(url), body: {
      'user_name': _usernameController.text,
      'user_password': _passController.text,
      'user_email': _emailController.text,
      'user_phone': _phoneController.text,
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      Navigator.pushNamed(context, 'register');
    } else {
      Navigator.pushNamed(context, 'auth');
    }
  }

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
          Button(
              width: double.infinity,
              title: 'Sign Up',
              onPressed: () {
                bool pass = _formKey.currentState!.validate();
                if (pass) {
                  sign_up();
                }
              },
              disable: false),
        ],
      ),
    );
  }
}
