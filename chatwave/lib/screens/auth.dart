import 'package:chatwave/widgets/user_img_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLogin = true;

  var _username = '';
  var _email = '';
  var _pass = '';
  File? _selectedImg;
  var _isAuth = false;
  final _form = GlobalKey<FormState>();

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || !_isLogin && _selectedImg == null) {
      return;
    }

    _form.currentState!.save();
    try {
      setState(() {
        _isAuth = true;
      });
      if (_isLogin) {
        final user_cred = await _firebase.signInWithEmailAndPassword(
            email: _email, password: _pass);
        print(user_cred);
      } else {
        final userCred = await _firebase.createUserWithEmailAndPassword(
            email: _email, password: _pass);
        final storage_ref = FirebaseStorage.instance
            .ref()
            .child('user_imgs')
            .child('${userCred.user!.uid}.jpg');
        await storage_ref.putFile(_selectedImg!);
        final imgUrl = await storage_ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCred.user!.uid)
            .set({
          'username': _username,
          'email': _email,
          'img_url': imgUrl,
          'pass': _pass,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication Failed'),
        ),
      );
      setState(() {
        _isAuth = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Theme.of(context).colorScheme.primary,
      backgroundColor: Color.fromARGB(255, 255, 250, 250),
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: EdgeInsets.only(top: 30, left: 20, right: 20),
              width: 350,
              child: Image.asset('assets/Chatwave.jpg'),
            ),
            Card(
              color: Color.fromARGB(255, 162, 217, 248),
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _form,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_isLogin)
                          UserImgPicker(
                            onPickImage: (img) {
                              _selectedImg = img;
                            },
                          ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'E-mail Address'),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter valid email address';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            _email = val!;
                          },
                        ),
                        if (!_isLogin)
                          TextFormField(
                            decoration: InputDecoration(labelText: 'UserName'),
                            autocorrect: false,
                            enableSuggestions: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().length < 4 ||
                                  value.isEmpty) {
                                return 'Please enter valid UserName (atleast 4 characters)';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              _username = val!;
                            },
                          ),
                        TextFormField(
                          enableSuggestions: false,
                          decoration: InputDecoration(labelText: 'Password'),
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Please enter atleast 6 characters';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          onSaved: (val) {
                            _pass = val!;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        if (!_isAuth)
                          ElevatedButton(
                            onPressed: _submit,
                            child: Text(
                              _isLogin ? 'Login' : "Sign up",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        if (_isAuth) CircularProgressIndicator(),
                        if (!_isAuth)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(
                              _isLogin
                                  ? "Create an Account"
                                  : 'I already have account',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                      ],
                    )),
              )),
            )
          ]),
        ),
      ),
    );
  }
}
