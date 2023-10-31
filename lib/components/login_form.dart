import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/components/loading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/utils/api_url.dart';
import 'package:get/get.dart';
import '../utils/config.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecuerPass = true;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    final path = ApiUrls.localhost;
    final api1Url = '$path/user/login';
    if (_emailController.text.isNotEmpty && _passController.text.isNotEmpty) {
      var regBody = {
        "Email": _emailController.text,
        "Password": _passController.text,
      };
      var response = await http.post(Uri.parse(api1Url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        var decodedToken = JwtDecoder.decode(myToken);
        if (decodedToken['role_id'] == 3) {
          Get.to(LoadingView(
            token: myToken,
            roleId: 3,
          ));
        } else if (decodedToken['role_id'] == 2) {
          Get.to(LoadingView(
            token: myToken,
            roleId: 2,
          ));
        } else {
          print('Unknown role');
        }
        saveToken(myToken);
      } else {
        print('Something went wrong');
      }
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
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passController, // แก้เป็น _passController
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
                      ),
              ),
            ),
          ),
          Config.spaceSmall,
          Button(
            width: double.infinity,
            title: 'Sign in',
            onPressed: () {
              loginUser();
            },
            disable: false,
          ),
        ],
      ),
    );
  }

  void saveToken(String token) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
