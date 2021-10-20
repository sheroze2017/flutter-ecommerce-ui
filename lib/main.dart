import 'package:flutter/material.dart';
import 'package:hello/screens/welcome_screen.dart';
import 'package:hello/screens/login_screen.dart';
import 'package:hello/screens/registration.dart';
import 'package:hello/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            //   // theme: ThemeData.dark().copyWith(
            //   //   textTheme: TextTheme(
            //   //     bodyText1: TextStyle(color: Colors.black54),
            //   //   ),
            //   // ),

            debugShowCheckedModeBanner: false,
            initialRoute: WelcomeScreen.id,
            routes: {
              WelcomeScreen.id: (context) => WelcomeScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
              ChatScreen.id: (context) => ChatScreen(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );

    // // return
  }
}
