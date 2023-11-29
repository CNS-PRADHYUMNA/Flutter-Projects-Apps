import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _msgCtrl = TextEditingController();

  @override
  void dispose() {
    _msgCtrl.dispose();
    super.dispose();
  }

  void submitMsg() async {
    final emsg = _msgCtrl.text;
    print(emsg);
    if (emsg.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    _msgCtrl.clear();
    final user1 = FirebaseAuth.instance.currentUser!;
    final userDate = await FirebaseFirestore.instance
        .collection('users')
        .doc(user1.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': emsg,
      'createAt': Timestamp.now(),
      'userId': user1.uid,
      'username': userDate.data()!['username'],
      'userImg': userDate.data()!['img_url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _msgCtrl,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: 'Send a Message ...'),
            ),
          ),
          IconButton(
              onPressed: submitMsg,
              icon: Icon(
                Icons.send,
              ))
        ],
      ),
    );
  }
}
