import 'package:chatwave/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final real_user = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createAt', descending: true)
            .snapshots(),
        builder: (ctx, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return const Center(
              child: Text("No messages found"),
            );
          }
          final loaded_msg = snapshots.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
            reverse: true,
            itemCount: loaded_msg.length,
            itemBuilder: (ctx, index) {
              final chatMsg = loaded_msg[index].data();
              final next_msg = index + 1 < loaded_msg.length
                  ? loaded_msg[index + 1].data()
                  : null;

              final curr_user = chatMsg['userId'];
              final next_user = next_msg != null ? next_msg['userId'] : null;
              final nextUsersame = next_user == curr_user;

              if (nextUsersame) {
                return MessageBubble.next(
                    message: chatMsg['text'], isMe: real_user.uid == curr_user);
              } else {
                return MessageBubble.first(
                    userImage: chatMsg['userImg'],
                    username: chatMsg['username'],
                    message: chatMsg['text'],
                    isMe: real_user.uid == curr_user);
              }
            },
          );
        });
  }
}
