// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
// import 'package:hello/components/streamMessages.dart';
import 'package:hello/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      // ignore: await_only_futures
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   FirebaseFirestore.instance
  //       .collection('messages')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       print(doc['text']);
  //     });
  //   });
  // }

  void messagesStream() async {
    await for (var snap in _firestore.collection('messages').snapshots()) {
      for (var message in snap.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                // _auth.signOut();
                // Navigator.pop(context);
                messagesStream();
              }),
        ],
        title: Text("FLASH CHAT"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FutureBuilder<QuerySnapshot>(
              // <2> Pass `Future<QuerySnapshot>` to future
              future: FirebaseFirestore.instance.collection('messages').get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return Expanded(
                    child: ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20),
                        shrinkWrap: true,
                        children: documents
                            .map((doc) => Card(
                                  child: ListTile(
                                    title: Text(doc['text']),
                                    subtitle: Text(doc['sender']),
                                  ),
                                ))
                            .toList()),
                  );
                } else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // message text + sender
                      _firestore.collection('messages').add(
                          {'text': messageText, 'sender': loggedInUser.email});
                    },
                    child:
                        Text('Send', style: TextStyle(color: Colors.blueGrey)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
