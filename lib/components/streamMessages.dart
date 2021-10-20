// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:hello/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:hello/screens/chat_screen.dart';

// class streamMessage extends StatefulWidget {
//   const streamMessage({Key? key}) : super(key: key);

//   @override
//   streamMessageState createState() => streamMessageState();
// }

// class streamMessageState extends State<streamMessage> {
//   final Stream<QuerySnapshot> postStream =
//       FirebaseFirestore.instance.collection('messages').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('messages').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         return ListView.builder(itemBuilder: (context, i) {
//           QueryDocumentSnapshot x = snapshot.data!.docs[i];
//           return ListTile(
//             title: Text(x['text']),
//           );
//         });
//       },
//     );
//   }
// }
