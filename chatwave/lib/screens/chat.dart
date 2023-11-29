import 'package:chatwave/widgets/chat_msg.dart';
import 'package:chatwave/widgets/new_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void helper() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();

    helper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 140, 230, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 161, 161),
        title: const Text(
          "CHAT🌊waves...",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.exit_to_app_rounded,
                color: Colors.red,
              ))
        ],
      ),
      body: const Column(children: [
        Expanded(
          child: ChatMessages(),
        ),
        NewMessage(),
      ]),
    );
  }
}
