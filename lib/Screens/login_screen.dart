import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingolearn_task/Screens/home_screen.dart';
import 'package:pingolearn_task/Screens/signup_screen.dart';
import 'package:pingolearn_task/Widgets/sizedbox.dart';
import 'package:pingolearn_task/utils/colors.dart';
import 'package:pingolearn_task/utils/constant.dart';

import '../Widgets/customThemeButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MyNews",
                  style: blueHeadingStyle,
                ),
                height150,
                TextFormField(
                  controller: usernameController,
                  style: blackContentStyle,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp(r'[a-zA-Z]+|\s'),
                        allow: true)
                  ],
                  decoration: InputDecoration(hintText: "Username"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter username";
                    }
                    if (value.length < 3) {
                      return "Username can't be less than 3 characters";
                    }
                    if (value.length > 20) {
                      return "Username can't be more  than 20 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                height20,
                TextFormField(
                  controller: passwordController,
                  style: blackContentStyle,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(hintText: "Password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                    if (value.length < 5) {
                      return "Password can't be less than 5 characters";
                    }
                    if (value.length > 15) {
                      return "Password can't be more  than 15 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                height150,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customThemeButton("Login",(){
                          if(_formKey.currentState!.validate()){
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                          }
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New here?",
                              style: blackContentStyle,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignupScreen()));
                                },
                                child: Text(
                                  "Signup",
                                  style: blueButtonStyle,
                                ))
                          ],
                        )
                      ]),
                ),
              ],
            ),
                    ),
                  ),
          )),
    );
  }
}
