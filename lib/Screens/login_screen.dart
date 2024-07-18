import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorMessage = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _loginMethod() async {
    setState(() {
      _errorMessage = '';
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Fluttertoast.showToast(msg: "Login Successful!!");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        setState(() {
          _errorMessage = 'Invalid Credentials';
          Fluttertoast.showToast(msg: _errorMessage);
        });
      } else {
        setState(() {
          _errorMessage = 'An error occurred. Please try again.';
          Fluttertoast.showToast(msg: _errorMessage);
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
        Fluttertoast.showToast(msg: _errorMessage);
      });
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
                        customThemeButton("Login", () {
                          if (_formKey.currentState!.validate()) {
                            _loginMethod();
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
                                          builder: (context) =>
                                              SignupScreen()));
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
