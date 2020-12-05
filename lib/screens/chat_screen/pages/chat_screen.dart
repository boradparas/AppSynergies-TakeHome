import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/helpers/auth_helper.dart';

import '../../../core/utils/constants.dart';
import '../../welcome_screen/pages/welcome_screen.dart';
import '../widgets/message_bubble.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  _auth.signOut();
                  AuthHelper.setAuthState(false);
                  Navigator.popAndPushNamed(context, WelcomeScreen.id);
                }),
          ],
          title: const Text('Group Chat'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const MessagesStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        messageTextController.clear();
                        if (messageText != null && messageText.isNotEmpty) {
                          _firestore.collection('messages').add({
                            'text': messageText,
                            'sender': loggedInUser.email,
                            "timestamp": Timestamp.now().microsecondsSinceEpoch,
                          });
                        }
                      },
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('messages').orderBy("timestamp").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (final message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];

          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            sender: messageSender as String,
            text: messageText as String,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
