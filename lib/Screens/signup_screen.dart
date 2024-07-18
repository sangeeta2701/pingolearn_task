import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pingolearn_task/Screens/login_screen.dart';
import 'package:pingolearn_task/Widgets/sizedbox.dart';
import 'package:pingolearn_task/utils/colors.dart';
import 'package:pingolearn_task/utils/constant.dart';

import '../Widgets/customThemeButton.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void _signUpMethod() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Fluttertoast.showToast(msg: "Signup Successful!!");

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      print(e);
    }
  }

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
                  controller: emailController,
                  style: blackContentStyle,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter email";
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return "Enter Correct email";
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
                        customThemeButton("Signup", () {
                          if (_formKey.currentState!.validate()) {
                            _signUpMethod();
                          }
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: blackContentStyle,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text(
                                  "Login",
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
