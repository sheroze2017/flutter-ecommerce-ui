import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:hello/components/rounded_buttons.dart';
import 'package:hello/constants.dart';
import 'package:hello/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // void Login() async {
    //   // print("error");
    // }

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
                  onPressed: () async {
                    setState(() {
                      _showSpinner = true;
                    });
                    FirebaseAuth auth = FirebaseAuth.instance;

                    final String email = emailController.text;
                    final String password = passwordController.text;

                    try {
                      final user = await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        _showSpinner = false;
                      });
                    } catch (e) {}
                  },
                  child: Text("Login"),
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
