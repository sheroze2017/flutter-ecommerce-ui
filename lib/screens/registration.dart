import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/screens/chat_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _showSpinner = false;
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void register() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String email = emailController.text;
      final String password = passwordController.text;
      setState(() {
        _showSpinner = true;
      });
      try {
        final user = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // db.collection("users").doc(user.user!.uid).set({
        //   "email": email,
        //   "password": password,
        // });
        if (user != null) {
          Navigator.pushNamed(context, ChatScreen.id);
        }
        setState(() {
          _showSpinner = false;
        });
      } catch (e) {}
      print(e);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: _showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'hey',
                  child: Container(
                    child: Image.asset(
                      "assets/images/hey.png",
                      // fit: BoxFit.contain,
                      height: 150,
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  controller: emailController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                ElevatedButton(
                  onPressed: register,
                  child: Text("Register"),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
